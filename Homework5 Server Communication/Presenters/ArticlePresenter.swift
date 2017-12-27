//
//  ArticlePresenter.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/25/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import Foundation

class ArticlePresenter: ArticleServiceProtocol{
    
    var delegate: ArticlePresenterProtocol?
    var articleService: ArticleService?
    
    init() {
        self.articleService = ArticleService()
        self.articleService?.delegate = self
    }
    
    func getArticle(page: Int, limit: Int) {
        self.articleService?.getArtcles(page: page, limit: limit)
    }
    
    func saveArticle(article: Article, image: Data) {
        self.articleService?.saveArticle(article: article, image: image)
    }
    
    func deleteAricle(id: Int) {
        self.articleService?.deleteArticle(id: id)
    }
    
    func responseArticle(_ articles: [Article]) {
        self.delegate?.responseArticle(articles: articles)
    }
}

