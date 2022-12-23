//
//  URLImage.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import SwiftUI
import ComposableArchitecture

struct URLImage: View {
    let store: StoreOf<URLImageCore>
    
    init(url: URL) {
        store = StoreOf<URLImageCore>(
            initialState: URLImageCore.State(url: url),
            reducer: URLImageCore()
        )
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Image(uiImage: viewStore.state.image)
                .resizable()
                .scaledToFit()
                .animation(.default, value: viewStore.state.image)
                .onAppear {
                    viewStore.send(.setImage)
                }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: URL(string: "https://github.com/Ryu0118.png")!)
    }
}
