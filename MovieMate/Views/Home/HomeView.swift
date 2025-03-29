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
        List(viewModel.movies) { movie in
            MovieRow(for: movie)
        }
        .navigationTitle("Movies")
        .task {
            viewModel.start()
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
    HomeView(viewModel: HomeViewModel())
}
