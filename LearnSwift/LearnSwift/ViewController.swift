//
//  ViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/3/25.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit




// 运算符重载
struct CenterPointer{
    var x = 0,y = 0
    
}
//重载+号运算符
func + (left:CenterPointer,right:CenterPointer)->CenterPointer{
    return CenterPointer(x: left.x+right.x, y: left.y+right.y)
}

func == (left:CenterPointer,right:CenterPointer) -> Bool {
    return (left.x == right.x)&&(left.y == right.y)
}

func += (left: inout CenterPointer,right:CenterPointer){
    left = left+right
}



class ViewController: UIViewController {

    var pickerView : UIPickerView!
    var stepper:UIStepper!
    var label:UILabel!
    var scrollView:UIScrollView!
    
    let numOfPages = 3
    let pageWidth = Int(UIScreen.main.bounds.size.width)
    let pageHeight = 360
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.addBtn()
        //self.数据类型()
        //self.区间运算符()
        //self.运算符重载()
        //self.复杂数据类型之数组()
        //self.复杂数据类型之字典()
       //self.属性观察者()
        
//        File().文件()
        //self.uilabel()
        
        //self.uitextFiled()
        //self.uitextView()
        //uisgementcontrol()
        //uiprogressview()
        
        //uislider()
        //uipickerview()
        
        //uistepper()
        //uiscrollview()
        
        uiscrollview_1()
    }

//    UIButton 使用
    func addBtn() {
        let button = UIButton()
        button.frame = CGRect(x: 10, y: 150, width: 100, height: 30)
        button.setTitle("欢迎访问\napple.com", for: .normal)
//        button.setTitle("普通状态", for:.normal) //普通状态下的文字
        button.setTitle("触摸状态", for:.highlighted) //触摸状态下的文字
        button.setTitle("禁用状态", for:.disabled) //禁用状态下的问题
        
        button.setTitleColor(UIColor.black, for: .normal) //普通状态下文字的颜色
        button.setTitleColor(UIColor.green, for: .highlighted) //触摸状态下文字的颜色
        button.setTitleColor(UIColor.gray, for: .disabled) //禁用状态下文字的颜色
        
        
        button.setTitleShadowColor(.black, for: .normal)
        button.setTitleShadowColor(.gray , for: .highlighted)
        button.setTitleShadowColor(.green, for: .disabled)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        
//        button.backgroundColor = .black
        
        
        let image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(btn( _:)), for: .touchUpInside)
        self.view.addSubview(button)
        

    }
    @objc func btn(_ button:UIButton)  {
        print("点击了按钮")
    }

    func 数据类型() {
        
    }
    
    func 区间运算符() {
        
        let words = "Hangge.com"
        
        let range = words.index(words.startIndex, offsetBy: 4)..<words.index(words.startIndex, offsetBy: 6)
        let rangeS = words.substring(with: range)
        
        print(rangeS)
        
    }
    
    func 运算符重载() {
        
        var pointer = CenterPointer(x: 2, y: 3)
        let pointere2 = CenterPointer(x: 3, y: 4)
        
        pointer += pointere2
        
        print(pointer)
        
    }
    
    func 复杂数据类型之数组(){
        
        var types = ["none","warning","error"]
        var members = [String]()
        
        members.append("six")
        members += ["seven"]
        members.insert("one", at: 0)
        members[0] = "message"
        members[0...2] = ["message","lol","apple"]
        members.count
        members.isEmpty
        
        members.swapAt(1, 2)
        members.remove(at: 2)
        members.removeLast()
//        members.removeAll(keepingCapacity: true)
        
        let addSringArr = types + members
        print(addSringArr)
        
        for value in members {
            print(value)
        }
        
        for (index, value) in members.enumerated() {
            print("索引:\(index) 数据: \(value)")
        }
        
        let newType = types.filter {$0.count < 6}
        print(newType)
        
        let items = Array(0...100).map{"条目\($0)"}
        print(items)
        
    }
    
    func 复杂数据类型之字典(){
        var enmpty = [String:Int]()
        var myDict = ["name":"lz","url":"apple.com"]
        
        myDict["address"] = "china"
        myDict.removeValue(forKey: "name")
        myDict["name"] = nil
        print(myDict.keys)
        print(myDict.values)
        
        
        for key in myDict.keys {
            print(key)
        }
        
        for valu in myDict.values{
            print(valu)
        }
        
        //元组创建字典
        let tupeArry = [("money",30),("tuseDay",25)]
        let dictionary = Dictionary(uniqueKeysWithValues: tupeArry)
        print(dictionary)
        
        //通过键值对创建字典
        let names = ["apple","pear"]
        let prices = [1,2]
        let dict2 = Dictionary(uniqueKeysWithValues: zip(names, prices))
        print(dict2)
        
        //键序列和值序列创建字典
        
        let arry = ["monday","tuesday","wednesday"]
        
        let dict3 = Dictionary(uniqueKeysWithValues: zip(1..., arry))
        let dict4 = Dictionary(uniqueKeysWithValues: zip(arry, 1...))
        
        print(dict3,dict4)
        
        //zip配合速记+可以用来解决重复键的问题（相同的键值相加）

        let arry2 = ["Apple","Pear","Pear","Orange"]
        let dict5 = Dictionary(zip(arry2, repeatElement(1, count: arry2.count)), uniquingKeysWith: +)
        print(dict5)
        
        //字典合并
        var dict6 = ["one":10,"two":20]
        let tuples = [("one", 5),  ("three", 30)]
        dict6.merge(tuples, uniquingKeysWith: min)
        print("dict6：\(dict6)")
        
    }
    
    func 流程控制() {
        
        
    }
    
    
    func 属性观察者() {
        let me = People()
        me.firstName = "Li"
        me.laseName = "Me"
        me.age = 30
        print(me.toSring())
    }
    
    func uilabel() {
        
        let label = UILabel(frame: CGRect(x: 10, y: 20, width: 300, height: 100))
//        label.text = "welcome to apple.com"
        self.view.addSubview(label)
        
        
       //富文本设置
        let attributeString = NSMutableAttributedString(string:"welcome to apple.com")
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSAttributedString.Key.font,
                                     value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                                     range: NSMakeRange(0,6))
        //设置字体颜色
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue,
                                     range: NSMakeRange(0, 3))
        //设置文字背景颜色
        attributeString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.green,
                                     range: NSMakeRange(3,3))
        label.attributedText = attributeString
        
        
    }
    
    
    func uitextFiled()  {
        
        let textField = UITextField(frame: CGRect(x: 10, y: 60, width: 200, height: 20))
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 2.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .top
        textField.contentHorizontalAlignment = .center
        textField.placeholder = "用户名"
        textField.clearButtonMode = .always
        
        textField.isSecureTextEntry = true
        textField.keyboardType = .numberPad
        textField.returnKeyType = .default
        textField.delegate = self
        
    }
    
    func uitextView() {
        let textview = UITextView(frame:CGRect(x:10, y:100, width:200, height:100))
        textview.layer.borderWidth = 1  //边框粗细
        textview.layer.borderColor = UIColor.gray.cgColor //边框颜色
        self.view.addSubview(textview)
        textview.isEditable = true
        //textview.isSelectable = false
        textview.dataDetectorTypes = .link
        
        let mail = UIMenuItem(title: "微信", action: #selector(ViewController.weixin))
        
        let menu = UIMenuController()
        menu.menuItems = [mail]
    }
    
    @objc func weixin() {
        print("微信")
    }
    
    func uiswitch()  {
       let uiswitch = UISwitch()
        uiswitch.center = CGPoint(x: 100, y: 50)
        uiswitch.isOn = true
        uiswitch.addTarget(self, action: #selector(switchtap), for: .valueChanged)
        self.view.addSubview(uiswitch)
    }
    
    @objc func switchtap(){
        print("点击")
    }
    
    func uisgementcontrol()  {
        
        let items = ["选项一","选项二"]
        let segmented = UISegmentedControl(items: items)
        segmented.center = self.view.center
        segmented.addTarget(self, action: #selector(ViewController.segmentsDidChanage(_:)), for: .valueChanged)
        segmented.selectedSegmentIndex = 0
        self.view.addSubview(segmented)
        
    
        
    }
    @objc func segmentsDidChanage(_ segmented:UISegmentedControl){
        print("\(segmented.selectedSegmentIndex)")
        print("\(segmented.titleForSegment(at: segmented.selectedSegmentIndex))")
    }
    
    
    func uiimageView()  {
        let imageView = UIImageView(image:UIImage(named:"deng"))
        imageView.frame = CGRect(x:10, y:30, width:300, height:150)
        self.view.addSubview(imageView)
        
        
        
        
    }
    
    func uiprogressview() {
        
        let progressview = UIProgressView(progressViewStyle: .default)
        progressview.center = self.view.center
        progressview.progress = 0.5
        progressview.progressTintColor = .green
        progressview.trackTintColor = .blue
        self.view.addSubview(progressview)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            progressview.setProgress(1.0, animated: true)

        }
        
    }
    
    func uislider()  {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        slider.center = self.view.center
        slider.minimumValue = 0.0
        slider.maximumValue = 1
        slider.value = 0.7
        self.view.addSubview(slider)
        
        slider.minimumValueImage = UIImage(named:"voice+") //左边图标
        slider.maximumValueImage = UIImage(named:"voice-")//右边图标
        
        slider.isContinuous = false  //滑块滑动停止后才触发ValueChanged事件
        slider.addTarget(self,action:#selector(sliderDidchange(_:)), for:.valueChanged)
        
        
    }
    
    @objc func sliderDidchange(_ slider:UISlider){
        print(slider.value)
    }

    
    func uiactionsheet() {
        
    }
    
    func uipickerview() {
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(1,inComponent:0,animated:true)
        pickerView.selectRow(2,inComponent:1,animated:true)
        pickerView.selectRow(3,inComponent:2,animated:true)
        self.view.addSubview(pickerView)
        
        
        
    }
    
    func uiscrollview() {
       
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.frame = self.view.bounds
        let imageView = UIImageView(image: UIImage(named: "back.jpg"))
        scrollView.contentSize = imageView.bounds.size
        scrollView.addSubview(imageView)
        self.view.addSubview(scrollView)
        
        

    }
    func uiscrollview_1() {
        let scrollview = UIScrollView()
        scrollview.frame = self.view.bounds
        scrollview.contentSize = CGSize(width: numOfPages*pageWidth, height: pageHeight)
        scrollview.isPagingEnabled = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        
        
        
        //添加子页面
        for i in 0..<numOfPages{
            let myViewController = MyPageViewController(number:(i+1))
            myViewController.view.frame = CGRect(x:pageWidth*i, y:0,
                                                 width:pageWidth, height:pageHeight)
            scrollview.addSubview(myViewController.view)
        }
        self.view.addSubview(scrollview)
        
        
        
        
        
    }
    func uistepper()  {
        
        stepper = UIStepper()
        stepper.center = self.view.center
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.value = 5.5
        stepper.stepValue = 0.5
        stepper.isContinuous = true
        stepper.wraps =  true
        stepper.addTarget(self, action: #selector(stepperTap), for: .valueChanged)
        self.view.addSubview(stepper)
        
        label = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 20))
        label.text = "当前值:\(stepper.value)"
        self.view.addSubview(label)
        
    }
    
    
    @objc func stepperTap() {
        label.text = "当前值: \(stepper.value)"

        print("stepperValue:\(stepper.value)")
    }
    
    func coreMotion()  {
        
    }
    
    func uigesturerecognizer()  {
        
    }
    
    func uidatepick() {
        
    }
    
    func uiwebview_and_uitoolbar() {
        
    }
    
    func uitabview_1() {
        
    }
    
    func uitabview_2() {
           
    }

    
    
    
    
}

extension ViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("\(textField.text ?? "" )")
        return true
    }
}

extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 9
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row) + "-" + String(component)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int)
        -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row:\(row),component:\(component)")
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 13)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = String(row)+"-"+String(component)
        pickerLabel?.textColor = UIColor.blue
        return pickerLabel!
    }
}

extension ViewController:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("x:\(scrollView.contentOffset.x),y:\(scrollView.contentOffset.y)")
    }
    
    
    
}
