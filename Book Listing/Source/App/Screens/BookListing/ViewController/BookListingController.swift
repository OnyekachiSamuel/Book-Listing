//
//  ViewController.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import UIKit

class BookListingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel = BookListingViewModel()
        viewModel.delegate = self
        viewModel.fetchBookList()
    }
    
    var viewModel: BookListingViewModel!
    var nextPageToken: String!
    var bookListingCellViewModel: [BookListingCellViewModel] = []
    var totalCount = 0
    var headerTitle: String?
}

private extension BookListingController {
    func setupViews() {
        view.backgroundColor = .orange
    }
}

extension BookListingController: BookListingViewModelDelegate {
    func didFetchBookList(_ nextPageToken: String, title: String, totalCount: Int, viewModel: [BookListingCellViewModel]) {
        
        self.bookListingCellViewModel.append(contentsOf: viewModel)
        self.headerTitle = title
        self.nextPageToken = nextPageToken
        self.totalCount = totalCount
    }
    
    func bookListFetchFailed(with error: String) {
        
    }
}

