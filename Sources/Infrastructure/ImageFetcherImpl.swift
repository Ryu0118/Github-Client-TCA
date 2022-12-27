//
//  ImageFetcherImpl.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import Foundation
import Domain
import class UIKit.UIImage

public final class ImageFetcherImpl: ImageFetcher {
    public static let shared = ImageFetcherImpl()
    
    private var cache = [URL: UIImage]()
    
    private init() {}
    
    public func fetchImage(with url: URL) async throws -> UIImage {
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
    
    public func fetchCachedImage(with url: URL) -> UIImage? {
        cache[url]
    }
}

enum ImageFetcherError: Error {
    case invalidData
}
