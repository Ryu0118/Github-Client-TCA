//
//  GithubAPIClient.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Foundation
import Domain

struct GithubAPIClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
}

extension GithubAPIClient {
    func send<Request: GithubAPIRequest>(_ request: Request) async throws -> Data {
        guard let urlRequest = request.buildRequest() else {
            throw GithubAPIClientError.invalidRequest
        }
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return data
    }
}

enum GithubAPIClientError: Error {
    case invalidRequest
}
