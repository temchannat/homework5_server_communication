//
//  ImageTableViewCell.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/25/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var homeImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(article: Article) {
        homeImageView?.kf.setImage(with: URL(string: article.image!), placeholder: #imageLiteral(resourceName: "frog"))
    }
    
}
