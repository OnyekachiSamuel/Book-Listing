//
//  BookListingCell.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 02/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import UIKit

class BookListingCell: UITableViewCell {
    static let reuseIndentifier = String(describing: self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: BookListingCellViewModel? {
        didSet { bindViewModel() }
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let url = viewModel.url
        coverImage.loadImage(from: url)
        titleLabel.text = viewModel.title
        authorNameLabel.text = viewModel.authors
        narratorNameLabel.text = viewModel.narrators
    }
    
    let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let narratorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
}

private extension BookListingCell {
    func setupViews() {
        contentView.addSubview(coverImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(narratorNameLabel)
        setCoverImageConstraint()
        setTitleLabelConstraint()
        setAuthorNameLabelConstraint()
        setNarratorNameLabelConstraint()
    }

    func setCoverImageConstraint() {
        let constraints = [
            coverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            coverImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 84),
            coverImage.widthAnchor.constraint(equalTo: coverImage.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setTitleLabelConstraint() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setAuthorNameLabelConstraint() {
        let constraints = [
            authorNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setNarratorNameLabelConstraint() {
        let constraints = [
            narratorNameLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 8),
            narratorNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            narratorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
