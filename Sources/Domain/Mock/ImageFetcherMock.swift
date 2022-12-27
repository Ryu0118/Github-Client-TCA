//
//  ImageFetcherMock.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Foundation
import class UIKit.UIImage

final class ImageFetcherMock: ImageFetcher {
    func fetchImage(with url: URL) async throws -> UIImage {
        UIImage(systemName: "star")!
    }
    
    func fetchCachedImage(with url: URL) -> UIImage? {
        UIImage()
    }
}
