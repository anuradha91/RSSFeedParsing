//
//  FeedCell.swift
//  WSJFeed
//
//  Created by Anuradha Sharma on 1/14/19.
//  Copyright © 2019 Anuradha Sharma. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    var item: RSSItem! {
        didSet {
            lblTitle.text = item.title
            lblDetail.text = item.description
        }
    }
}
