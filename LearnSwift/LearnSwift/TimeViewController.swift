//
//  TimeViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/4/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {

    var ctimer:UIDatePicker!
    var btnstar:UIButton!
    var leftTime:Int = 120
    var alertController:UIAlertController!
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ctimer = UIDatePicker(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        self.ctimer.datePickerMode = .countDownTimer
        self.ctimer.countDownDuration = TimeInterval(leftTime)
        self.ctimer.addTarget(self, action: #selector(ctimerClick), for: .valueChanged)
        self.view.addSubview(self.ctimer)
        
        
        btnstar = UIButton(type: .custom)
        btnstar.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        btnstar.setTitleColor(UIColor.red, for: .normal)
        btnstar.setTitleColor(UIColor.green, for:.disabled)
        btnstar.setTitle("开始", for: .normal)
        btnstar.setTitle("倒计时中...", for: .disabled)
        btnstar.addTarget(self, action:#selector(TimeViewController.startClicked),
                                  for:.touchUpInside)
        self.view.addSubview(btnstar)
        
    }
    
    @objc func ctimerClick(){
        print("您选择倒计时间为：\(self.ctimer.countDownDuration)")
    }
    @objc func startClicked(sender:UIButton)
      {
          self.btnstar.isEnabled = false
           
          // 获取该倒计时器的剩余时间
          leftTime = Int(self.ctimer.countDownDuration);
          // 禁用UIDatePicker控件和按钮
          self.ctimer.isEnabled = false
           
          // 创建一个UIAlertController对象（警告框），并确认，倒计时开始
          alertController = UIAlertController(title: "系统提示",
                                              message: "倒计时开始，还有 \(leftTime) 秒...",
                                              preferredStyle: .alert)
          let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
          alertController.addAction(cancelAction)
          // 显示UIAlertController组件
          self.present(alertController, animated: true, completion: nil)
           
          // 启用计时器，控制每秒执行一次tickDown方法
          timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target:self,
                                       selector:#selector(TimeViewController.tickDown),
                                       userInfo:nil,repeats:true)
      }
    
    /**
     *计时器每秒触发事件
     **/
    @objc func tickDown()
    {
        alertController.message = "倒计时开始，还有 \(leftTime) 秒..."
        // 将剩余时间减少1秒
        leftTime -= 1;
        // 修改UIDatePicker的剩余时间
        self.ctimer.countDownDuration = TimeInterval(leftTime);
        print(leftTime)
        // 如果剩余时间小于等于0
        if(leftTime <= 0)
        {
            // 取消定时器
            timer.invalidate();
            // 启用UIDatePicker控件和按钮
            self.ctimer.isEnabled = true;
            self.btnstar.isEnabled = true;
            alertController.message = "时间到！"
        }
    }
}
