//
//  HomeViewModel.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Combine

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    func start() {
        movies = Movie.previews
    }
}
