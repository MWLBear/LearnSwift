//
//  RXUIViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/9/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 
     RxSwift 是一个用于与 Swift 语言交互的框架，但它只是基础，并不能用来进行用户交互、网络请求等。
     
     而 RxCocoa 是让 Cocoa APIs 更容易使用响应式编程的一个框架。RxCocoa 能够让我们方便地进行响应式网络请求、响应式的用户交互、绑定数据模型到 UI 控件等等。而且大多数的 UIKit 控件都有响应式扩展，它们都是通过 rx 属性进行使用。


 */





struct UserViewModel {
    let username = Variable("guest")
    lazy var userinfo = {
        return self.username.asObservable()
            .map{$0 == "apple" ? "你是管理员" : "你是访客"}
            .share(replay: 1)
    }()
    
}


class RXUIViewController: UIViewController {

    let disposeBag = DisposeBag()
    

    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var datapicker: UIDatePicker!
    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var myswitch: UISwitch!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var steper: UIStepper!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var actuvity: UIActivityIndicatorView!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    let leftTime = Variable(TimeInterval(180))
    let countDownStopped = Variable(true)
    
    
    lazy var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        return formatter
    }()
    
    var userVM = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer_example()
    }
    
    func rx_uilabel() {
        
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 500, height: 100))
        view.addSubview(label)
        
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        timer.map {String(format: "%0.2d:%0.2d.%0.1d",
//            arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10])}
//            .bind(to: label.rx.text)
//        .disposed(by: disposeBage)
        
        timer.map(formatTimeInterval(ms:)).bind(to: label.rx.attributedText).disposed(by: disposeBag)
        
    }

    func formatTimeInterval(ms:NSInteger) -> NSMutableAttributedString {
        
        let string = String(format: "%0.2d:%0.2d.%0.1d",
        arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        
        let attributeString = NSMutableAttributedString(string: string)
        
        attributeString.addAttribute(NSAttributedString.Key.font,
                                         value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                         range: NSMakeRange(0, 5))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor,
                                           value: UIColor.red, range: NSMakeRange(0, 5))
        
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor,
                                            value: UIColor.orange, range: NSMakeRange(0, 5))
        
        return attributeString
        
    }
    
    
    func rx_uitextfield() {
     
        let textField = UITextField(frame: CGRect(x: 10, y: 80, width: 200, height: 30))
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        
        
        
        /**
         Throttling 的作用：
         Throttling 是 RxSwift 的一个特性。因为有时当一些东西改变时，通常会做大量的逻辑操作。而使用 Throttling 特性，不会产生大量的逻辑操作，而是以一个小的合理的幅度去执行。比如做一些实时搜索功能时，这个特性很有用。

         */
        let outputField =  UITextField(frame: CGRect(x: 10, y: 120, width: 200, height: 30))
        outputField.borderStyle = .roundedRect
        view.addSubview(outputField)
               
        let label = UILabel(frame:CGRect(x:10, y:180, width:300, height:30))
        self.view.addSubview(label)
        
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:230, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
             
        
//        textField.rx.text.orEmpty.changed.subscribe(onNext:{
//            print("你的输入是:\($0)")
//            }).disposed(by: disposeBage)
       
        
        let input = textField.rx.text.orEmpty.asDriver().throttle(0.3)
       
        input.drive(outputField.rx.text)
            .disposed(by: disposeBag)
        
        input.map { "当前字数:\($0.count)"}
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        input.map{$0.count > 5}
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
    }
    
    
    func rx_uitextfield1() {
    
        let texfField1 = UITextField(frame: CGRect(x: 20, y: 50, width: 200, height: 30 ))
        texfField1.placeholder = "区号"
        let texfField2 = UITextField(frame: CGRect(x: 20, y: 90, width: 200, height: 30 ))
        texfField2.placeholder = "号码"
        
        texfField1.borderStyle = .roundedRect
        texfField2.borderStyle = .roundedRect

        view.addSubview(texfField1)
        view.addSubview(texfField2)
        
        
        let label = UILabel(frame:CGRect(x:10, y:150, width:300, height:30))
        self.view.addSubview(label)

        
        Observable.combineLatest(texfField1.rx.text.orEmpty
        , texfField2.rx.text.orEmpty) { (value1, value2) -> String in
            return "你输入的号码是:\(value1)-\(value2)"
        }
        .map{$0}
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        
        texfField1.rx.controlEvent([.editingDidEndOnExit])
            .subscribe(onNext:{
                texfField2.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        
        texfField2.rx.controlEvent([.editingDidEndOnExit])
            .subscribe(onNext:{
                texfField2.resignFirstResponder()
            }).disposed(by: disposeBag)
    }
    
    
    func rx_uitextview() {
        
        let textView = UITextView(frame: CGRect(x: 20, y: 100, width: 300, height: 300))
        textView.layer.borderWidth = 2.0
        view.addSubview(textView)
        
        //开始编辑响应
        textView.rx.didBeginEditing
            .subscribe(onNext: {
                print("开始编辑")
            })
            .disposed(by: disposeBag)
        
        //结束编辑响应
        textView.rx.didEndEditing
            .subscribe(onNext: {
                print("结束编辑")
            })
            .disposed(by: disposeBag)
        
        //内容发生变化响应
        textView.rx.didChange
            .subscribe(onNext: {
                print("内容发生改变")
            })
            .disposed(by: disposeBag)
        
        //选中部分变化响应
        textView.rx.didChangeSelection
            .subscribe(onNext: {
                print("选中部分发生变化")
            })
            .disposed(by: disposeBag)
    }
    
    func rx_uibutton() {
        
        let btn = UIButton(frame: CGRect(x: 10, y: 20, width: 200, height: 50))
        
        //btn.setTitle("按钮", for: .normal)
//        btn.setTitleColor(.black, for: .normal)
        view.addSubview(btn)
        
//        btn.rx.tap.subscribe(onNext:{ [weak self] in
//            self?.showMessage("按钮被点击")
//            }).disposed(by: disposeBag)
        
        btn.rx.tap.bind { [weak self] in
            self?.showMessage("按钮被点击")
        }.disposed(by: disposeBag)
        
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
//        timer.map{"计数\($0)"}.bind(to: btn.rx.title(for: .normal)).disposed(by: disposeBag)
        
        timer.map(formatTimeInterval(ms:))
            .bind(to: btn.rx.attributedTitle())
            .disposed(by: disposeBag)
        
        
//        timer.map({
//            let name = $0%2 == 0 ? "back":"forward"
//            return UIImage(named: name)!
//        })
//            .bind(to: btn.rx.image())
//            .disposed(by: disposeBag)
//
//        timer.map{ UIImage(named: "\($0%2)")! }
//            .bind(to: btn.rx.backgroundImage())
//            .disposed(by: disposeBag)
        
        let swich = UISwitch()
        view.addSubview(swich)
        swich.rx.isOn
            .bind(to: btn.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    func rx_btn_select() {
        
        let btns = [b1 ,b2,b3].map{$0!}
        
        let selectedButton = Observable.from(btns)
            .map{btn in btn.rx.tap.map{btn}}
            .merge()
        
        
        for b in btns {
            selectedButton.map{$0 == b}
                .bind(to: b.rx.isSelected)
                .disposed(by: disposeBag)
        }
        
        

    }
    
    
    func showMessage(_ text:String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func segmented() {
        let showImageObservable: Observable<String> =
            segment.rx.selectedSegmentIndex.asObservable().map {
                return "点击了第:\($0)个"
        }
        
        showImageObservable.subscribe(onNext:{print($0)}).disposed(by: disposeBag)
        
    }
    
    
    //
    
    func uiactivityIndicatorView() {
        myswitch.rx.value.bind(to: actuvity.rx.isAnimating).disposed(by: disposeBag)
        
        myswitch.rx.value.bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
    }
    
    
    func uislider()  {
//        slider.rx.value.asObservable()
//            .subscribe(onNext:{print("当前值:\($0)")})
//            .disposed(by: disposeBag)
//
        
        slider.rx.value.map{Double($0)}
            .bind(to: steper.rx.stepValue)
            .disposed(by: disposeBag)
        
//        steper.rx.value.asObservable().subscribe(onNext:{print("当前值:\($0)")})

        
    }
    
    
    
    
    func rx_doubleBinding() {
        
        userVM.username.asObservable().bind(to: textfield.rx.text).disposed(by: disposeBag)
        textfield.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
        
       // _ = self.textfield.rx.textInput <-> self.userVM.username

        userVM.userinfo.bind(to: mylabel.rx.text).disposed(by: disposeBag)
    }

    
    /**
     
     
     */
   
    func swipe() {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        swipe.rx.event.subscribe(onNext:{
            [weak self] recognizer in
            let point = recognizer.location(in: recognizer.view)
            self?.showMessage("滑动了:\(point.x)-\(point.y)")
        })
        .disposed(by: disposeBag)
     
        
        let tap = UITapGestureRecognizer()
        view.addGestureRecognizer(tap)
        
        tap.rx.event.subscribe(onNext:{
            [weak self] _ in
            self?.view.endEditing(true)
            }).disposed(by: disposeBag)
        
    }
    
    
    func datapikcer()  {
        
        datapicker.rx.date
            .map { [weak self] in
                "当前选择时间: " + self!.dateFormatter.string(from: $0)
        }
        .bind(to: self.mylabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    
    func timer_example() {
        
        
        start.setTitleColor(.red, for: .normal)
        start.setTitleColor(.darkGray, for: .disabled)
        
        
        //剩余时间与datepicker做双向绑定
        DispatchQueue.main.async {
            
            self.datapicker.rx.countDownDuration.bind(to: self.leftTime).disposed(by: self.disposeBag)
            
            self.leftTime.asObservable().bind(to: self.datapicker.rx.countDownDuration).disposed(by: self.disposeBag)
            
        }
        
        Observable.combineLatest(leftTime.asObservable(), countDownStopped.asObservable() ) {
            leftTimeValue, countDownStoppedValue  in
            if countDownStoppedValue{
                return "开始"
            }else{
                return "倒计时开始,还有\(Int(leftTimeValue))秒..."
            }
        }.bind(to: start.rx.title())
        .disposed(by: disposeBag)
        
        
        countDownStopped.asDriver().drive(datapicker.rx.isEnabled).disposed(by: disposeBag)
        countDownStopped.asDriver().drive(start.rx.isEnabled).disposed(by: disposeBag)
        
        start.rx.tap.bind { [weak self]  in
            self?.startClick()
        }.disposed(by: disposeBag)
        
    }
    
    func startClick() {
        self.countDownStopped.value = false
        
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .takeUntil(countDownStopped.asObservable().filter{$0})
            .subscribe { (event) in
                
                self.leftTime.value -= 1
                if self.leftTime.value == 0{
                    print("倒计时结束")
                    self.countDownStopped.value = true
                    self.leftTime.value = 180
                }
                
        }.disposed(by: disposeBag)
        
    }
    
}

