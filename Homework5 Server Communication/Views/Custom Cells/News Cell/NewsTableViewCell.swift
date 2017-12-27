//
//  NewsTableViewCell.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/24/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberOfViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(article: Article) {
        titleLabel.text = article.title
        dateLabel.text = article.createdDate
        numberOfViewLabel.text = "4 views"
        articleImageView?.kf.setImage(with: URL(string: article.image!), placeholder: #imageLiteral(resourceName: "frog"))
    }
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
}
