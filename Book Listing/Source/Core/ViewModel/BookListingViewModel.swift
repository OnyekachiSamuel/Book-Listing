//
//  BookListingViewModel.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import Foundation

protocol BookListingViewModelDelegate: NSObject {
    func didFetchBookList(totalCount: Int, viewModel: [BookListingCellViewModel])
    func bookListFetchFailed(with error: String)
    
}

class BookListingViewModel {
    
    weak var delegate: BookListingViewModelDelegate?
    
    public private(set) var bookListingCellViewModel: [BookListingCellViewModel] = []
    
    private let client: APIClientProtocol
    private var nextPageToken = ""
    
    internal let alertTitle = "Error Log"
    internal let headerTitle = "Query: Harry"
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func fetchBookList() {
        
        let requestBuilder: RequestBuilder
        var parameters = [Parameter(key: "query", value: "harry"),
                          Parameter(key: "page", value: nextPageToken)]
        
        if !nextPageToken.isEmpty {
            requestBuilder = RequestBuilder(parameters: parameters)
        } else {
            _ = parameters.popLast()
            requestBuilder = RequestBuilder(parameters: parameters)
        }
        
        client.fetchBookList(with: requestBuilder) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                case .success(let book):
                    self.nextPageToken = book.nextPageToken
                    self.bookListingCellViewModel = book.items.map { BookListingCellViewModel($0) }
                    DispatchQueue.main.async {
                        self.delegate?.didFetchBookList(totalCount: book.totalCount,
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
