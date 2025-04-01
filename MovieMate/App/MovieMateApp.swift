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

    init() {
        self.coreDataStack = CoreDataStack()
        self.localService = LocalMovieLoader(coreDataStack: coreDataStack)
        self.remoteService = MovieClient()

        self.repository = MovieRepository(
            remoteService: remoteService,
            localService: localService
        )
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(viewModel: HomeViewModel(repository: repository))
            }
            .onDisappear {
                coreDataStack.saveContext()
            }
        }
    }
}
