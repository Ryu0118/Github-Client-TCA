//
//  URLImage.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import SwiftUI
import ComposableArchitecture

struct URLImage: View {
    let store: StoreOf<URLImageFeature>
    let url: URL
    
    var body: some View {
        WithViewStore(store, observe: \.image) { viewStore in
            Image(uiImage: viewStore.state)
                .resizable()
                .scaledToFit()
                .animation(.default, value: viewStore.state)
                .onAppear {
                    viewStore.send(.setImage(url))
                }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(
            store: URLImageFeature.live,
            url: URL(string: "https://github.com/Ryu0118.png")!
        )
    }
}

struct URLImageFeature: ReducerProtocol {
    struct State: Equatable {
        var image: UIImage
    }
    
    enum Action: Equatable {
        case setImage(URL)
        case imageResponse(TaskResult<UIImage>)
    }
    
    @Dependency(\.imageFetcher) var imageFetcher
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .setImage(url):
            return .task {
                await .imageResponse(
                    TaskResult { try await imageFetcher.fetchImage(with: url) }
                )
            }
        case let .imageResponse(.success(image)):
            state.image = image
            return .none
        case .imageResponse(_):
            return .none
        }
    }
}

extension URLImageFeature {
    static let live = StoreOf<Self>(
        initialState: URLImageFeature.State(image: UIImage()),
        reducer: URLImageFeature()
    )
}

private struct URLImageKey: DependencyKey {
    static let liveValue: ImageFetcher = ImageFetcherImpl.shared
}

extension DependencyValues {
    var imageFetcher: ImageFetcher {
        get { self[URLImageKey.self] }
        set { self[URLImageKey.self] = newValue }
    }
}
