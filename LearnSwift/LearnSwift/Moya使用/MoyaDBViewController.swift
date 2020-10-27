//
//  MoyaDBViewController.swift
//  LearnSwift
//
//  Created by admin on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import SwiftyJSON
import Moya

class MoyaDBViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView:UITableView!
    var channels:Array<JSON> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        
        DouBanProvider.request(.channels) { (result) in
            
            if case let .success(response) = result{
                
                print("response:\(response)")
                
                let data = try? response.mapJSON()
                print("data:\(data)")

                let json = JSON(data!)
                print("json:\(json)")

                self.channels = json["channels"].arrayValue
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    
}

extension MoyaDBViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" ,for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = channels[indexPath.row]["name"].stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channelName = channels[indexPath.row]["name"].stringValue
        let channelId = channels[indexPath.row]["channel_id"].stringValue
        
        DouBanProvider.request(.playlist(channelId)) { (result) in
            if case let .success(response) = result{
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let music = json["song"].arrayValue[0]
                let artist = music["artist"].stringValue
                 let title = music["title"].stringValue
                let message = "歌手：\(artist)\n歌曲：\(title)"
                
                //将歌曲信息弹出显示
                self.showMessage(title: channelName, message: message)
            }
        }
        
    }
    
    
    func showMessage(title:String,message:String) {
        
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
}
