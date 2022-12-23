//
//  GithubRepositoryMock.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Foundation

struct GithubRepositoryMock: GithubRepository {
    func fetchRepositories(query: String) async throws -> GithubResponse {
        .mock()
    }
}
