//
//  LocalMovieLoader.swift
//  MovieMate
//
//  Created by Karlis Berzins on 29/03/2025.
//

import Foundation
import CoreData

protocol LocalMovieService {
    func loadMovies() throws -> [Movie]
    func saveMovies(_ movies: [Movie]) throws
    func hasStoredMovies() -> Bool
}

class LocalMovieLoader: LocalMovieService {
    private let context: NSManagedObjectContext

    init(coreDataStack: CoreDataStackProtocol) {
        self.context = coreDataStack.viewContext
    }

    func loadMovies() throws -> [Movie] {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "popularity", ascending: false)]

        let entities = try context.fetch(request)
        return entities.map { entity in
            let movie = Movie(
                id: Int(entity.id),
                title: entity.title ?? "",
                overview: entity.overview ?? "",
                posterPath: entity.posterPath ?? "",
                backdropPath: entity.backdropPath,
                releaseDate: entity.releaseDate ?? "",
                voteAverage: entity.voteAverage,
                voteCount: Int(entity.voteCount),
                popularity: entity.popularity,
                originalLanguage: entity.originalLanguage ?? "en"
            )
            return movie
        }
    }

    func saveMovies(_ movies: [Movie]) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MovieEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        try context.execute(deleteRequest)

        let currentDate = Date()
        for movie in movies {
            let entity = MovieEntity(context: context)
            entity.id = Int64(movie.id)
            entity.title = movie.title
            entity.overview = movie.overview
            entity.popularity = movie.popularity
            entity.releaseDate = movie.releaseDate
            entity.posterPath = movie.posterPath
            entity.backdropPath = movie.backdropPath
            entity.voteAverage = movie.voteAverage
            entity.voteCount = Int64(movie.voteCount)
            entity.originalLanguage = movie.originalLanguage
            entity.lastFetchDate = currentDate
        }

        try context.save()
    }

    func hasStoredMovies() -> Bool {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        request.fetchLimit = 1

        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking for stored movies: \(error)")
            return false
        }
    }
}
