//
//  ContentView.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<GithubRepositoryCore>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.state.items) { item in
                        GithubRepositoryCell(item: item)
                    }
                }
            }
            .searchable(
                text: viewStore.binding(\.$text),
                prompt: "リポジトリを検索"
            )
            .onSubmit(of: .search) {
                viewStore.send(.searchButtonTapped)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: .init(initialState: GithubRepositoryCore.State(), reducer: GithubRepositoryCore())
        )
    }
}
