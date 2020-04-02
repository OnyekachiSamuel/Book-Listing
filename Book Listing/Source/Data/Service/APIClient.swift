//
//  APIClient.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import Foundation

enum APIError: Error {
    case unknownError
    case serverError
    case noData
    
    var reason: String {
        switch self {
            case .unknownError:
                return "An error occured"
            case .serverError:
                return "Internal server error occured"
            case .noData:
                return "An error occured while decoding data"
        }
    }
}

class APIClient {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchBookList(with requestBuilder: RequestBuilder, completion: @escaping (Result<Book, APIError>) -> Void) {
        guard let request = requestBuilder.getURLRequest() else { return }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data,
                let result = try? JSONDecoder().decode(Book.self, from: data) else {
                    completion(Result.failure(.noData))
                    return
            }
            
            completion(Result.success(result))
        }
        task.resume()
    }
}
