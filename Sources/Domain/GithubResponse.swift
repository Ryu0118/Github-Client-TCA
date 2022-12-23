//
//  GithubResponse.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import Foundation

public struct GithubResponse: Decodable {
    public let items: [Item]

    public struct Item: Identifiable, Equatable {
        public let id: Int
        public let avatarURL: String
        public let name: String
        public let description: String?
        public let language: String?
        public let stars: Int
        
        public init(id: Int, avatarURL: String, name: String, description: String?, language: String?, stars: Int) {
            self.id = id
            self.avatarURL = avatarURL
            self.name = name
            self.description = description
            self.language = language
            self.stars = stars
        }
    }
    
    public init(from decoder: Decoder) throws {
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
    
    public init(items: [Item]) {
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
