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
                id: item.id,
                avatarURL: item.owner.avatarUrl,
                name: item.fullName,
                description: item.description,
                language: item.language,
                stars: item.stargazersCount
            )
            
            items.append(item)
        }
        
        self.items = items
    }
    
    public init(items: [Item]) {
        self.items = items
    }
}

private struct _GithubResponse: Decodable {
    let items: [Item]
    
    struct Item: Decodable {
        let id: Int
        let owner: Owner
        let fullName: String
        let description: String?
        let language: String?
        let stargazersCount: Int
        
        struct Owner: Decodable {
            let avatarUrl: String
        }
    }
}

private extension _GithubResponse.Item {
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case fullName = "full_name"
        case description
        case language
        case stargazersCount = "stargazers_count"
    }
}

private extension _GithubResponse.Item.Owner {
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}
