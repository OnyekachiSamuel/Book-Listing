//
//  ViewController.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import UIKit

class BookListingController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel = BookListingViewModel()
        viewModel.delegate = self
        viewModel.fetchBookList()
    }
    
    // MARK: Private Instance Methods
    
    private var bookListingCellViewModel: [BookListingCellViewModel] = []
    private var totalCount = 0
    private var viewModel: BookListingViewModel!
    
    private let loader = Loader()
}

private extension BookListingController {
    func setupViews() {
        tableView.backgroundView = loader
        loader.startAnimating()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(BookListingCell.self, forCellReuseIdentifier: BookListingCell.reuseIndentifier)
        tableView.register(BookListingHeaderView.self, forHeaderFooterViewReuseIdentifier: BookListingHeaderView.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    func setLoaderConstraint() {
        let constraints = [
            loader.topAnchor.constraint(equalTo: view.topAnchor),
            loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func presentAlert(with message: String) {
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alertController = UIAlertController(title: viewModel.alertTitle, message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension BookListingController: BookListingViewModelDelegate {
    
    func didFetchBookList(totalCount: Int, viewModel: [BookListingCellViewModel]) {
        
        if bookListingCellViewModel.isEmpty {
            loader.stopAnimating()
        }
        
        self.bookListingCellViewModel.append(contentsOf: viewModel)
        self.totalCount = totalCount
        self.tableView.reloadData()
    }
    
    func bookListFetchFailed(with error: String) {
        loader.stopAnimating()
        presentAlert(with: error)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookListingCellViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookListingCell.reuseIndentifier, for: indexPath) as! BookListingCell
        
        let viewModel = bookListingCellViewModel[indexPath.row]
        cell.viewModel = viewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BookListingHeaderView.reuseIdentifier) as? BookListingHeaderView
        headerView?.titleLabel.text = viewModel.headerTitle
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 44.0)
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if bookListingCellViewModel.count == totalCount + 2 {
            tableView.tableFooterView?.isHidden = true
            return
        }
        
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            spinner.startAnimating()
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            viewModel.fetchBookList()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
}

