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

    private let service: MovieService

    init(service: MovieService) {
        self.service = service
    }

    @MainActor
    func start() async {
        state = .loading

        do {
            movies = try await service.getMovies()
            state = .loaded
        } catch {
            print("Unable to get movies")
            state = .error
        }
    }
}
