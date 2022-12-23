//
//  AppCoreSpec.swift
//  Github-Client-TCATests
//
//  Created by ryunosuke.shibuya on 2022/12/20.
//

import XCTest
import Quick
import ComposableArchitecture
@testable import Presentation
@testable import Domain

final class AppCoreSpec: QuickSpec {

    override func spec() {
        context("validate appCore behavior") {
            it("state.itemsにGithubResponseのmockのitemsが格納されているか") { @MainActor in
                let store = TestStore(
                    initialState: AppCore.State(),
                    reducer: AppCore()
                )
                
                await store.send(.searchButtonTapped)
                await store.receive(.githubResponse(.success(GithubResponse.mock().items))) { state in
                    state.items = GithubResponse.mock().items
                }
            }
            
            it("textがbindできているかどうか") { @MainActor in
                let store = TestStore(
                    initialState: AppCore.State(),
                    reducer: AppCore()
                )
                
                store.send(.set(\.$text, "Test")) {
                    $0.text = "Test"
                }
            }
            
            it("textが空の時にitemsが空になっているか") { @MainActor in
                let store = TestStore(
                    initialState: AppCore.State(text: "Test"),
                    reducer: AppCore()
                )
                
                store.send(.set(\.$text, "")) {
                    $0.text = ""
                    $0.items = []
                }
            }
        }
    }

}
