//
//  MovieView.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import SwiftUI

struct MovieView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .scaleEffect(2.0)
            case .loaded:
                List(viewModel.movies) { movie in
                    MovieRowView(
                        movie: movie,
                        posterURL: viewModel.posterURL(for: movie),
                        imageCache: viewModel.imageCache
                    )
                }
                .refreshable {
                    await viewModel.refresh()
                }
            case .error:
                VStack {
                    Text("Error loading movies")
                    Button("Try Again") {
                        Task {
                            await viewModel.start()
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .navigationTitle("Movies")
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    let coreDataStack = CoreDataStack()
    let localService = LocalMovieLoader(coreDataStack: coreDataStack)
    let remoteService = MovieMockClient()
    let repository = MovieRepository(
        remoteService: remoteService,
        localService: localService
    )
    let imageCache = ImageCache()

    MovieView(viewModel: HomeViewModel(repository: repository, imageCache: imageCache))
}
