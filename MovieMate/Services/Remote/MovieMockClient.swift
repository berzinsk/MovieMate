//
//  MovieMockClient.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Foundation

struct MovieMockClient: MovieService {
    func getMovies() async throws -> [Movie] {
        Movie.previews
    }
}
