//
//  App.swift
//  GithubSearch
//
//  Created by admin on 2021/1/29.
//

import Foundation
import Combine

//附加参数
struct World {
    var service = GithubService()
    
}
//单一 应用程序状态
struct AppState {
    var searchResult: [Repo] = []
}

//动作是描述状态变化的简单枚举或枚举的组合
enum AppAction {
    case search(query: String)
    case setSearchReslut(repos: [Repo])
}

//异步任务
//Reducer是一种功能，它可以获取当前状态，将Action应用于该状态，并生成一个新状态
typealias Reducer<State, Action, Environment> = (inout State, Action, Environment) -> AnyPublisher<Action,Never>?


func appReducer(state: inout AppState,
                action: AppAction,
                environment: World) -> AnyPublisher<AppAction,Never>? {
    
    switch action {
    case let .setSearchReslut(repos: repos):
        state.searchResult = repos
        print("setSearchReslut: \(repos)")
    case let .search(query: query):
        print("search(query: \(query)")
        return environment.service.searchPuhlisher(matching: query)
            .replaceError(with: [])
            .map{ AppAction.setSearchReslut(repos: $0) }
            .eraseToAnyPublisher()
    }
    return Empty().eraseToAnyPublisher()
}

typealias AppStore = Store<AppState,AppAction,World>
