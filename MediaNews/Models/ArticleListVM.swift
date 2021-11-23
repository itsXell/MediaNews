//
//  ArticleListVM.swift
//  MediaNews
//
//  Created by Xell on 23/11/2564 BE.
//

import Foundation
import RxCocoa
import RxSwift

struct ArticleListVM {
    let articleListVM: [ArticleVM]
    
    init(articlesList: [Article]) {
        self.articleListVM = articlesList.compactMap(ArticleVM.init)
    }
    
    func indexAt(index: Int) -> ArticleVM {
        return self.articleListVM[index]
    }
}
