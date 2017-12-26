//
//  ArticleService.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/25/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import Foundation
import Alamofire

class ArticleService {
    
    let articleUrl = "http://api-ams.me/v1/api/articles"
    
    var delegate: ArticleServiceProtocol?
    
    var headers = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="
    ]
    
    // TODO: get Article
    func getArtcles(page: Int, limit: Int) {
        var articles = [Article]()
        Alamofire.request("\(articleUrl)?page=\(page)&limit=\(limit)", method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String:Any] {
                    let objects = json["DATA"] as! NSArray
                    for object in objects {
                        articles.append(Article(JSON: object as! [String:Any])!)
                    }
                    self.delegate?.responseArticle(articles)
                }
            }
        }
    
    }
    
    // TODO: Delete Article
    func deleteArticle(id: Int) {
        Alamofire.request("\(articleUrl)/\(id)", method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let error = response.result.error {
                if error == nil {
                    print(error)
                }
                else {
                    print("Deleted Successfully")
                }
            }
        }
    }
}
