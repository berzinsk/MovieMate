//
//  HomeViewModel.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Combine

class HomeViewModel: ObservableObject {
    enum State {
        case loading
        case loaded
        case error
    }

    @Published var movies: [Movie] = []
    @Published var state: State = .loading
    @Published var isRefreshing: Bool = false

    private let repository: MovieRepositoryProtocol
    private(set) var imageCache: ImageCaching

    init(repository: MovieRepositoryProtocol, imageCache: ImageCaching) {
        self.repository = repository
        self.imageCache = imageCache
    }

    @MainActor
    func start() async {
        state = .loading

        do {
            movies = try await repository.getMovies()
            state = .loaded
        } catch {
            print("Unable to get movies: \(error)")
            state = .error
        }
    }

    @MainActor
    func refresh() async {
        guard !isRefreshing else { return }

        isRefreshing = true

        do {
            movies = try await repository.refreshMovies()
        } catch {
            print("Unable to refresh movies: \(error)")
        }

        isRefreshing = false
    }

    func posterURL(for movie: Movie) -> String {
        APIConstants.posterBaseURL + movie.posterPath
    }
}
