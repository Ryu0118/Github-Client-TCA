//
//  URLImageReducer.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import Foundation
import ComposableArchitecture
import Domain
import class UIKit.UIImage

struct URLImageReducer: ReducerProtocol {
    @Dependency(\.imageFetcher) var imageFetcher
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .task { [imageUrl = state.url] in
                await .imageResponse(
                    TaskResult { try await imageFetcher.fetchImage(with: imageUrl) }
                )
            }
            
        case .viewInitialized:
            state.image = imageFetcher.fetchCachedImage(with: state.url) ?? UIImage()
            
            return .none
            
        case let .imageResponse(.success(image)):
            state.image = image
            return .none
            
        case .imageResponse(_):
            return .none
        }
    }
}

extension URLImageReducer {
    struct State: Equatable {
        var image: UIImage = UIImage()
        let url: URL
    }
    
    enum Action: Equatable {
        case onAppear
        case viewInitialized
        case imageResponse(TaskResult<UIImage>)
    }
}
