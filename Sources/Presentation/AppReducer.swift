//
//  AppReducer.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import Foundation
import ComposableArchitecture
import Domain

public struct AppReducer: ReducerProtocol {
    @Dependency(\.githubRepository) var githubRepository
    @Dependency(\.uuid) var uuid
    
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
                let states = items.map { CellReducer.State(id: uuid.callAsFunction(), item: $0) }
                state.cellStates = IdentifiedArrayOf(uniqueElements: states)
                
                return .none
                
            case let .githubResponse(.failure(error)):
                print(error)
                return .none
                
            case .binding(\.$text):
                if state.text.isEmpty { //SearchBarのtextがisEmptyになった場合, Listを空に
                    state.cellStates = []
                }
                
                return .none
                
            case .cell:
                return .none
                
            case .binding:
                return .none
            }
        }
        .forEach(\.cellStates, action: /Action.cell(id:action:)) {
            CellReducer()
        }
        
    }

}

// MARK: - State & Action
extension AppReducer {
    public struct State: Equatable {
        @BindableState public var text: String
        public var cellStates: IdentifiedArrayOf<CellReducer.State>
        
        public init(
            text: String = "",
            cellStates: IdentifiedArrayOf<CellReducer.State> = []
        ) {
            self.text = text
            self.cellStates = cellStates
        }
    }
    
    public enum Action: Equatable, BindableAction {
        case searchButtonTapped
        case githubResponse(TaskResult<[GithubResponse.Item]>)
        case cell(id: UUID, action: CellReducer.Action)
        case binding(BindingAction<State>)
    }
}
