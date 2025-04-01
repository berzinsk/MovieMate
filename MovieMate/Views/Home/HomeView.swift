//
//  HomeView.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .scaleEffect(2.0)
            case .loaded:
                List(viewModel.movies) { movie in
                    MovieRow(for: movie)
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

    @ViewBuilder
    func MovieRow(for movie: Movie) -> some View {
        HStack {
            Text(movie.title)
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

    return HomeView(viewModel: HomeViewModel(repository: repository))
}
