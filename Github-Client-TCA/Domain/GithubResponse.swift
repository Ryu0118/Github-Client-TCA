//
//  GithubResponse.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import Foundation

struct GithubResponse: Decodable {
    let items: [Item]

    struct Item: Identifiable, Equatable {
        let id: Int
        let avatarURL: String
        let name: String
        let description: String?
        let language: String?
        let stars: Int
    }
    
    init(from decoder: Decoder) throws {
        let data = try _GithubResponse(from: decoder)
        
        var items = [Item]()
        
        for item in data.items {
            let item = Item(
                id: item.owner.id,
                avatarURL: item.owner.avatar_url,
                name: item.full_name,
                description: item.description,
                language: item.language,
                stars: item.stargazers_count
            )
            
            items.append(item)
        }
        
        self.items = items
    }
    
    init(items: [Item]) {
        self.items = items
    }
}

fileprivate struct _GithubResponse: Decodable {
    let items: [Item]
    
    struct Item: Decodable {
        let owner: Owner
        let full_name: String
        let description: String?
        let language: String?
        let stargazers_count: Int
        
        struct Owner: Decodable {
            let id: Int
            let avatar_url: String
        }
    }
}
