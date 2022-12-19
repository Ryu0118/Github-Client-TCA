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
    let url: URL
    
    var body: some View {
        WithViewStore(store, observe: \.image) { viewStore in
            Image(uiImage: viewStore.state)
                .resizable()
                .scaledToFit()
                .animation(.default, value: viewStore.state)
                .onAppear {
                    viewStore.send(.setImage(url))
                }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(
            store: URLImageFeature.live,
            url: URL(string: "https://github.com/Ryu0118.png")!
        )
    }
}
