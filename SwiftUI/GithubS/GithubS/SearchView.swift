//
//  ContentView.swift
//  GithubS
//
//  Created by admin on 2021/1/29.
//

import SwiftUI



struct RepoView: View{
    let repo: Repo
    
    var body: some View {
        
        VStack (alignment: .leading) {
            Text(repo.name)
                .font(.headline)
            Text(repo.description)
                .font(.subheadline)
        }
    }
}


struct SearchView: View {
    @State private var query: String = "Swift"
    @EnvironmentObject var repoStore: ReposStore
    
    var body: some View {
       
        NavigationView {
            List {
                TextField("Type something...", text: $query, onCommit:fetch)
                ForEach(repoStore.repos){ repo in
                    RepoView(repo: repo)
                }
            }.navigationTitle(Text("Search"))
        }.onAppear(perform:fetch)
    }
    
    private func fetch(){
        repoStore.fetch(match: query)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
