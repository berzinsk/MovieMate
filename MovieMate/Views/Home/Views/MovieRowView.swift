//
//  MovieRowView.swift
//  MovieMate
//
//  Created by Karlis Berzins on 01/04/2025.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    let posterURL: String
    let imageCache: ImageCaching

    var body: some View {
        HStack(spacing: 12) {
            if let url = URL(string: posterURL) {
                CachedImageView(url: url, cache: imageCache)
                    .frame(width: 80, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
        .padding(.vertical, 4)
    }
}
