//
//  ReposStore.swift
//  GithubS
//
//  Created by admin on 2021/1/29.
//

import Foundation
import Combine

final class ReposStore: ObservableObject {
    @Published private(set) var repos: [Repo] = []
    
    private let service: GithubService
    init(service: GithubService) {
        self.service = service
    }
    
    func fetch(match query: String) {
        
        service.search(matching: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let repos): self?.repos = repos
                case .failure: self?.repos = []
                }
            }
        }
    }
}
