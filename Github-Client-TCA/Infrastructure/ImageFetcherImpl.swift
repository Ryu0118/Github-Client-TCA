//
//  ImageFetcherImpl.swift
//  Github-Client-TCA
//
//  Created by ryunosuke.shibuya on 2022/12/19.
//

import Foundation
import class UIKit.UIImage

protocol ImageFetcher {
    func fetchImage(with url: URL) async throws -> UIImage?
}

final class ImageFetcherImpl: ImageFetcher {
    private var cache = [URL: UIImage?]()
    
    func fetchImage(with url: URL) async throws -> UIImage? {
        if let cacheImage = cache[url], let cacheImage {
            return cacheImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let image = UIImage(data: data)
        
        cache.updateValue(image, forKey: url)
        
        return image
    }
}
