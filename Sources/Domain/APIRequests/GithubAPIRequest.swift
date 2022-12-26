//
//  GithubAPIRequest.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    // get以外のrequestを送る際はここに追加
}

public protocol GithubAPIRequest {
    var apiUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    //requestBodyが必要であればここにプロパティを追加
}
