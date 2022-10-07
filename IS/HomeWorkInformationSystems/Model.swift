//
//  Model.swift
//  HomeWorkInformationSystems
//
//  Created by Владислав Лымарь on 04.10.2022.
//

import Foundation

// MARK: - NewsAPIResponce
struct NewsResponce: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

var tems = ["Apple", "Tesla", "News"]
let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7b45c70a94224fe59081465e7c5b6a9e"
let urlAppleString = "https://newsapi.org/v2/everything?q=apple&from=2022-10-05&to=2022-10-05&sortBy=popularity&apiKey=7b45c70a94224fe59081465e7c5b6a9e"
let urlTeslaString = "https://newsapi.org/v2/everything?q=tesla&from=2022-09-07&sortBy=publishedAt&apiKey=7b45c70a94224fe59081465e7c5b6a9e"
