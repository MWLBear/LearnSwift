//
//  RoleView.swift
//  sanguocount
//
//  Created by admin on 2021/11/3.
//

import UIKit
import WebKit
import SVProgressHUD

class RoleNode: UIView {
    lazy var role: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.preferences.javaScriptEnabled = true
        configuration.suppressesIncrementalRendering = true
        configuration.allowsAirPlayForMediaPlayback = true
        configuration.preferences.javaScriptEnabled = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        let wkView = WKWebView(frame: UIScreen.main.bounds, configuration: configuration)
        wkView.scrollView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            wkView.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
        }
        wkView.navigationDelegate = self
        wkView.uiDelegate = self
        wkView.isOpaque = false
        return wkView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(role)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadRoleData(data:String){
        guard let url = URL(string: data) else {  return }
        role.load(URLRequest(url: url))
        SVProgressHUD.show()
    }
}

extension RoleNode:  WKNavigationDelegate, WKUIDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let gurl = navigationAction.request.url else {
            return
        }
        let url = gurl.absoluteString
        let ary = url.components(separatedBy: "://")
        let str = ary[0] as NSString
        if str.isEqual(to: "file") {
            decisionHandler(.allow)
        } else if str.isEqual(to: "https") || str.isEqual(to: "http") {
            decisionHandler(.allow)
        } else {
            if !url.contains("about:black") {
                UIApplication.shared.open(gurl, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}
