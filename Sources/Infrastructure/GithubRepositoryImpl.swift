//
//  GithubRepositoryImpl.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import Foundation
import Domain

public struct GithubRepositoryImpl: GithubRepository {
    public init() {}
    public func fetchRepositories(query: String) async throws -> GithubResponse {
        let client = GithubAPIClient(urlSession: URLSession.shared)
        let apiRequest = FetchRepositoryRequest(query: query)
        let data = try await client.send(apiRequest)
        return try JSONDecoder().decode(GithubResponse.self, from: data)
    }
}
