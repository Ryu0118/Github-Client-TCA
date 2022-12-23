//
//  AppCore.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import ComposableArchitecture
import Domain
import Infrastructure

public struct AppCore: ReducerProtocol {
    public struct State: Equatable {
        @BindableState public var text = ""
        public var items = [GithubResponse.Item]()
        
        public init() {}
    }
    
    public enum Action: Equatable, BindableAction {
        case searchButtonTapped
        case githubResponse(TaskResult<[GithubResponse.Item]>)
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.githubRepository) var githubRepository
    
    public init() {}
    
    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .searchButtonTapped:
                return .task { [query = state.text] in
                    await .githubResponse(
                        TaskResult { try await githubRepository.fetchRepositories(query: query).items }
                    )
                }
                
            case let .githubResponse(.success(items)):
                state.items = items
                return .none
                
            case let .githubResponse(.failure(error)):
                print(error)
                return .none
                
            case .binding(\.$text):
                if state.text.isEmpty { //SearchBarのtextがisEmptyになった場合, Listを空に
                    state.items = []
                }
                
                return .none
                
            case .binding:
                return .none
            }
        }
        
    }

}

public enum GithubRepositoryKey: DependencyKey {
    public static let liveValue: GithubRepository = GithubRepositoryImpl()
}

extension DependencyValues {
    var githubRepository: GithubRepository {
        get { self[GithubRepositoryKey.self] }
        set { self[GithubRepositoryKey.self] = newValue }
    }
}
