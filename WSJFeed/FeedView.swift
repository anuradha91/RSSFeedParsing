//
//  FeedView.swift
//  WSJFeed
//
//  Created by Anuradha Sharma on 1/14/19.
//  Copyright © 2019 Anuradha Sharma. All rights reserved.
//

import UIKit

class FeedView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Properties
    private var rssItems: [RSSItem]?
    var currentIndex = IndexPath()
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchData()
    {
        tableView.isHidden = true
        Spinner.start(from: self.view)
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "http://www.wsj.com/xml/rss/3_7085.xml") { [weak self] (rssItems) in
            self?.rssItems = rssItems
            
            OperationQueue.main.addOperation { [weak self] in
                Spinner.stop()
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rssItems?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        if let item = rssItems?[indexPath.item] {
            cell.item = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let destVC = segue.destination as! FeedDetailView
        destVC.currentFeed = rssItems?[currentIndex.row]
    }
}
