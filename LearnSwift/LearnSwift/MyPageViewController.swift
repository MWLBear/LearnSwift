//
//  MyPageViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/4/7.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {

    
    var number:Int!
       let colorMap=[
           1:UIColor.black,
           2:UIColor.orange,
           3:UIColor.blue
       ]
        
       init(number initNumber:Int){
           self.number = initNumber
           super.init(nibName:nil, bundle:nil)
       }
        
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberLabel = UILabel(frame:CGRect(x:130, y:50, width:50, height:30))
        numberLabel.text = "第\(number!)页"
        numberLabel.textColor = UIColor.white
        self.view.addSubview(numberLabel)
        self.view.backgroundColor = colorMap[number]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
