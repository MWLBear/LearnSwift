//
//  ObjectMapperViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/9/9.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class ObjectMapperViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlTool().get()
        
        
        
        let JSON = [
            ["type": "car", "name": "奇瑞QQ"],
            ["type": "bus", "fee": 2],
            ["type": "vehicle"]]
        
       
        let vehicles = Mapper<Vehicle>().mapArray(JSONArray: JSON)
        
           print("交通工具数量：\(vehicles.count)")
           if let car = vehicles[0] as? Car {
               print("小汽车名字：\(car.name!)")
           }
           if let bus = vehicles[1] as? Bus {
               print("公交车费用：\(bus.fee!) 元")
           }
        
        
    }
    
    func data() {
        
        let leizi = User()
        leizi.username = "lz"
        leizi.age = 18
        
        let zs = User()
        zs.username = "zs"
        zs.age = 20
        
        //将模型数组转为字典数组
        let userArry = [leizi,zs]
        let userDict = userArry.toJSON()
        
        print(userDict)
        
        
        //将字典转为模型
        let meimeiDic = ["age": 17, "username": "梅梅","best_friend": ["age": 18, "username": "李雷"]] as [String : Any]
        let meimei = User(JSON: meimeiDic)
        
        
        let lilei = User()
        lilei.username = "李雷"
        lilei.age = 18
        
        let meimei1 = User()
        meimei1.username = "梅梅"
        meimei1.age = 17
        //        meimei1.bestFriend = lilei
        
        //将模型转为JSON字符串
        let meimeiJSON:String = meimei1.toJSONString()!
        print(meimeiJSON)
        
        
        
        //将模型数组转为JSON字符串
        let users = [lilei,meimei1]
        let josnString = users.toJSONString()!
        print(josnString)
        
        
        
        //3，将JSON字符串转为模型
        
        
        let meimiJSON:String = "{\"age\":17,\"username\":\"梅梅\",\"best_friend\":{\"age\":18,\"username\":\"李雷\"}}"
        
        let mm = User(JSONString: meimeiJSON)
        
        //4，将JSON字符串转为模型数组
        
        let json = "[{\"age\":18,\"username\":\"李雷\"},{\"age\":17,\"username\":\"梅梅\"}]"
        let jusers:[User] = Mapper<User>().mapArray(JSONString: json)!
        
    }
    
    
}
