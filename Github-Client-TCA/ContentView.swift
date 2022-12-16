//
//  ContentView.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import SwiftUI
import Infrastructure

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
