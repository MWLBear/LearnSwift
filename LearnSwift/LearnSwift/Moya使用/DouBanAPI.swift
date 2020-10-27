//
//  DouBanAPI.swift
//  LearnSwift
//
//  Created by admin on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import Moya

let DouBanProvider = MoyaProvider<DouBanMoya>()


public enum DouBanMoya{
    case channels
    case playlist(String)
}

extension DouBanMoya:TargetType{
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        }
    }
    
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params : [String:Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
  
    
}
