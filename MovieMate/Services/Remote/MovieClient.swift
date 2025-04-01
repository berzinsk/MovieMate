//
//  MovieClient.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Foundation

enum APIError: Error {
    case url
    case decoding
    case networkError(withCode: Int)
}

struct MovieClient: MovieService {
    enum Paths: String {
        case popular = "/movie/popular"
    }
    private let baseUrl: String

    init(baseUrl: String = "https://api.themoviedb.org/3") {
        self.baseUrl = baseUrl
    }

    func getMovies() async throws -> [Movie] {
        guard let requestURL = URL(string: "\(baseUrl)\(Paths.popular.rawValue)") else {
            throw APIError.url
        }

        var request = URLRequest(url: requestURL)
        request.setValue("Bearer \(APIConfig.accessToken)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode != 200 {
            throw APIError.networkError(withCode: urlResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(Root.self, from: data).results
        } catch {
            throw APIError.decoding
        }
    }
}
