//
//  FetchRepositoryRequest.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Foundation

public struct FetchRepositoryRequest {
    public let query: String
    public init(query: String) {
        self.query = query
    }
}

extension FetchRepositoryRequest: GithubAPIRequest {
    public var apiUrl: String {
        "https://api.github.com"
    }
    
    public var path: String {
        "search/repositories"
    }
    
    public var method: HTTPMethod {
        .get
    }
    
    public var queryItems: [URLQueryItem] {
        [
            .init(name: "q", value: query)
        ]
    }
}

