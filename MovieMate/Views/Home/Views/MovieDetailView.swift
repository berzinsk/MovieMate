//
//  MovieDetailView.swift
//  MovieMate
//
//  Created by Karlis Berzins on 02/04/2025.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Poster()
                VStack(alignment: .leading, spacing: 20) {
                    Text(viewModel.movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                    RatingRow()
                    Text("Overview")
                        .font(.headline)
                    Text(viewModel.movie.overview)
                        .font(.body)
                    ReleaseDate()
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    func Poster() -> some View {
        if let backdropURL = viewModel.backdropURL {
            CachedImageView(url: backdropURL, cache: viewModel.imageCache)
                .frame(height: 200)
                .clipped()
        }
    }

    @ViewBuilder
    func RatingRow() -> some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Label(viewModel.movie.formattedVoteAverage, systemImage: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(viewModel.movie.formattedVoteCount) votes")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading) {
                Label(viewModel.movie.formattedPopularity, systemImage: "chart.line.uptrend.xyaxis")
                Text("Popularity")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading) {
                Label(viewModel.movie.languageName, systemImage: "globe")
                Text("Language")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }

    @ViewBuilder
    func ReleaseDate() -> some View {
        Label(viewModel.movie.formattedReleaseDate, systemImage: "calendar")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}

#Preview {
    MovieDetailView(viewModel: MovieDetailViewModel(
        movie: Movie.previews[0],
        imageCache: ImageCache(),
        urlBuilder: ImageURLBuilder(baseURL: "https://example.com")
    ))
}
