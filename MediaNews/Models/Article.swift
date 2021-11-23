//
//  Article.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import Foundation

struct Article:Decodable {
    let title: String?
    let description: String?
    let content: String?
    let url: String?
    let image: String?
    let publishAt: String?
}

struct MainArticle:Decodable {
    let articles: [Article]
}

