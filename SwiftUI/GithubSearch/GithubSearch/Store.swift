//
//  Store.swift
//  GithubSearch
//
//  Created by admin on 2021/1/29.
//

import Foundation
import Combine


final class Store<State, Action, Enviroment>: ObservableObject {
    
    @Published private(set) var state: State
    
    private let enviroment:Enviroment
    private let reducer: Reducer<State, Action, Enviroment>
    private var cancellables: Set<AnyCancellable> = []
    
    init(initiaState: State,
         reducer: @escaping Reducer<State, Action, Enviroment>,
         enviroment: Enviroment) {
        self.state = initiaState
        self.reducer = reducer
        self.enviroment = enviroment
    }
    
    func send(_ action: Action) {
        print("action: \(Action.Type.self)")
        guard let effect = reducer(&state,action,enviroment) else {
            return
        }

//        可以看出，从概念上和我们之前定义的简单观察者模式相差无几。Publisher 在自身状态改变时，调用 Subscriber 的三个不同方法（receive(subscription), receive(_:Input), receive(completion:)）来通知 Subscriber。
        
        //Combine 内置的 Subscriber 有三种：
        
      //  Sink  Sink 是非常通用的 Subscriber，我们可以自由的处理数据流的状态。
      //  Assign
      //  Subject
        
        
        print("effect: \(effect)")
        effect
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &cancellables)
        print("end ....")
    }
}
