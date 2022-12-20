//
//  URLImage.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import SwiftUI
import ComposableArchitecture

struct URLImage: View {
    let store: StoreOf<URLImageFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Image(uiImage: viewStore.state.image)
                .resizable()
                .scaledToFit()
                .animation(.default, value: viewStore.state.image)
                .onAppear {
                    viewStore.send(.setImage(viewStore.state.url))
                }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(
            store: StoreOf<URLImageFeature>(
                initialState: URLImageFeature.State(url: URL(string: "https://github.com/Ryu0118.png")!),
                reducer: URLImageFeature()
            )
        )
    }
}
