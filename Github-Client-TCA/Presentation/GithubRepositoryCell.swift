//
//  GithubRepositoryCell.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import SwiftUI
import ComposableArchitecture

struct GithubRepositoryCell: View {
    let item: GithubResponse.Item
    
    var body: some View {
        VStack {
            URLImage(
                store: URLImageFeature.live,
                url: URL(string: item.avatarURL)!
            )
            
            repositoryName
            
            description
            
            bottom
        }
    }
    
    var repositoryName: some View {
        Text(item.name)
            .font(.headline)
    }
    
    var description: some View {
        Text(item.description)
            .font(.caption)
    }
    
    var bottom: some View {
        HStack {
            HStack(spacing: 5) {
                Image(systemName: "star.fill")
                Text("\(item.stars)")
            }
            .frame(maxWidth: .infinity)
            
            Text(item.language ?? "No Language")
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

struct GithubRepositoryCell_Previews: PreviewProvider {
    static var previews: some View {
        GithubRepositoryCell(
            item: .init(
                id: 1,
                avatarURL: "https://github.com/Ryu0118.png",
                name: "Ryu0118/XCContributeRank",
                description: "XCContributeRank is a CLI tool that allows you to check the number of lines of code, files, and comments for each person in your Xcode project.",
                language: "Swift",
                stars: 5000
            )
        )
    }
}