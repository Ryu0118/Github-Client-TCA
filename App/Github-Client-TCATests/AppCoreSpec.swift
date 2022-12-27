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
                    initialState: AppReducer.State(),
                    reducer: AppReducer()
                )
                
                store.dependencies.uuid = .incrementing
                
                await store.send(.searchButtonTapped)
                await store.receive(.githubResponse(.success(GithubResponse.mock().items))) { state in
                    let states = GithubResponse.mock().items.enumerated().map {
                        CellReducer.State(
                            id: UUID(uuidString: "00000000-0000-0000-0000-00000000000\($0)")!,
                            item: $1
                        )
                    }
                    state.cellStates = IdentifiedArrayOf(uniqueElements: states)
                }
            }
            
            it("textがbindできているかどうか") { @MainActor in
                let store = TestStore(
                    initialState: AppReducer.State(),
                    reducer: AppReducer()
                )
                
                store.send(.set(\.$text, "Test")) {
                    $0.text = "Test"
                }
            }
            
            it("textが空の時にitemsが空になっているか") { @MainActor in
                let store = TestStore(
                    initialState: AppReducer.State(text: "Test"),
                    reducer: AppReducer()
                )
                
                store.send(.set(\.$text, "")) {
                    $0.text = ""
                    $0.cellStates = []
                }
            }
        }
    }

}
