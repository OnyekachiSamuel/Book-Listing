//
//  Item.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import Foundation

struct Part: Decodable {
    let cover: CoverImage
}

struct CoverImage: Decodable {
    let url: String
    let height: Int
    let width: Int
}

struct Item: Decodable {
    let authors: [Author]
    let narrators: [Narrator]
    let parts: [Part]
    let title: String
}
