//
//  App.swift
//  Challenges
//
//  Created by admin on 2021/3/24.
//

import Foundation
import Combine

//环境可能是一个简单的结构体，其中包含所有需要的依赖项，例如服务和管理器类。

struct Environment {
    var service = API()
}


//这里的主要思想是通过使用单个结构或结构的组合来描述整个应用程序的状态。
struct AppState {
    var reslut: [Story] = []
}

//现在该讨论导致状态改变的用户操作。 动作是描述状态变化的简单枚举或枚举的组合。
//例如，在数据获取期间设置加载值，将获取的存储库分配给state属性

enum AppAction {
    case allreslut
    case setResultList(reslut:[Story])
}

//Reducer是一种功能，它可以获取当前状态，将Action应用于该状态，并生成一个新状态。 通常，reducer或reducers的组成是您的应用程序更改状态的唯一位置。 仅有的一项功能可以修改整个应用程序状态，这一事实非常简单，可调试且可测试。

//状态->视图->操作->状态->视图


//reducer将使用该动作来更改当前状态。

func appReducer(
    state: inout AppState,
    action: AppAction,
    enviroment:Environment
) -> AnyPublisher<AppAction,Error>? {
    switch action {
    case let .setResultList(reslut: repos):
        state.reslut = repos
    case .allreslut:
        return enviroment.service.stories()
            .map{ AppAction.setResultList(reslut: $0)}
            .eraseToAnyPublisher()
          
    }
    
    return Empty().eraseToAnyPublisher()
}
typealias AppStore = Store<AppState, AppAction,Environment>
