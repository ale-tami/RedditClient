//
//  ServiceContext.swift
//  RedditClient
//
//  Created by Alejandro Tami on 21/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import Foundation

class ServiceContext: NSObject {
    static let shared = ServiceContext()
    
    let baseUrl:String = "http://www.reddit.com/" //Usually put in the info.plist
}
