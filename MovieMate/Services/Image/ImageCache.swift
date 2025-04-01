//
//  ImageCache.swift
//  MovieMate
//
//  Created by Karlis Berzins on 01/04/2025.
//

import Foundation
import UIKit

struct ImageCache: ImageCaching {
    private let cache = URLCache.shared

    init() {
        cache.memoryCapacity = 50 * 1024 * 1024
        cache.diskCapacity = 100 * 1024 * 1024
    }

    func image(for url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)

        if let cachedResponse = cache.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw ImageCacheError.invalidData
        }

        let cachedResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedResponse, for: request)

        return image
    }
}

enum ImageCacheError: Error {
    case invalidData
}
