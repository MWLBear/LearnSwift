//
//  RxSession.swift
//  LearnSwift
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class RxSession: NSObject {

   static func requset(){
        
        let disposeBag = DisposeBag()
        
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string:urlString)
        //创建请求对象
        let request = URLRequest(url: url!)
        
        URLSession.shared.rx.response(request: request).subscribe(onNext: { (response, data) in
            let str = String(data: data, encoding: String.Encoding.utf8)
            print("返回的数据是：", str ?? "")
        }).disposed(by: disposeBag)
        
    }
}
