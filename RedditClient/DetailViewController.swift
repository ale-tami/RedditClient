//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Alejandro Tami on 19/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.author
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: Feed? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

