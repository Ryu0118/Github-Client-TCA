//
//  Dependencies.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import ComposableArchitecture

public enum GithubRepositoryKey: TestDependencyKey {
    public typealias Value = GithubRepository
    public static let testValue: GithubRepository = GithubRepositoryMock()
}

public extension DependencyValues {
    var githubRepository: GithubRepository {
        get { self[GithubRepositoryKey.self] }
        set { self[GithubRepositoryKey.self] = newValue }
    }
}

public enum ImageFetcherKey: TestDependencyKey {
    public typealias Value = ImageFetcher
    public static let testValue: ImageFetcher = ImageFetcherMock()
}

public extension DependencyValues {
    var imageFetcher: ImageFetcher {
        get { self[ImageFetcherKey.self] }
        set { self[ImageFetcherKey.self] = newValue }
    }
}


