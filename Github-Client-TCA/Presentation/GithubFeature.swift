//
//  GithubFeature.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import ComposableArchitecture

struct GithubRepositoryFeature: ReducerProtocol {
    struct State: Equatable {
        var items: [GithubResponse.Item]
    }
    
    enum Action: Equatable {
        case searchButtonTapped(String)
        case githubResponse(TaskResult<[GithubResponse.Item]>)
    }
    
    @Dependency(\.githubRepository) var githubRepository
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .searchButtonTapped(text):
            return .task {
                await .githubResponse(
                    TaskResult { try await self.githubRepository.fetchRepositories(query: text).items }
                )
            }
            
        case let .githubResponse(.success(items)):
            state.items = items
            return .none
            
        case .githubResponse(.failure):
            return .none
        }
    }

}

// MARK: - Dependency
private enum GithubRepositoryKey: DependencyKey {
    static let liveValue: GithubRepository = GithubRepositoryImpl()
}

extension DependencyValues {
    var githubRepository: GithubRepository {
        get { self[GithubRepositoryKey.self] }
        set { self[GithubRepositoryKey.self] = newValue }
    }
}
