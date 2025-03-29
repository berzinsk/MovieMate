//
//  Movie.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Foundation

struct Root: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String
    let popularity: Double
    let releaseDate: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
