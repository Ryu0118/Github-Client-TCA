//
//  GithubResponseMock.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Foundation

extension GithubResponse {
    static func mock() -> GithubResponse {
        .init(items: [
            .init(id: 1, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 2, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 3, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 4, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 5, avatarURL: "", name: "", description: "", language: "", stars: 1),
            .init(id: 6, avatarURL: "", name: "", description: "", language: "", stars: 1),
        ])
    }
}

