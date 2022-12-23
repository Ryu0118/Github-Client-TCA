//
//  GithubClientApp.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import SwiftUI
import ComposableArchitecture
import Presentation

@main
struct GithubClientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: StoreOf<AppCore>(
                    initialState: AppCore.State(),
                    reducer: AppCore()
                )
            )
        }
    }
}
