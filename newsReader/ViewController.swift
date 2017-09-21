//
//  ViewController.swift
//  newsReader
//
//  Created by Ahmad Ahrbi on 12/27/1438 AH.
//  Copyright © 1438 Ahmad Ahrbi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var navBarlabel: UINavigationItem!
    
    //Refresh
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    
    
    
    var articales: [Article]? = []
    var news: News?
    var newTags: [Tag]? = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // update cell height to support iOS 8
        tabelView.rowHeight = UITableViewAutomaticDimension
        tabelView.estimatedRowHeight = tabelView.rowHeight
        
        fetchArticals()
        
        if #available(iOS 10.0, *) {
            tabelView.refreshControl = refreshControl
        } else {
            tabelView.addSubview(refreshControl)
        }
        
        refreshControl.tintColor = UIColor.black
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Data... ")
        refreshControl.addTarget(self, action: #selector(ViewController.refreshData), for: UIControlEvents.valueChanged)
        
    }
    
    
    @objc func refreshData() {
        fetchArticals()
        tabelView.reloadData()
        refreshControl.endRefreshing()
    }
    

    
    func fetchArticals(){
    
        let urlRequest = URLRequest(url: URL(string: "https://no89n3nc7b.execute-api.ap-southeast-1.amazonaws.com/staging/exercise")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }else {
                
                self.articales = [Article]()
                self.news = News()
                self.newTags = [Tag]()
                
                
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                    
                    
                    if let titleFromJson = json["title"] as? String {
                        let news = News()
                        //print(titleFromJson)
                        news.title = titleFromJson
                        OperationQueue.main.addOperation {
                            self.navBarlabel.title = titleFromJson
                            self.tabelView.reloadData()
                        }
                        
                        
                    }
          
                   
                    
                if  let articalFromJson = json["articles"] as? [[String: Any]] {
                    for articalFromJson in articalFromJson {
                        let article = Article()
                        if let title = articalFromJson["title"] as? String,
                            let author = articalFromJson["authors"] as? String,
                            let content = articalFromJson["content"] as? String,
                            let website = articalFromJson["website"] as? String,
                            let date = articalFromJson["date"] as? String,
                            let urlImage = articalFromJson["image_url"] as? String {
                                
                            article.title = title
                            article.content = content
                            article.author = author
                            article.date = date
                            article.imageUrl = urlImage
                            article.website = website
                            if let tagsFromJson = articalFromJson["tags"] as? [[String: Any]] {
                                for tagFromJson in tagsFromJson {
                                    let tag: Tag = Tag()
                                    if let typeArt = tagFromJson["label"]as? String,
                                        let id = tagFromJson["id"] as? Int {
                                        tag.id = id
                                        tag.label = typeArt
                                        self.newTags?.append(tag)
                                        
        
                                    }
                                   
                                    
                                    
                                }
                                
                                
                               
                                
                                
                                
                            }
                            
                            
                                
                                
                                
                                
                                }
                            self.articales?.append(article)
                        
                            }
                        }
                    DispatchQueue.main.async {
                        self.tabelView.reloadData()

                    }
                    
                }catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tabelView.dequeueReusableCell(withIdentifier: "articalCell", for: indexPath) as! ArticalCell
        
        
        
        cell.articaltype.text = self.newTags?[indexPath.item].label
        cell.title.text = self.articales?[indexPath.item].title
        cell.content.text = self.articales?[indexPath.item].content
        cell.date.text = self.articales?[indexPath.item].date
        cell.authoer.text = "By: \(self.articales?[indexPath.item].author! ?? "")"
        cell.website.text = "🌐: \(self.articales?[indexPath.item].website! ?? "")"
       cell.imgView.downloadImage(from: (self.articales?[indexPath.item].imageUrl)!)
  
        
        
        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articales?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        //1.set the initial state of cell
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        //2. UIView animation method to change to the final state of the cell
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
        
        
        
        
    }
    

    

}



extension UIImageView {

    func downloadImage(from url:String){
        if let imgURL = URL(string: url) {
        let urlRequest = URLRequest(url: imgURL)

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
            }
        }
            task.resume()
        }
        
    }

}












