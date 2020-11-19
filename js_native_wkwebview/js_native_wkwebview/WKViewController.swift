//
//  WKViewController.swift
//  web_wk
//
//  Created by admin on 2020/9/16.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import WebKit
import AdSupport
import CloudKit

let filename = "robberrun"
class WKViewController: UIViewController {

    var wkWebView:WKWebView!
    let base = OpenTool()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        let data = [1, 2, 3, 4, 5]
        
        let dataStr = data.map(String.init)
        
        let result = dataStr.joined(separator: ",")
        print("数组转字符串:\(result)")
        
        
        
//        let c = a.joined(separator: "")
//        print(c)

        if BaseTool.data() {
             
        }
         addView()
        
    }
    
    

    func addView() {
        
        
        //h5调用native
        let userContent = WKUserContentController()
        userContent.add(self, name: "JSCallOCDEBUGLog")
        userContent.add(self, name: "JSCallOCStartGame")
        var s = "document.documentElement.style.webkitTouchCallout='none';"
        s.append("document.documentElement.style.webkitUserSelect='none';")
        let script = WKUserScript.init(source: s, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        userContent.addUserScript(script)
      
        
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true;
        configuration.preferences.javaScriptEnabled = true;
        configuration.suppressesIncrementalRendering = true;
        configuration.allowsAirPlayForMediaPlayback = true;
        configuration.mediaTypesRequiringUserActionForPlayback = .all;
        configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs");
        
        configuration.userContentController = userContent
        
        self.wkWebView = WKWebView(frame: self.view.frame ,configuration: configuration)
        self.view.addSubview(self.wkWebView)
        
    
        self.wkWebView.navigationDelegate = self
        self.wkWebView.uiDelegate = self
        

//        self.load1()
//        self.load2()
//        self.load3()

//        getrobbrun()
        
        loadgoodindex()
//        OpenBase.base("https://www.baidu.com/")

    }
    
  
    
    
    func loadgoodindex()  {
        
        let filePath = Bundle.main.path(forResource: "good.html", ofType: "", inDirectory: filename)
        let baseUrl = Bundle.main.bundleURL.appendingPathComponent(filename)
        let fileUrl = URL(fileURLWithPath: filePath!)
        
        
        self.wkWebView.loadFileURL(fileUrl, allowingReadAccessTo: baseUrl)
    }
    
    
    func getrobbrun()->URL {
        let filePath = Bundle.main.path(forResource: "index.html", ofType: "", inDirectory: "robberrun")
        let fileUrl = URL(fileURLWithPath: filePath!)
        return fileUrl
    }
    
    func load1() {
        
        let fileUrl = Bundle.main.url(forResource: "info1", withExtension: "html")
        self.wkWebView.load(URLRequest(url: fileUrl!))
        
    }
    
    func load2() {
        
        let filePath = Bundle.main.path(forResource: "info", ofType: "html")
        let contents = try? String(contentsOfFile:filePath!)
        let baseUrl = Bundle.main.bundleURL
        
        self.wkWebView.loadHTMLString(contents!, baseURL: baseUrl)
        
    }
    
    func load3() {
        
        let fileUrl = Bundle.main.url(forResource: "info", withExtension: "html")
        let baseUrl = Bundle.main.bundleURL

        self.wkWebView.loadFileURL(fileUrl!, allowingReadAccessTo: baseUrl)
    }
    
   

}
extension WKViewController:WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate{
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print("body: \(message.body)")
        print("name: \(message.name)")
        

        if message.name == "JSCallOCDEBUGLog" {
            
            print("JSCallOCDEBUGLog: \(message.body)")
            
        }else if message.name == "JSCallOCStartGame"{
            
            let data = message.body as! [String:String]
            
            print("JSCallOCStartGame: \(data)")
       
//            OpenBase.base(u)


        }
    }
    
    //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
   
    // 输入框
    //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        
    }
    
    /**
       *  web界面中有弹出警告框时调用
       *
       *  @param webView           实现该代理的webview
       *  @param message           警告框中的内容
       *  @param completionHandler 警告框消失调用
       */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    

    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url?.absoluteString;
        
        print("url:\(url!)")
        let ary = url?.components(separatedBy: "://")
        let str = ary![0] as NSString;
        if str.isEqual(to: "file")  {
            decisionHandler(.allow)
        }
        else if str.isEqual(to: "https")||str.isEqual(to: "http") {
            decisionHandler(.allow)
            
        }else {
           
            if !url!.contains("about:black") {
                OpenTool.base(url!)
                decisionHandler(.cancel)
            }else{
                decisionHandler(.allow)
            }
        }
    }
    
    //进程被终止时调用
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    
      // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        let js = "DoFunctionParameter('\(idfa)')"
        print("js:\(js)")
       // webView.evaluateJavaScript(js, completionHandler: nil)
        
    }
    
    func loadinex(_ webView:WKWebView) {
        
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        
        if timeStamp > 1600531200 {
            
            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            let js = "loadGame('https://mock.yonyoucloud.com/mock/8433/ggo'" + ",'1345'," + "'\(idfa)'" + ")"
            webView.evaluateJavaScript(js, completionHandler: nil)
            
        }else{
            
            let url = self.getrobbrun()
            let js = "gameStart('\(url)')"
            webView.evaluateJavaScript(js, completionHandler: nil)
            
        }
    }
    
    
    func webView(_ webView: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
        
        completionHandler(.useCredential,nil)
    }
    
    //当一个正在提交的页面在跳转过程中出现错误时调用这个方法。
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
      //  启动时加载数据发生错误就会调用这个方法
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    
}
