//
//  BookListingHeaderView.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 02/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import UIKit

class BookListingHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = String(describing: self)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        return view
    }()
}

private extension BookListingHeaderView {
    func setupView() {
        backgroundView = customView
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(titleLabel)
        setTitleLabelConstraint()
    }
    
    func setTitleLabelConstraint() {
        let constraints = [
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
