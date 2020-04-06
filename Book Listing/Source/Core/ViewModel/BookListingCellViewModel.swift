//
//  BookListingCellViewModel.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import UIKit

struct BookListingCellViewModel {
    private let item: Item
    let title: String
    
    init(_ item: Item) {
        self.item = item
        self.title = item.title
    }
    
    var authors: String {
        var names = "By: "
        let authorNames = item.authors.map { $0.name }.joined(separator: ", ")
        names.append(authorNames)
        return item.authors.isEmpty ? "": names
    }
    
    var narrators: String {
        var names = "With: "
        let narratorNames = item.narrators.map { $0.name }.joined(separator: ", ")
        names.append(narratorNames)
        return item.narrators.isEmpty ? "" : names
    }
    
    var url: URL? {
        let part = item.parts.first
        let urlString = part?.cover.url ?? ""
        return URL(string: urlString)
    }
}
