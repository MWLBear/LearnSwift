//
//  文件操作.swift
//  LearnSwift
//
//  Created by admin on 2020/3/30.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class File: NSObject {
    
    //获取用户文档目录路径
    func 文件() {
        
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urlForDocument[0] as URL
        print(url)
        
        
        //对指定路径进行搜索,返回目录路径下的文件,子目录以及f符号链接的列表
        
        let contentsOfpath = try? manager.contentsOfDirectory(atPath: url.path)
        
        print("contentsOfpath:\(contentsOfpath)")
        
        
        let enumerateAtPath = manager.enumerator(atPath: url.path)
        
        print("enumerateAtPath:\(enumerateAtPath?.allObjects)")
        
        
        //判断文件是否存在
        
        let filePath = NSHomeDirectory() + "/Documents/hangge.txt"
        let exits = manager.fileExists(atPath: filePath)
        print("exist:\(exits)")
        
        
        
        //创建文件1
        let myDirectory = NSHomeDirectory() + "/Documents/myFolder/Files"
        try! manager.createDirectory(atPath: myDirectory, withIntermediateDirectories: true, attributes: nil)
        
        
        //在文档目录下创建foldermb目录
        
        let urlForD = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let urlD = urlForD[0] as NSURL
        
        createFolder(name: "folder", baseUrl: urlD)
        
        
        //把对象写入文件
        let info = "幻影刺客"
        try! info.write(toFile: filePath, atomically: true, encoding: .utf8)
        
        
        //把图片保存到文件路径下
        
        let imagePath = NSHomeDirectory() + "Documents/apple.png"
        let image = UIImage(named: "apple.png")
        let data = image!.pngData()
        try! data?.write(to: URL(fileURLWithPath: imagePath))
        
        
        //把nsarry保存在文件路径下
        
        let array = NSArray(objects: "aaa","bbb","ccc")
        let plistfilePath =  NSHomeDirectory() + "/Documents/arry.plist"
        array.write(toFile: plistfilePath, atomically: true)
        
        //把 nsdictionary 保存在文件路径下
       let dictionary:NSDictionary = ["Gold": "1st Place", "Silver": "2nd Place"]
       let filePath1:String = NSHomeDirectory() + "/Documents/dictionary.plist"
        dictionary.write(toFile: filePath1, atomically: true)
        
        
        //复制文件
        
        let srcUrl = url.appendingPathComponent("test.txt")
        let toUrl = url.appendingPathComponent("copyed.txt")
        try!manager.copyItem(at: srcUrl, to: toUrl)
        
        
        //移动文件
        try!manager.moveItem(at: srcUrl, to: toUrl)
        
        //删除文件

        try! manager.removeItem(at: toUrl)
        
        //删除目录下的所有文件
        
        let my = NSHomeDirectory() + "Doucments/Files"
        let fileArry = manager.subpaths(atPath: my)
        for fn in fileArry! {
            try! manager.removeItem(atPath: my + "/\(fn)")
        }
        
        
        //读取文件
        let myFile = urlForDocument[0].appendingPathComponent("test.txt")
        let readHandler = try! FileHandle(forReadingFrom: myFile)
        let data1 = readHandler.readDataToEndOfFile()
        let readString = String(data: data1, encoding: .utf8)
        
        let data2 = manager.contents(atPath: myFile.path)
        let readString2 = String(data: data2!, encoding: .utf8)
        
        
        print("readString:\(readString),readSring2 :\(readString2) ")
        
        
        //文件权限判断
        let readable = manager.isReadableFile(atPath: filePath)
        print("可读: \(readable)")
        let writeable = manager.isWritableFile(atPath: filePath)
        print("可写: \(writeable)")
        let executable = manager.isExecutableFile(atPath: filePath)
        print("可执行: \(executable)")
        let deleteable = manager.isDeletableFile(atPath: filePath)
        print("可删除: \(deleteable)")
        
        
        
        
        //文件属性
        let attribute = try! manager.attributesOfItem(atPath: filePath)
        
        
        
        
        
        
    }
    
    //创建文件2
    
    func createFolder(name:String,baseUrl:NSURL) {
        let manager = FileManager.default
        let folder = baseUrl.appendingPathComponent(name,isDirectory: true)
        print("文件夹:\(folder)")
        let exist = manager.fileExists(atPath: folder!.path)
        
        if !exist {
            
            try! manager.createDirectory(at: folder!, withIntermediateDirectories: true, attributes: nil)
            
        }
    }
    
    
    
}
