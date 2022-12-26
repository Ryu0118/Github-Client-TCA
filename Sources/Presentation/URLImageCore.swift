//
//  URLImageCore.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import Foundation
import ComposableArchitecture
import Domain
import class UIKit.UIImage

struct URLImageCore: ReducerProtocol {
    @Dependency(\.imageFetcher) var imageFetcher
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
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

extension URLImageCore {
    struct State: Equatable {
        var image: UIImage = UIImage()
        let url: URL
        
        @Dependency(\.imageFetcher) var imageFetcher
        
        init(url: URL) {
            self.url = url
            //alertタップ時Viewが再更新されるのでonAppearが呼ばれず画像が消えてしまう。
            //このバグを解消するためにimageFetcherにcacheされてる画像をinitialize時に使用
            if let cachedImage = imageFetcher.fetchCachedImage(with: url) {
                self.image = cachedImage
            }
        }
        
        static func == (lhs: URLImageCore.State, rhs: URLImageCore.State) -> Bool {
            lhs.image == rhs.image && lhs.url == rhs.url
        }
    }
    
    enum Action: Equatable {
        case onAppear
        case imageResponse(TaskResult<UIImage>)
    }
}
