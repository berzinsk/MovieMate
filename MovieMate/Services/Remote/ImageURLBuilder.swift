//
//  ImageURLBuilder.swift
//  MovieMate
//
//  Created by Karlis Berzins on 02/04/2025.
//

import Foundation

protocol ImageURLBuilding {
    func posterURL(for path: String?) -> URL?
    func backdropURL(for path: String?) -> URL?
}

struct ImageURLBuilder: ImageURLBuilding {
    private let baseURL: String
    private let posterSize: String
    private let backdropSize: String

    init(
        baseURL: String = "https://image.tmdb.org",
        posterSize: String = "w500",
        backdropSize: String = "original"
    ) {
        self.baseURL = baseURL
        self.posterSize = posterSize
        self.backdropSize = backdropSize
    }

    func posterURL(for path: String?) -> URL? {
        guard let path = path else { return nil }
        return URL(string: "\(baseURL)/t/p/\(posterSize)\(path)")
    }

    func backdropURL(for path: String?) -> URL? {
        guard let path = path else { return nil }
        return URL(string: "\(baseURL)/t/p/\(backdropSize)\(path)")
    }
}
