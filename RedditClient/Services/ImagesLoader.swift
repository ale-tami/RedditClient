//
//  ImagesLoader.swift
//  RedditClient
//
//  Created by Alejandro Tami on 26/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import Foundation
import UIKit

protocol ImagesLoader {
    func loadImage(from stringURL:String, successHandler: @escaping (UIImage) -> Void, failureHandler:@escaping (Error)->Void)
}
