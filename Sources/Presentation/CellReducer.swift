//
//  CellReducer.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/25.
//

import Foundation
import ComposableArchitecture
import Domain

public struct CellReducer: ReducerProtocol {
    public struct State: Equatable, Identifiable {
        public var id: UUID
        public var item: GithubResponse.Item
        public var alert: AlertState<Action>?
        
        public init(id: UUID, item: GithubResponse.Item, alert: AlertState<Action>? = nil) {
            self.id = id
            self.item = item
            self.alert = alert
        }
    }
    
    public enum Action: Equatable {
        case onTapGesture
        case cancelTapped
    }
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onTapGesture:
            state.alert = .init(
                title: TextState(state.item.name),
                message: {
                    let alertText =
                    """
                    description: \(state.item.description ?? "No Description")
                    language: \(state.item.language ?? "No Language")
                    star: \(state.item.stars)
                    """
                    return TextState(alertText)
                }()
            )
            
            return .none
            
        case .cancelTapped:
            state.alert = nil //同じCellを2回タップした際に違う文字が表示されるバグを修正
            
            return .none
        }
    }
}
