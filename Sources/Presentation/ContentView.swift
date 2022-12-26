//
//  ContentView.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import SwiftUI
import ComposableArchitecture
import Domain

public struct ContentView: View {
    public let store: StoreOf<AppReducer>
    
    public init(store: StoreOf<AppReducer>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                list(viewStore)
                
                if viewStore.isLoading {
                    ProgressView()
                        .scaleEffect(2)
                }
            }
        }
    }
    
    func list(
        _ viewStore: ViewStore<AppReducer.State, AppReducer.Action>
    ) -> some View {
        NavigationView {
            List {
                ForEachStore(
                    store.scope(state: \.cellStates, action: AppReducer.Action.cell(id:action:))
                ) { cellStore in
                    GithubRepositoryCell(store: cellStore)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: .init(initialState: AppReducer.State(text: "", cellStates: []), reducer: AppReducer())
        )
    }
}
