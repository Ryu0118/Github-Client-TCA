//
//  URLImageCoreSpec.swift
//  Github-Client-TCATests
//
//  Created by ryunosuke.shibuya on 2022/12/20.
//

import XCTest
import Quick
import ComposableArchitecture
@testable import Github_Client_TCA

final class URLImageCoreSpec: QuickSpec {

    override func spec() {
        context("validate urlImageCore reducer behavior") {
            it(".setImageした時state.urlに値が格納されるか") { @MainActor in
                let store = TestStore(
                    initialState: URLImageCore.State(url: URL(string: "https://github.com/Ryu0118.png")!),
                    reducer: URLImageCore()
                )
                store.dependencies.imageFetcher = ImageFetcherMock()
                
                await store.send(.setImage)
                await store.receive(.imageResponse(.success(UIImage(systemName: "star")!))) { state in
                    state.image = UIImage(systemName: "star")!
                }
            }
        }
    }

}

final class ImageFetcherMock: ImageFetcher {
    func fetchImage(with url: URL) async throws -> UIImage {
        UIImage(systemName: "star")!
    }
}
