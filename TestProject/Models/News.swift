//
//  News.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

// MARK: - Fixed: stuct should confirm to protocol of "decodeble".
struct News: Decodable {
    let authors: String?
    let title: String?
    let urlToImage: String?
}
