//
//  SaveArticleViewController.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/27/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit
import Photos
import Kingfisher
import Alamofire

class SaveArticleViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    var articlePresenter = ArticlePresenter()
    
    
    var isUpdate = false
    var article = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.articleImageView.isUserInteractionEnabled = true
        
        if isUpdate {
            titleTextField.text = article.title
            articleImageView.kf.setImage(with: URL(string: article.image!), placeholder: #imageLiteral(resourceName: "frog"))
            contentTextField.text = article.description
            saveButton.setTitle("Update", for: .normal)
        }
        
    }
    
    
    @IBAction func saveArticleButton(_ sender: Any) {
    
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let image = UIImageJPEGRepresentation(self.articleImageView.image!, 1)
        if isUpdate {
            self.article.title = self.titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            self.article.description = self.contentTextField.text.trimmingCharacters(in: .whitespacesAndNewlines)
            self.articlePresenter.saveArticle(article: article, image: image!)
        }
        else {
            article.id = 0
            self.article.title = self.titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            self.article.description = self.contentTextField.text.trimmingCharacters(in: .whitespacesAndNewlines)
            self.articlePresenter.saveArticle(article: article, image: image!)
        }
        
    }
    
}

extension SaveArticleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBAction func browseImage(_ sender: UITapGestureRecognizer){

        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        DispatchQueue.main.async {
            self.articleImageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}


