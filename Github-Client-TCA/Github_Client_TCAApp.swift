//
//  Github_Client_TCAApp.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import SwiftUI
import ComposableArchitecture

@main
struct Github_Client_TCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: StoreOf<GithubRepositoryCore>(
                    initialState: GithubRepositoryCore.State(),
                    reducer: GithubRepositoryCore()
                )
            )
        }
    }
}
