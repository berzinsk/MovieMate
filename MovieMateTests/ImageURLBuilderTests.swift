//
//  ImageURLBuilderTests.swift
//  MovieMateTests
//
//  Created by Karlis Berzins on 02/04/2025.
//

import XCTest

import XCTest
@testable import MovieMate

final class ImageURLBuilderTests: XCTestCase {
    private var sut: ImageURLBuilder!

    override func setUp() {
        super.setUp()
        sut = ImageURLBuilder()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_posterURL_whenPathProvided_returnsCorrectURL() {
        let path = "/test.jpg"

        let url = sut.posterURL(for: path)

        XCTAssertEqual(url?.absoluteString, "https://image.tmdb.org/t/p/w500/test.jpg")
    }

    func test_posterURL_whenPathIsNil_returnsNil() {
        let url = sut.posterURL(for: nil)

        XCTAssertNil(url)
    }

    func test_backdropURL_whenPathProvided_returnsCorrectURL() {
        let path = "/test.jpg"

        let url = sut.backdropURL(for: path)

        XCTAssertEqual(url?.absoluteString, "https://image.tmdb.org/t/p/original/test.jpg")
    }

    func test_backdropURL_whenPathIsNil_returnsNil() {
        let url = sut.backdropURL(for: nil)

        XCTAssertNil(url)
    }
}

