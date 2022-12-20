//
//  AppCoreSpec.swift
//  Github-Client-TCATests
//
//  Created by ryunosuke.shibuya on 2022/12/20.
//

import XCTest
import Quick
import ComposableArchitecture
@testable import Github_Client_TCA

final class AppCoreSpec: QuickSpec {

    override func spec() {
        context("validate appcore reducer behavior") {
            it("state.itemsにGithubResponseのmockのitemsが格納されているか") { @MainActor in
                let store = TestStore(
                    initialState: AppCore.State(),
                    reducer: AppCore()
                )
                store.dependencies.githubRepository = GithubRepositoryMock()
                
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
                store.dependencies.githubRepository = GithubRepositoryMock()
                
                store.send(.set(\.$text, "Test")) {
                    $0.text = "Test"
                }
            }
            
            it("textが空の時にitemsが空になっているか") { @MainActor in
                let store = TestStore(
                    initialState: AppCore.State(text: "Test"),
                    reducer: AppCore()
                )
                store.dependencies.githubRepository = GithubRepositoryMock()
                
                store.send(.set(\.$text, "")) {
                    $0.text = ""
                    $0.items = []
                }
            }
        }
    }

}

struct GithubRepositoryMock: GithubRepository {
    func fetchRepositories(query: String) async throws -> GithubResponse {
        .mock()
    }
}

extension GithubResponse {
    static func mock() -> GithubResponse {
        .init(items: [
            .init(id: 1, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 2, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 3, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 4, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 5, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 6, avatarURL: "", name: "", description: "", language: "", stars: 1),
        ])
    }
}
