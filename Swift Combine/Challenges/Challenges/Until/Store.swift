//
//  Store.swift
//  Challenges
//
//  Created by admin on 2021/3/24.
//

import Foundation
import Combine

//class Store: ObservableObject {
//    //State property uses @Published property wrapper that notifies SwiftUI during any changes
//    @Published private(set) var repos: [Story] = []
//    
//    private let api:API
//    private var subscriptions = [AnyCancellable]()
//
//    init(api:API) {
//        self.api = api
//    }
//    
//    func send() {
//        api.stories()
//            .receive(on: DispatchQueue.main)
//            .catch { _ in Empty() }
//            .sink(receiveValue: { self.repos = $0})
//            .store(in: &subscriptions)
//    }
//}

typealias Reducer<State,Action,Enviroment> = (inout State,Action,Enviroment) -> AnyPublisher<Action,Error>?

 class Store<State, Action,Environment>:ObservableObject{
    
    @Published private(set) var state: State
    private let enviroment: Environment
    private let reducer: Reducer<State, Action,Environment>
    private var cancellable: Set<AnyCancellable> = []
    init(
        initiaState: State,
        reducer: @escaping Reducer<State, Action,Environment>,
        environment: Environment) {
        self.state = initiaState
        self.reducer = reducer
        self.enviroment = environment
    }
    
    //通常，reducer通过在状态之上应用动作来解决该动作。 如果是异步操作，则reducer将其作为Combine Publisher返回，然后Store运行它，并将结果作为普通操作发送回reducer。
    
    func send(_ action: Action) {
        guard let effect = reducer(&state,action,enviroment) else {
            return
        }
        effect.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: send)
            .store(in: &cancellable)
    }
}
