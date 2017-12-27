//
//  ViewController.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/24/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class HomeViewController: UIViewController{

    @IBOutlet weak var menuLeadingConstrain: NSLayoutConstraint!
    @IBOutlet var homeView: UIView!
    @IBOutlet weak var articleTableView: UITableView!
    
    let paginationIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var pageInceasing = 1
    
    var articlePresenter: ArticlePresenter?
    var articles: [Article]?
    
    var isLeftMenuButtonPressed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLeadingConstrain.constant = -250
        articles = [Article]()
        self.articlePresenter = ArticlePresenter()
        self.articlePresenter?.delegate = self
        
        articleTableView.preservesSuperviewLayoutMargins = false
        articleTableView.separatorInset = UIEdgeInsets.zero
        articleTableView.layoutMargins = UIEdgeInsets.zero
        // --- add scroll to refresh ---
        articleTableView.addSubview(pullToRefreshControl)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        articles?.removeAll()
        pageInceasing = 1
        self.articlePresenter?.getArticle(page: 1, limit: 15)
    }
    
    var pullToRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .red
        return refreshControl
    }()
    
    @objc func handlePullToRefresh(_ refreshControl: UIRefreshControl) {
        articles?.removeAll()
        articlePresenter?.getArticle(page: 1, limit: 15)
        articleTableView.reloadData()
        refreshControl.endRefreshing()
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

//TODO: with Presenter
extension HomeViewController: ArticlePresenterProtocol {
    
    func responseArticle(articles: [Article]) {
        self.articles = articles
        self.articleTableView.reloadData()
    }
}

//TODO: with table
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = Bundle.main.loadNibNamed("ImageTableViewCell", owner: self, options: nil)?.first as! ImageTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.configureCell(article: articles![0])
            return cell
        } else if indexPath.row == 1 {
            let cell = Bundle.main.loadNibNamed("TitleTableViewCell", owner: self, options: nil)?.first as! TitleTableViewCell
            cell.configureCell(article: articles![0])
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("NewsTableViewCell", owner: self, options: nil)?.first as!NewsTableViewCell
            cell.configureCell(article: articles![indexPath.row - 1])
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.row != 1 {
            let detailStoryboard = self.storyboard?.instantiateViewController(withIdentifier: "detailStoryboardID") as! DetailViewController
            detailStoryboard.image = articles![indexPath.row - 1].image
            detailStoryboard.titleArticle = articles![indexPath.row - 1].title
            detailStoryboard.descriptionArticle = articles![indexPath.row - 1].description
            self.navigationController?.pushViewController(detailStoryboard, animated: true)
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
        if distanceFromBottom < height {
            pageInceasing += 1
            self.articleTableView.tableFooterView = paginationIndicatorView
            self.articleTableView.tableFooterView?.isHidden = false
            self.articleTableView.tableFooterView?.center = paginationIndicatorView.center
            self.paginationIndicatorView.startAnimating()
            articlePresenter?.getArticle(page: pageInceasing, limit: 15)
            articleTableView.reloadData()
        }
    }
    // --- swap left to EDIT and DELETE ---
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.row != 0  && indexPath.row != 1{
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
                let alert = UIAlertController(title: "Are you sure to delete?", message: nil, preferredStyle: .alert)
                // Add YES option and handle
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
                    DispatchQueue.main.async {
                        self.articlePresenter?.deleteAricle(id: self.articles![indexPath.row - 1].id!)
                        self.articles?.remove(at: indexPath.row - 1)
                        self.articleTableView.reloadData()
                    }
                }))
                // Add Cancel option and handle = nil
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, index) in
                // handle edit here
                print(self.articles![indexPath.row - 1])
                let saveStoryboard = self.storyboard?.instantiateViewController(withIdentifier: "saveStoryboardID") as! SaveArticleViewController
                saveStoryboard.isUpdate = true
                saveStoryboard.article = self.articles![indexPath.row - 1]
                self.navigationController?.pushViewController(saveStoryboard, animated: true)
            }
            return [delete, edit]
        }
        return []
    }
}

