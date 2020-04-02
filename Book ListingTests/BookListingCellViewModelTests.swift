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
        let coverImage = CoverImage(url: "hhhh", height: 650, width: 380)
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
    
    func testNarratorsName() throws {
        XCTAssertEqual(viewModel?.narrators, "With: Kachi, CJ")
    }
}
