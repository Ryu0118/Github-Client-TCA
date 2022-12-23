//
//  ImageFetcher.swift
//  
//
//  Created by ryunosuke.shibuya on 2022/12/23.
//

import Foundation
import class UIKit.UIImage

public protocol ImageFetcher {
    func fetchImage(with url: URL) async throws -> UIImage
}
