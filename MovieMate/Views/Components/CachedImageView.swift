//
//  CachedImageView.swift
//  MovieMate
//
//  Created by Karlis Berzins on 01/04/2025.
//

import SwiftUI

struct CachedImageView: View {
    let url: URL
    let cache: ImageCaching
    @State private var image: UIImage?
    @State private var isLoading = true
    @State private var error: Error?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.2))
            } else if error != nil {
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.2))
            }
        }
        .task {
            await loadImage()
        }
    }

    private func loadImage() async {
        do {
            image = try await cache.image(for: url)
        } catch {
            self.error = error
        }

        isLoading = false
    }
}
