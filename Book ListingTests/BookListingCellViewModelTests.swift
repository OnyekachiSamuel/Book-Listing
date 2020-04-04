//
//  BookListingCellViewModelTests.swift
//  Book ListingTests
//
//  Created by Onyekachi Ezeoke on 02/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import XCTest
@testable import Book_Listing

class BookListingCellViewModelTests: XCTestCase {
    var viewModel: BookListingCellViewModel?
    let authors = [Author(name: "John"), Author(name: "Newman"), Author(name: "Greg")]
    let narrators = [Narrator(name: "Kachi"), Narrator(name: "CJ")]
    let parts: [Part] = {
        let coverImage = CoverImage(url: "https://www.storytel.se/images/9781839520716/640x640/cover.jpg", height: 650, width: 380)
        return [Part(cover: coverImage)]
    }()
    
    override func setUpWithError() throws {
        let item = Item(authors: authors, narrators: narrators, parts: parts, title: "Harry")
        viewModel = BookListingCellViewModel(item)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testTitle() throws {
        XCTAssertEqual(viewModel?.title, "Harry")
    }
    
    func testAuthorsName() throws {
        XCTAssertEqual(viewModel?.authors, "By: John, Newman, Greg")
    }
    
    func testEmptyAuthorsName() throws {
        let item = Item(authors: [], narrators: narrators, parts: parts, title: "Harry")
        viewModel = BookListingCellViewModel(item)
        XCTAssertEqual(viewModel?.authors, "")
    }
    
    func testNarratorsName() throws {
        XCTAssertEqual(viewModel?.narrators, "With: Kachi, CJ")
    }
    
    func testEmptyNarratorsName() throws {
        let item = Item(authors: authors, narrators: [], parts: parts, title: "Harry")
        viewModel = BookListingCellViewModel(item)
        XCTAssertEqual(viewModel?.narrators, "")
    }
    
    func testImageURL() throws {
        let url = URL(string: "https://www.storytel.se/images/9781839520716/640x640/cover.jpg")!
        XCTAssertEqual(viewModel?.url, url)
    }
}
