//
//  Dependencies.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Domain
import ComposableArchitecture

extension GithubRepositoryKey: DependencyKey {
    public static let liveValue: GithubRepository = GithubRepositoryImpl()
}

extension ImageFetcherKey: DependencyKey {
    public static let liveValue: ImageFetcher = ImageFetcherImpl.shared
}
