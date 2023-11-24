//
//  Article.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

struct Article: Decodable {
    // MARK: - Fixed: There shoud be an array property. 
    let articles: [News]
}

