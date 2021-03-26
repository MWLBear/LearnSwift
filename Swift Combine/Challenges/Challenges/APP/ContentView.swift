//
//  ContentView.swift
//  Challenges
//
//  Created by admin on 2021/3/24.
//

import SwiftUI
import Combine


struct ResultRow: View {
    let reslut:Story
    
    var body: some View {
        VStack(alignment:.leading){
            Text(reslut.title)
                .font(.headline)
            Text(String(reslut.url))
                .font(.subheadline)
        }
    }
}
//两个视图：“容器视图”和“渲染视图”。
//容器视图处理操作并从全局状态中检索所需的状态。 渲染视图接受数据并进行渲染。

struct ContainerView:View {
    @EnvironmentObject var store:AppStore

    var body: some View{
        
        ContentView(repos: store.state.reslut)
            .onAppear(perform:fetch)
    }
    func fetch() {
        store.send(.allreslut)
    }
}

struct ContentView: View {

    let repos: [Story]
    
    var body: some View {
        
        NavigationView {
            List{
                if repos.isEmpty{
                    Text("Loading...")
                }
                
                ForEach(repos){ repo in
                    ResultRow(reslut: repo)
                }
            }.navigationTitle("News")
        }
    }
}


