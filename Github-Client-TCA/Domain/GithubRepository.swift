//
//  GithubRepository.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/16.
//

import Foundation

protocol GithubRepository {
    func fetchData() async throws -> GithubResponse
}
