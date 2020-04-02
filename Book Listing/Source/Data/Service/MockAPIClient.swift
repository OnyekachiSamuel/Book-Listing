//
//  MockAPIClient.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 02/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import Foundation

class MockAPIClient: APIClientProtocol {
    
    var book: Book?
    
    func fetchBookList(with requestBuilder: RequestBuilder, completion: @escaping (Result<Book, APIError>) -> Void) {
        
        if let book = book {
            completion(.success(book))
        } else {
            completion(.failure(.unknownError))
        }
    }
}
