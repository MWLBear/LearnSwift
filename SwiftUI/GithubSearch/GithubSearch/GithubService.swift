//
//  GithubService.swift
//  GithubSearch
//
//  Created by admin on 2021/1/29.
//

import SwiftUI
import Combine

struct Repo: Decodable, Identifiable {
    var id: Int
    let name: String
    let description: String?
    let owner: Owner
    
    struct Owner: Decodable {
        let avatar: URL
        
        enum CodingKeys: String, CodingKey {
            case avatar = "avatar_url"
        }
    }
}


struct SearchResponse: Decodable {
    let items: [Repo]
}

class GithubService {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    func searchPuhlisher(matching query: String) -> AnyPublisher<[Repo],Error> {
        guard
            var urlComponents = URLComponents(string: "https://api.github.com/search/repositories")
        else { preconditionFailure("Can't create url components") }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        
        guard
            let url = urlComponents.url
        else { preconditionFailure("Can't create url form components") }
        
        return session
            .dataTaskPublisher(for: url)
            .map{ $0.data}
            .decode(type: SearchResponse.self, decoder: decoder)
            .map{ $0.items }
            .eraseToAnyPublisher()
        
    }
}
