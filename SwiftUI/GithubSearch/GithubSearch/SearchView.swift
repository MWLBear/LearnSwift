//
//  ContentView.swift
//  GithubSearch
//
//  Created by admin on 2021/1/29.
//

import SwiftUI
import Combine

struct RepoRow: View {
    let repo: Repo
    
    var body: some View{
        HStack(alignment:.top){
            VStack(alignment: .leading){
                Text(repo.name)
                    .font(.headline)
                Text(repo.description ?? "")
                    .font(.subheadline)
            }
        }
    }
}

struct SearchContainerView: View {
    @EnvironmentObject var store: AppStore
    @State private var query:  String = "Swift"
    
    var body: some View {
        
        SearchView(query: $query,
                   repos: store.state.searchResult,
                   onCommit: fetch
        ).onAppear(perform:fetch)
    }
    
    private func fetch(){
        store.send(.search(query: query))
    }
}

struct SearchView: View {
    @Binding var query: String
    let repos: [Repo]
    let onCommit: ()->Void
    
    var body: some View{
    
        NavigationView {
            List {
                TextField("Type somthing...", text: $query,onCommit:onCommit)
                if repos.isEmpty {
                    Text("Loading...")
                }else{
                    ForEach(repos){ repo in
                        RepoRow(repo: repo)
                    }
                }
            }.navigationTitle(Text("Search"))
        }
    }
}
