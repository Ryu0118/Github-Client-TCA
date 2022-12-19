//
//  ImageFetcherImpl.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import Foundation
import class UIKit.UIImage

protocol ImageFetcher {
    func fetchImage(with url: URL) async throws -> UIImage
}

final class ImageFetcherImpl: ImageFetcher {
    static let shared = ImageFetcherImpl()
    
    private var cache = [URL: UIImage]()
    
    private init() {}
    
    func fetchImage(with url: URL) async throws -> UIImage {
        if let cacheImage = cache[url] {
            return cacheImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw ImageFetcherError.invalidData
        }
        
        cache.updateValue(image, forKey: url)
        
        return image
    }
}

enum ImageFetcherError: Error {
    case invalidData
}
