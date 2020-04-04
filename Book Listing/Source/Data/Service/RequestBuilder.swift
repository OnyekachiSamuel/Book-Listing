//
//  Request.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import Foundation

struct Parameter {
    let key: String
    let value: String
}

struct RequestBuilder {
    private let parameters: [Parameter]
    private let baseURL = URL(string: "https://api.storytel.net/search?")!
    
    init(parameters: [Parameter]) {
        self.parameters = parameters
    }
    
    func getURLRequest() -> URLRequest? {
        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return nil }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
