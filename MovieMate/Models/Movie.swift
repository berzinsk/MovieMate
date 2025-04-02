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
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let originalLanguage: String

    var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: releaseDate) else { return releaseDate }
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    var formattedPopularity: String {
        String(format: "%.1f", popularity)
    }

    var formattedVoteAverage: String {
        String(format: "%.1f", voteAverage)
    }

    var formattedVoteCount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: voteCount)) ?? "0"
    }

    var languageName: String {
        let locale = Locale(identifier: originalLanguage)
        return locale.localizedString(forLanguageCode: originalLanguage)?.capitalized ?? originalLanguage.uppercased()
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
    }
}
