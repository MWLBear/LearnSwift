//
//  Daily.swift
//  Daily
//
//  Created by admin on 2021/10/21.
//

import WidgetKit
import SwiftUI

let DaliyApi = "https://********//data/specials//?type=day&nearly=1"
let placeholderurl = "https://*********/upload/2021/10/17/3268aee8dd.jpg?imageView2/2/w/190/h/200"

struct Provider: TimelineProvider {
  
    func placeholder(in context: Context) -> DaliyEntry {
        DaliyEntry(date: Date(),daliy: Daliy(name: "瓷器·玉雕·珠宝", image: placeholderurl))
    }
    func getSnapshot(in context: Context, completion: @escaping (DaliyEntry) -> ()) {
        let entry =  DaliyEntry(date: Date(),daliy: Daliy(name: "瓷器·玉雕·珠宝", image: placeholderurl))
        completion(entry)
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<DaliyEntry>) -> ()) {

        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        DaliyRequest.request { reslut in
            let daliy:Daliy
            if case .success(let res) = reslut {
                daliy = res
            }else {
                daliy = Daliy(name: "暂无拍品", image: "bg")
            }
            let daliyentry = DaliyEntry(date: entryDate, daliy: daliy)
            let timeline = Timeline(entries: [daliyentry], policy: .after(entryDate))
            completion(timeline)
        }
    }
}

struct DaliyEntry: TimelineEntry {
    let date: Date
    let daliy: Daliy
}

struct Daliy:Decodable {
    let name: String
    let image: String
}


struct DailyEntryView : View {
    @Environment(\.widgetFamily) var family

    let placehoulder = UIImage(named: "bg")!
    var entry: DaliyEntry
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack(alignment: .leading,spacing: 15){
                Spacer()
                Text("每日一拍")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .offset(x: 10)
                
                Text(entry.daliy.name)
                    .foregroundColor(.white)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .offset(x: 10,y: -12)
            }
        }
        .background(
            Image(uiImage: UIImage(data: getImageWithUrl(imageurl: entry.daliy.image) ?? Data()) ?? placehoulder)
                .resizable()
                .scaledToFill()
        ).widgetURL(URL(string: "jump://daily")!)
    }
    
 
    
    func getImageWithUrl(imageurl:String) -> Data? {
        
        let imageURL:String
        if family == .systemSmall {
            imageURL = imageurl  + "?imageView2/2/w/190/h/200"
        }else {
            imageURL = imageurl
        }
        
        let imageData = try? Data.init(contentsOf: URL.init(string: imageURL)!)
        return imageData
    }
}

@main
struct Daily: Widget {
    let kind: String = "Daily"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyEntryView(entry: entry)
        }
        .configurationDisplayName("每日一拍")
        .description("每日一拍简介")
        .supportedFamilies([.systemSmall])
    }
}

struct DaliyRequest {
    static func request(competion: @escaping(Result<Daliy,Error>) -> Void){
        let url = URL(string: DaliyApi)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                competion(.failure(error!))
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            
            guard let daliyA = json["data"] as? Array<Any> else{
                return competion(.failure(NSError(domain: "无数据", code: 1, userInfo: [:])))
            }
            guard let onedaliy = daliyA.first as? Dictionary<String, Any> else{
                return competion(.failure(NSError(domain: "无数据", code: 1, userInfo: [:])))
            }
            print(onedaliy)
            let name = onedaliy["name"] as! String
            let image = onedaliy["image"] as! String
            print(image)
            let daliy = Daliy( name: name, image: image)
            competion(.success(daliy))
            
        }
        task.resume()
    }
}
