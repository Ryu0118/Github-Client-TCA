//
//  URLImageCore.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import Foundation
import ComposableArchitecture
import Domain
import Infrastructure
import class UIKit.UIImage

struct URLImageCore: ReducerProtocol {
    struct State: Equatable {
        var image: UIImage = UIImage()
        let url: URL
    }
    
    enum Action: Equatable {
        case setImage
        case imageResponse(TaskResult<UIImage>)
    }
    
    @Dependency(\.imageFetcher) var imageFetcher
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .setImage:
            return .task { [imageUrl = state.url] in
                await .imageResponse(
                    TaskResult { try await imageFetcher.fetchImage(with: imageUrl) }
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
