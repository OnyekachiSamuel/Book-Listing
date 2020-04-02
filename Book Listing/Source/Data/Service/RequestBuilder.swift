//
//  Request.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import Foundation

typealias Parameters = [String: String]

struct RequestBuilder {
    private let parameters: Parameters
    private let baseURL = URL(string: "https://api.storytel.net/search?")!
    
    init(parameters: Parameters) {
        self.parameters = parameters
    }
    
    func getURLRequest() -> URLRequest? {
        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        let queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return nil }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
