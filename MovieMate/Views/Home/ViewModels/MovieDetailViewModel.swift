//
//  MovieDetailViewModel.swift
//  MovieMate
//
//  Created by Karlis Berzins on 02/04/2025.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    let movie: Movie
    let imageCache: ImageCaching
    private let urlBuilder: ImageURLBuilding

    init(
        movie: Movie,
        imageCache: ImageCaching,
        urlBuilder: ImageURLBuilding = ImageURLBuilder()
    ) {
        self.movie = movie
        self.imageCache = imageCache
        self.urlBuilder = urlBuilder
    }

    var navigationTitle: String {
        movie.title
    }

    var backdropURL: URL? {
        urlBuilder.backdropURL(for: movie.backdropPath)
    }

    var posterURL: URL? {
        urlBuilder.posterURL(for: movie.posterPath)
    }
}
