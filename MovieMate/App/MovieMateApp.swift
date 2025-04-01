//
//  MovieMateApp.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import SwiftUI

@main
struct MovieMateApp: App {
    private let coreDataStack: CoreDataStackProtocol
    private let localService: LocalMovieService
    private let remoteService: MovieService
    private let repository: MovieRepositoryProtocol
    private let imageCache: ImageCaching

    init() {
        self.coreDataStack = CoreDataStack()
        self.localService = LocalMovieLoader(coreDataStack: coreDataStack)
        self.remoteService = MovieClient()
        self.imageCache = ImageCache()

        self.repository = MovieRepository(
            remoteService: remoteService,
            localService: localService
        )
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieView(viewModel: HomeViewModel(repository: repository, imageCache: imageCache))
            }
            .onDisappear {
                coreDataStack.saveContext()
            }
        }
    }
}
