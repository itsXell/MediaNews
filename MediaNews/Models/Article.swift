//
//  Article.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import Foundation

struct Article {
    let title: String?
    let description: String
    let content: String
    let url: String
}

struct MainArticle {
    let articles: [Article]
}

