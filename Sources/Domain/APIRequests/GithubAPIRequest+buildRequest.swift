//
//  GithubAPIRequest+buildRequest.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Foundation

public extension GithubAPIRequest {
    func buildRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: apiUrl)
        urlComponents?.queryItems = queryItems
        
        guard var url = urlComponents?.url else {
            return nil
        }
        
        url = url.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
