//
//  UIWebViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/4/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class UIWebViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建一个浏览器工具条，并设置它的大小和位置
        let browserToolbar =  UIToolbar(frame:CGRect(x:0, y:20, width:320, height:44))
        // 将工具条添加到当前应用的界面中
        self.view.addSubview(browserToolbar)
        
        let btn1 =  UIBarButtonItem(barButtonSystemItem:.compose,
                                    target:nil, action:nil);
        let btn2 =  UIBarButtonItem(barButtonSystemItem:.add,
                                    target:nil, action:nil);
        let btn3 =  UIBarButtonItem(barButtonSystemItem:.flexibleSpace,
                                    target:nil, action:nil);
        let btn4 =  UIBarButtonItem(barButtonSystemItem:.reply,
                                    target:nil, action:nil);
        
        browserToolbar.setItems([btn1,btn2,btn3,btn4], animated: false)
    }
    
}
