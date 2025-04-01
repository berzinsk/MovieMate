//
//  MovieService.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Foundation

protocol MovieService {
    func getMovies() async throws -> [Movie]
}
