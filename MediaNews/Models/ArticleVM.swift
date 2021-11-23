//
//  ArticleVM.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleVM {
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var title: Observable<String>{
        return Observable.just(article.title ?? "")
    }
    
    var description: Observable<String>{
        return Observable.just(article.description ?? "" )
    }
    
    var content: Observable<String>{
        return Observable.just(article.content ?? "")
    }
    
    var url: Observable<String>{
        return Observable.just(article.url ?? "")
    }
    
    var image: Observable<String>{
        return Observable.just(article.image ?? "")
    }
    
    var publishAt: Observable<String>{
        return Observable.just(article.publishAt ?? "")
    }
    
}
