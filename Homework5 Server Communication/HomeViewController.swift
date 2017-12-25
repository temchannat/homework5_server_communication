//
//  ViewController.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/24/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var menuLeadingConstrain: NSLayoutConstraint!
    @IBOutlet var homeView: UIView!
    
    
    var isLeftMenuButtonPressed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuLeadingConstrain.constant = -250
    }


    @IBAction func leftMenuBarButton(_ sender: Any) {
        
        if isLeftMenuButtonPressed {
            menuLeadingConstrain.constant = 0
            // set animation
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.homeView.backgroundColor = .black
                
            })
           
        
        }
        else {
            menuLeadingConstrain.constant = -250
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                self.homeView.backgroundColor = .white
                
            })
        }
        isLeftMenuButtonPressed = !isLeftMenuButtonPressed
        
    }
    
}

// interface
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = Bundle.main.loadNibNamed("ImageTableViewCell", owner: self, options: nil)?.first as! ImageTableViewCell
          
            return cell
        } else if indexPath.row == 1 {
            let cell = Bundle.main.loadNibNamed("TitleTableViewCell", owner: self, options: nil)?.first as! TitleTableViewCell
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("NewsTableViewCell", owner: self, options: nil)?.first as! NewsTableViewCell
            return cell
        }
    }
    
}

