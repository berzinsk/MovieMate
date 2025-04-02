//
//  MovieViewModelTests.swift
//  MovieMateTests
//
//  Created by Karlis Berzins on 02/04/2025.
//

import XCTest
@testable import MovieMate

final class HomeViewModelTests: XCTestCase {
    private var sut: MovieViewModel!
    private var mockRepository: MockMovieRepository!
    private var mockImageCache: MockImageCache!

    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        mockImageCache = MockImageCache()
        sut = MovieViewModel(repository: mockRepository, imageCache: mockImageCache)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        mockImageCache = nil
        super.tearDown()
    }

    func test_start_whenSuccessful_loadsMovies() async {
        let movies = [
            Movie(
                id: 1,
                title: "Test Movie",
                overview: "Test Overview",
                posterPath: "/test.jpg",
                backdropPath: "/backdrop.jpg",
                releaseDate: "2024-01-01",
                voteAverage: 8.5,
                voteCount: 1000,
                popularity: 100.0,
                originalLanguage: "en"
            )
        ]
        mockRepository.setMovies(movies)

        await sut.start()

        XCTAssertEqual(sut.movies.count, 1)
        XCTAssertEqual(sut.movies.first?.id, 1)
        XCTAssertEqual(sut.state, .loaded)
    }

    func test_start_whenFails_setsErrorState() async {
        mockRepository.setShouldThrowError(true)

        await sut.start()

        XCTAssertTrue(sut.movies.isEmpty)
        XCTAssertEqual(sut.state, .error)
    }
}

// MARK: - Mock Repository
private class MockMovieRepository: MovieRepositoryProtocol {
    private var shouldThrowError = false
    private var movies: [Movie] = []

    func setShouldThrowError(_ shouldThrow: Bool) {
        shouldThrowError = shouldThrow
    }

    func setMovies(_ movies: [Movie]) {
        self.movies = movies
    }

    func getMovies() async throws -> [Movie] {
        if shouldThrowError {
            throw MovieRepositoryError.remoteError(APIError.networkError(withCode: 500))
        }
        return movies
    }

    func refreshMovies() async throws -> [Movie] {
        if shouldThrowError {
            throw MovieRepositoryError.remoteError(APIError.networkError(withCode: 500))
        }
        return movies
    }
}

// MARK: - Mock Image Cache
private class MockImageCache: ImageCaching {
    func image(for url: URL) async throws -> UIImage {
        return UIImage()
    }
}

