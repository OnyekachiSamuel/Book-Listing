//
//  BookListingCellViewModel.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import UIKit

class BookListingCellViewModel {
    private let item: Item
    let title: String
    
    var authors: String {
        var names = "By: "
        let authorNames = item.authors.map { $0.name }.joined(separator: ", ")
        names.append(authorNames)
        return names
    }
    
    var narrators: String {
        var names = "By: "
        let narratorNames = item.narrators.map { $0.name }.joined(separator: ", ")
        names.append(narratorNames)
        return names
    }
    
    init(_ item: Item) {
        self.item = item
        self.title = item.title
    }
    
    func fetchImage(_ completion: @escaping (UIImage) -> Void) {
        let part = item.parts.first
        guard let urlString = part?.cover.url,
            let imageURL = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
        
    }
}
