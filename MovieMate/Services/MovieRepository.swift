//
//  MovieRepository.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Foundation
import Combine

enum MovieRepositoryError: Error {
    case localStorageError
    case remoteError(Error)
}

protocol MovieRepositoryProtocol {
    func getMovies() async throws -> [Movie]
    func refreshMovies() async throws -> [Movie]
}

class MovieRepository: MovieRepositoryProtocol {
    private let remoteService: MovieService
    private let localService: LocalMovieService

    init(remoteService: MovieService, localService: LocalMovieService) {
        self.remoteService = remoteService
        self.localService = localService
    }

    func getMovies() async throws -> [Movie] {
        if localService.hasStoredMovies() {
            Task {
                try? await refreshMovies()
            }
            return try localService.loadMovies()
        } else {
            return try await refreshMovies()
        }
    }

    func refreshMovies() async throws -> [Movie] {
        do {
            let movies = try await remoteService.getMovies()
            try localService.saveMovies(movies)

            return movies
        } catch {
            throw MovieRepositoryError.remoteError(error)
        }
    }
}
