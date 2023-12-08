//
//  SearchDatas.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation

struct SearchDatas: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [SearchData]
}

// MARK: - Item
struct SearchData: Codable {
    let title: String
    let link: String
    let image: String
    let author, discount, publisher, pubdate: String
    let isbn, description: String
}
