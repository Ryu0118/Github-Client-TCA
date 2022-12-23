//
//  GithubRepository.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import Foundation

protocol GithubRepository {
    func fetchRepositories(query: String) async throws -> GithubResponse
}
