//
//  GithubRepositoryCell.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import SwiftUI
import Domain
import ComposableArchitecture

struct GithubRepositoryCell: View {
    let store: StoreOf<CellReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0.item }) { viewStore in
            VStack {
                URLImage(url: URL(string: viewStore.avatarURL)!)
                    .frame(width: 100, height: 100)
                
                repositoryName(viewStore.name)
                
                description(viewStore.description)
                
                bottom(stars: viewStore.stars, language: viewStore.language)
            }
            .padding(5)
            .onTapGesture {
                viewStore.send(.onTapGesture)
            }
            .alert(
                store.scope(state: \.alert),
                dismiss: .cancelTapped
            )
        }
    }
    
    func repositoryName(_ name: String) -> some View {
        Text(name)
            .font(.headline)
    }
    
    func description(_ description: String?) -> some View {
        Text(description ?? "No Description")
            .font(.headline)
    }
    
    func bottom(stars: Int, language: String?) -> some View {
        HStack {
            HStack(spacing: 5) {
                Image(systemName: "star.fill")
                Text("\(stars)")
            }
            .frame(maxWidth: .infinity)
            
            Text(language ?? "No Language")
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}
