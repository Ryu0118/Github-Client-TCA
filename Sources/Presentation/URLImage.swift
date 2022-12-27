//
//  URLImage.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import SwiftUI
import ComposableArchitecture

struct URLImage: View {
    let store: StoreOf<URLImageReducer>
    
    init(url: URL) {
        store = StoreOf<URLImageReducer>(
            initialState: URLImageReducer.State(url: url),
            reducer: URLImageReducer()
        )
        
        ViewStore(store)
            .send(.viewInitialized) //Viewが再描画されたときにImageが表示されないバグを修正(onAppearが呼ばれないため起こった)
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Image(uiImage: viewStore.state.image)
                .resizable()
                .scaledToFit()
                .animation(.default, value: viewStore.state.image)
                .onAppear {
                    viewStore.send(.onAppear)
                }
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: URL(string: "https://github.com/Ryu0118.png")!)
    }
}
