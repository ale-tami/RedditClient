//
//  FeedsLoader.swift
//  RedditClient
//
//  Created by Alejandro Tami on 21/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import Foundation

enum Page:String {
    case after = "after"
    case before = "before"
    case none = "null"
}
// abstraction to adheere to the single responsability princple and open/close principel, will allow to use any loader (local or other server) 
protocol FeedsLoader {
    
    static var lastPageName:String { get set }
    func load(with page:Page, successHandler: @escaping ([Feed]) -> Void, failureHandler:@escaping (String)->Void)
    
}
