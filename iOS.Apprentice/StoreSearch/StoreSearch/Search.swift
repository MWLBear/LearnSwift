//
//  Search.swift
//  StoreSearch
//
//  Created by admin on 2021/4/14.
//

import UIKit
typealias SearchComplete = (Bool)->Void


class Search {
    
    //与对象相关的任何逻辑都应该是该对象的组成部分
    enum Category:Int {
        case all = 0
        case music = 1
        case software = 2
        case ebooks = 3
        
        var type:String {
            switch self {
            case .all: return ""
            case .music: return "musicTrack"
            case .software: return "software"
            case .ebooks: return "ebook"
            }
        }
    }
    
    //Enums with associated values
    enum State {
        case notSearchedYet
        case loading
        case noResults
        case results([SearchResult])
    }
    
    private var dataTask: URLSessionTask? = nil
    private(set) var state: State = .notSearchedYet
    
    func performSearch(for text:String, category:Category,completion: @escaping SearchComplete) {
        if !text.isEmpty {
            dataTask?.cancel()
            
            state = .loading
            let url = self.iTunesURL(searchText: text,category: category)
            let session = URLSession.shared
            dataTask = session.dataTask(with: url) { data, response, error in
                var sucess = false
                var newState = State.notSearchedYet
                if let error = error as NSError? ,error.code == -999{
                    return
                }
                if let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200{
                    if let data = data {
                        var searchResults = self.parse(data: data)
                        if searchResults.isEmpty {
                            newState = .noResults
                        }else {
                            searchResults.sort(by: <)
                            newState = .results(searchResults)
                        }
                        sucess = true
                    }
                }
                
                DispatchQueue.main.async {
                    self.state = newState
                    completion(sucess)
                }
            }
            dataTask?.resume()
        }
    }
    // MARK:- Private Methods

    private func iTunesURL(searchText: String,category: Category) -> URL {
        let locale = Locale.autoupdatingCurrent
        let language = locale.identifier
        let countryCode = locale.regionCode ?? "US"

        let kind = category.type
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlUserAllowed)!
        let urlString = "https://itunes.apple.com/search?" + "term=\(encodedText)&limit=200&entity=\(kind)" + "&lang=\(language)&country=\(countryCode)"
        let url = URL(string: urlString)
        print("URL: \(url!)")
        return url!
    }
    
    private func parse(data:Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            return result.results
        } catch  {
            return []
        }
    }
    
}
