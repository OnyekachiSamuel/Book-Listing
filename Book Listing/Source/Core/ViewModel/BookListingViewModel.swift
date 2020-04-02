//
//  BookListingViewModel.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import Foundation

protocol BookListingViewModelDelegate: NSObject {
    func didFetchBookList(_ nextPageToken: String, title: String, totalCount: Int, viewModel: [BookListingCellViewModel])
    func bookListFetchFailed(with error: String)
    
}

class BookListingViewModel {
    
    public private(set) var bookListingCellViewModel: [BookListingCellViewModel] = []
    private let client: APIClientProtocol
    weak var delegate: BookListingViewModelDelegate?
    
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func fetchBookList(_ nextPageToken: String? = nil) {
        let nextPageToken = nextPageToken ?? ""
        let requestBuilder: RequestBuilder
        var parameter: Parameters = ["query":"harry"]
        
        if !nextPageToken.isEmpty {
            parameter["page"] = nextPageToken
            requestBuilder = RequestBuilder(parameters: parameter)
        } else {
            requestBuilder = RequestBuilder(parameters: parameter)
        }
        
        client.fetchBookList(with: requestBuilder) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                case .success(let book):
                    let title = "Query: \(book.query)".capitalized
                    self.bookListingCellViewModel = book.items.map { BookListingCellViewModel($0) }
                    DispatchQueue.main.async {
                        self.delegate?.didFetchBookList(book.nextPageToken,
                                                        title: title,
                                                        totalCount: book.totalCount,
                                                        viewModel: self.bookListingCellViewModel)
                }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.delegate?.bookListFetchFailed(with: error.reason)
                }
            }
        }
    }
}
