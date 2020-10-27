//
//  AlamofireTool.swift
//  LearnSwift
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class AlTool {

    let disposeBag = DisposeBag()
    
    
    func get() {
        
//        AF.request("https://httpbin.org/get").response { (response) in
//
//        }
        
        struct Login: Encodable {
            let email: String
            let password: String
        }

        let login = Login(email: "test@test.test", password: "testPassword")

        AF.request("https://httpbin.org/post",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        }
        
        
    }
    
    func rxdata() {
        
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
        
        request(.get, url)
            .data()
            .subscribe(onNext: { (data) in
                //josn转换
                
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("--- 请求成功！返回的如下数据 ---")
                print(json as! [String:Any])
                
//                let str = String(data: data, encoding: .utf8)
//                print(str ?? "")
            },onError: {error in
                print("error :\(error.localizedDescription)")
            })//.disposed(by: disposeBag)
        
    }
    
    
    func re_resquest_json() {
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)!
      
        requestJSON(.get, url)
            .subscribe(onNext: { (response, data) in
              let json =   data as! [String:Any]
                print(json)
            })
    }
    
    
    //rxalamofire下载
    
    func uploadFile(disposeBag:DisposeBag) {
        
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
        //服务器路径
        let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
         
        //将文件上传到服务器
        upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL))
            .subscribe(onNext: { element in
                print("--- 开始上传 ---")
                element.uploadProgress(closure: { (progress) in
                    print("当前进度：\(progress.fractionCompleted)")
                    print("  已上传载：\(progress.completedUnitCount/1024)KB")
                    print("  总大小：\(progress.totalUnitCount/1024)KB")
                })
            }, onError: { error in
                print("上传失败! 失败原因：\(error)")
            }, onCompleted: {
                print("上传完毕!")
            })
            .disposed(by: disposeBag)
        
        
        
    }
    
   
    func downFile(disposBag:DisposeBag,progressview:UIProgressView) {
        
        let destination: DownloadRequest.Destination = {_,response in
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileUrl = documentsURL.appendingPathComponent(response.suggestedFilename!)
            
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileUrl,[.removePreviousFile,.createIntermediateDirectories])
            
        }
        
        
        let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!

//        download(URLRequest(url: fileURL), to: destination).subscribe(onNext: { (element) in
//            element.downloadProgress { (progress) in
//                print("当前进度: \(progress.fractionCompleted)")
//                print("  已下载：\(progress.completedUnitCount/1024)KB")
//                print("  总大小：\(progress.totalUnitCount/1024)KB")
//            }
//
//
//        }, onError: { (error) in
//            print("error:\(error)")
//        }, onCompleted: {
//            print("下载完成")
//            }).disposed(by: disposBag)
//

        download(URLRequest(url: fileURL), to: destination).map { (request) in
            Observable<Float>.create { (observer) -> Disposable in
                
                
                request.downloadProgress { (progress) in
                    observer.onNext(Float(progress.fractionCompleted))
                    if progress.isFinished{
                        observer.onCompleted()
                    }
                }
                return Disposables.create()
            }
        }
        .flatMap{$0}
        .bind(to: progressview.rx.progress)
        .disposed(by: disposBag)
        
        
    }
    
    
    
    
    
}
