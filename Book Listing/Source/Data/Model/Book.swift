//
//  Book.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 01/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import Foundation

struct Book: Decodable {
    let items: [Item]
}
