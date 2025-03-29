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
            case .error:
                Text("Error loading countries")
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
    HomeView(viewModel: HomeViewModel(service: MovieMockClient()))
}
