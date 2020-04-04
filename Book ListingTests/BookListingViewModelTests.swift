//
//  BookListingViewModelTests.swift
//  Book ListingTests
//
//  Created by Onyekachi Ezeoke on 02/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import XCTest
@testable import Book_Listing

class BookListingViewModelTests: XCTestCase {
    var viewModel: BookListingViewModel?
    let mockAPIClient = MockAPIClient()

    let authors = [Author(name: "John"), Author(name: "Newman"), Author(name: "Greg")]
    let narrators = [Narrator(name: "Kachi"), Narrator(name: "CJ")]
    let parts: [Part] = {
        let coverImage = CoverImage(url: "hhhh", height: 650, width: 380)
        return [Part(cover: coverImage)]
    }()
    
    override func setUpWithError() throws {
        viewModel = BookListingViewModel(client: mockAPIClient)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testHeaderTitle() throws {
        XCTAssertEqual(viewModel?.headerTitle, "Query: Harry")
    }
    
    func testAlertTitle() throws {
        XCTAssertEqual(viewModel?.alertTitle, "Error Log")
    }
    
    func testFailedRequest() throws {
        viewModel?.fetchBookList()
        XCTAssertEqual(viewModel?.bookListingCellViewModel.count, 0)
    }

    func testSuccessfulFetchRequest() throws {
        let item = Item(authors: authors, narrators: narrators, parts: parts, title: "Harry")
        let book = Book(items: [item], nextPageToken: "HJDJIEJE", totalCount: 38, query: "harry")
        mockAPIClient.book = book
        viewModel?.fetchBookList()
        XCTAssertEqual(viewModel?.bookListingCellViewModel.count, 1)
    }
}
