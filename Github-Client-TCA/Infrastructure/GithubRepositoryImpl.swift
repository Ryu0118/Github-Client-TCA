//
//  GithubRepositoryImpl.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import Foundation

struct GithubRepositoryImpl: GithubRepository {
    
    func fetchRepositories(query: String) async throws -> GithubResponse {
        let url = try buildURL(query: query)
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(GithubResponse.self, from: data)
    }
    
}

private extension GithubRepositoryImpl {
    func buildURL(query: String) throws -> URL {
        var urlComponents = URLComponents(string: "https://api.github.com/search/repositories")
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        
        guard let url = urlComponents?.url else {
            throw GithubRepositoryError.invalidURL
        }
        
        return url
    }
}

enum GithubRepositoryError: Error {
    case invalidURL
}
