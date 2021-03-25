//
//  Store.swift
//  Recipes
//
//  Created by Majid Jabrayilov on 11/10/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
import Foundation
import Combine

struct Prism<Source, Target> {
    let embed: (Target) -> Source
    let extract: (Source) -> Target?
}

struct Reducer<State, Action, Environment> {
    let reduce: (inout State, Action, Environment) -> AnyPublisher<Action, Never>

    func callAsFunction(
        _ state: inout State,
        _ action: Action,
        _ environment: Environment
    ) -> AnyPublisher<Action, Never> {
        reduce(&state, action, environment)
    }

    func indexed<IndexedState, IndexedAction, IndexedEnvironment, Key>(
        keyPath: WritableKeyPath<IndexedState, [Key: State]>,
        prism: Prism<IndexedAction, (Key, Action)>,
        extractEnvironment: @escaping (IndexedEnvironment) -> Environment
    ) -> Reducer<IndexedState, IndexedAction, IndexedEnvironment> {
        .init { state, action, environment in
            guard let (index, action) = prism.extract(action) else {
                return Empty().eraseToAnyPublisher()
            }
            let environment = extractEnvironment(environment)
            return self
                .optional()
                .reduce(&state[keyPath: keyPath][index], action, environment)
                .map { prism.embed((index, $0)) }
                .eraseToAnyPublisher()
        }
    }

    func indexed<IndexedState, IndexedAction, IndexedEnvironment>(
        keyPath: WritableKeyPath<IndexedState, [State]>,
        prism: Prism<IndexedAction, (Int, Action)>,
        extractEnvironment: @escaping (IndexedEnvironment) -> Environment
    ) -> Reducer<IndexedState, IndexedAction, IndexedEnvironment> {
        .init { state, action, environment in
            guard let (index, action) = prism.extract(action) else {
                return Empty().eraseToAnyPublisher()
            }
            let environment = extractEnvironment(environment)
            return self
                .reduce(&state[keyPath: keyPath][index], action, environment)
                .map { prism.embed((index, $0)) }
                .eraseToAnyPublisher()
        }
    }

    func optional() -> Reducer<State?, Action, Environment> {
        .init { state, action, environment in
            if state != nil {
                return self(&state!, action, environment)
            } else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
        }
    }

    func lift<LiftedState, LiftedAction, LiftedEnvironment>(
        keyPath: WritableKeyPath<LiftedState, State>,
        prism: Prism<LiftedAction, Action>,
        extractEnvironment: @escaping (LiftedEnvironment) -> Environment
    ) -> Reducer<LiftedState, LiftedAction, LiftedEnvironment> {
        .init { state, action, environment in
            let environment = extractEnvironment(environment)
            guard let action = prism.extract(action) else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
            let effect = self(&state[keyPath: keyPath], action, environment)
            return effect.map(prism.embed).eraseToAnyPublisher()
        }
    }

    static func combine(_ reducers: Reducer...) -> Reducer {
        .init { state, action, environment in
            let effects = reducers.compactMap { $0(&state, action, environment) }
            return Publishers.MergeMany(effects).eraseToAnyPublisher()
        }
    }
}

import os.log

extension Reducer {
    func signpost(log: OSLog = OSLog(subsystem: "com.aaplab.food", category: "Reducer")) -> Reducer {
        .init { state, action, environment in
            let actionString = String(reflecting: action)
            os_signpost(.event, log: log, name: "Action", "%{public}@", actionString)
            os_signpost(.begin, log: log, name: "Action", "%{public}@", actionString)
            let effect = self.reduce(&state, action, environment)
            os_signpost(.end, log: log, name: "Action", "%{public}@", actionString)
            return effect
        }
    }

    func log(log: OSLog = OSLog(subsystem: "com.aaplab.food", category: "Reducer")) -> Reducer {
        .init { state, action, environment in
            os_log(.default, log: log, "Action %s", String(reflecting: action))
            let effect = self.reduce(&state, action, environment)
            os_log(.default, log: log, "State %s", String(reflecting: state))
            return effect
        }
    }
}

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State

    private let reduce: (inout State, Action) -> AnyPublisher<Action, Never>
    private var effectCancellables: [UUID: AnyCancellable] = [:]
    private let queue: DispatchQueue

    init<Environment>(
        initialState: State,
        reducer: Reducer<State, Action, Environment>,
        environment: Environment,
        subscriptionQueue: DispatchQueue = .init(label: "com.aaplab.store")
    ) {
        self.queue = subscriptionQueue
        self.state = initialState
        self.reduce = { state, action in
            reducer(&state, action, environment)
        }
    }

    func send(_ action: Action) {
        let effect = reduce(&state, action)

        var didComplete = false
        let uuid = UUID()

        let cancellable = effect
            .subscribe(on: queue)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    didComplete = true
                    self?.effectCancellables[uuid] = nil
                },
                receiveValue: { [weak self] in self?.send($0) }
            )

        if !didComplete {
            effectCancellables[uuid] = cancellable
        }
    }
    
//  Derived stores

//    可以简化我们的体系结构的另一种组合方式是 Derived stores。 我不想向每个视图公开整个应用程序状态，也不希望在不相关的状态更新中更新视图。
    
//    如您所见，我的应用程序的每个选项卡都通过派生存储获取状态的一部分。 我们仍然使用全局存储来处理所有状态突变。 派生存储充当管道，允许我们从全局存储转换状态并将操作重定向到全局存储。 让我们看一下如何为Store类实现派生方法。
//
    
    func derived<DerivedState: Equatable, ExtractedAction>(
        deriveState: @escaping (State) -> DerivedState,
        embedAction: @escaping (ExtractedAction) -> Action
    ) -> Store<DerivedState, ExtractedAction> {
        let store = Store<DerivedState, ExtractedAction>(
            initialState: deriveState(state),
            reducer: Reducer { _, action, _ in
                self.send(embedAction(action))
                return Empty().eraseToAnyPublisher()
            },
            environment: ()
        )

        $state
            .subscribe(on: store.queue)
            .map(deriveState)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: &store.$state)

        return store
    }
}

import SwiftUI

//https://swiftwithmajid.com/2020/04/08/binding-in-swiftui/

//绑定是数据和访问数据的视图之间的双向连接。 SwiftUI提供了一种使用getter和setter闭包构造绑定的方法

//在这里，我们有一个存储概念，可以保存应用程序的整个状态。状态的所有更改都来自单向流。
//Reducer是我们可以改变应用程序状态的唯一位置。通过使用计算的绑定，我们可以提供对状态的只读访问，
//并通过将操作发送给reducer来遵守单向流。

//如您所见，我们生成了一个计算绑定，该绑定读取状态的一部分，并在需要时通过reducer发出操作以修改状态。例如，当您有一个描述某些绑定到应用程序状态的复选框的设置屏幕时，可能需要这种类型的绑定。

extension Store {
    func binding<Value>(
        for keyPath: KeyPath<State, Value>,
        toAction: @escaping (Value) -> Action
    ) -> Binding<Value> {
        
        Binding<Value>(
            get: { self.state[keyPath: keyPath] },
            set: {
                self.send(toAction($0)) }
        )
    }
}
