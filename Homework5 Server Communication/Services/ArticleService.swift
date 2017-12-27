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
    
    //TODO: save Article
    func saveArticle(article: Article, image: Data) {
        let uploadImageUrl = "http://api-ams.me/v1/api/uploadfile/single"
        var article: Article = article
        
        Alamofire.upload(multipartFormData: { (multipart) in
            multipart.append(image, withName: "FILE", fileName: ".jpg", mimeType: "image/jpeg")
        }, to: uploadImageUrl, method: .post, headers: headers) { (encoding) in
            switch encoding {
                
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseJSON(completionHandler: { (response) in
                    if let data = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any] {
                        
                        let imageUrl = data["DATA"] as! String
                        article.image = imageUrl
                        
                        var parameters: Parameters = [
                            "TITLE": article.title!,
                            "DESCRIPTION": article.description!
                        ]
                        // -- check if image is not default to FROG image then add image
                        if image != UIImageJPEGRepresentation(#imageLiteral(resourceName: "frog"), 1) {
                            parameters = [
                                "TITLE": article.title!,
                                "DESCRIPTION": article.description!,
                                "IMAGE": article.image!
                            ]
                        }
                        if article.id == 0 {
                            // TODO: Save Article
                            Alamofire.request("\(self.articleUrl)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers).responseJSON { (response) in
                                    if response.result.isSuccess {
                                         print("=====> Saved!")
                                        // --- put rounded cycle network on the top near the clock
                                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                    }
                                }
                        }
                            // TODO: Update Article
                        else {
                            Alamofire.request("\(self.articleUrl)/\(article.id)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers).responseJSON { (response) in
                                if response.result.isSuccess {
                                    print("======> Updated!")
                                    // --- put rounded cycle network on the top near the clock
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                }
                            }
                        }
                    }
                })
                
            case .failure(let error):
                 print("Error: \(error.localizedDescription)")
            }
        }
    }
    
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
                    print("========> \(id)Deleted Successfully")
                }
            }
        }
    }
}
