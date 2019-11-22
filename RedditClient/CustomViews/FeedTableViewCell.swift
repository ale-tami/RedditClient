//
//  FeedTableViewCell.swift
//  RedditClient
//
//  Created by Alejandro Tami on 20/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
@IBOutlet weak var readIndicator: UIView!
@IBOutlet weak var thumbnailImageView: UIImageView!
@IBOutlet weak var titleLable: UILabel!
@IBOutlet weak var authorLabel: UILabel!
@IBOutlet weak var dateLabel: UILabel!
@IBOutlet weak var commentsCountLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.readIndicator.layer.cornerRadius = self.readIndicator.frame.size.height / 2
    }
    
    func configureWithFeed(feed:Feed) {
        self.titleLable.text = feed.title;
        self.authorLabel.text = feed.author;
        self.dateLabel.text = "\(feed.created)"
        self.commentsCountLabel.text = "\(feed.commentsCount) comments"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
