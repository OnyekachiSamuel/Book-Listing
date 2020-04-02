//
//  MockAPIClientTests.swift
//  Book ListingTests
//
//  Created by Onyekachi Ezeoke on 02/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import XCTest
@testable import Book_Listing

class MockAPIClientTests: XCTestCase {
    
    var mockAPIClient: MockAPIClient?
    
    let authors = [Author(name: "John"), Author(name: "Newman"), Author(name: "Greg")]
    let narrators = [Narrator(name: "Kachi"), Narrator(name: "CJ")]
    let parts: [Part] = {
        let coverImage = CoverImage(url: "hhhh", height: 650, width: 380)
        return [Part(cover: coverImage)]
    }()
    
    override func setUpWithError() throws {
        mockAPIClient = MockAPIClient()
    }

    override func tearDownWithError() throws {
        mockAPIClient = nil
    }

    func testUnknownError() throws {
        let requestBuilder = RequestBuilder(parameters: ["query":"harry"])
        mockAPIClient?.fetchBookList(with: requestBuilder, completion: { result in
            switch result {
                case .success(_):
                    XCTAssert(false, "Expected an error result")
                case .failure(let error):
                    XCTAssertEqual(error.reason, "An unknown error occured")
            }
        })
    }
    
    func testSuccessfulRequest() throws {
        let requestBuilder = RequestBuilder(parameters: ["query":"harry"])
        let item = Item(authors: authors, narrators: narrators, parts: parts, title: "Harry")
        let book = Book(items: [item], nextPageToken: "HJDJIEJE", totalCount: 38, query: "harry")
        mockAPIClient?.book = book
        mockAPIClient?.fetchBookList(with: requestBuilder, completion: { result in
            switch result {
                case .success(let book):
                    XCTAssertEqual(book.query, "harry")
                    XCTAssertEqual(book.nextPageToken, "HJDJIEJE")
                    XCTAssertEqual(book.totalCount, 38)
                    XCTAssertEqual(book.items.count, 1)
                case .failure(_):
                    XCTAssert(false, "Expected successful result")
            }
        })
    }
}
