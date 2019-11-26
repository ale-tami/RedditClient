//
//  RedditClientTests.swift
//  RedditClientTests
//
//  Created by Alejandro Tami on 25/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import XCTest
import RedditClient
import Foundation

class RedditClientTests: XCTestCase {

    func test_backend_connectivity() {
        let service = FeedsLoaderTester()
        var remoteError :[Error]? = []
        service.load(with: .none, successHandler: { (feeds) in
            
        }) { (error) in
            remoteError?.append(error)
            XCTAssertEqual(remoteError, [Error.connetivity])
        }
    }

}

class FeedsLoaderTester:FeedsLoader {
    static var lastPageName: String = "null"
    
    func load(with page: Page, successHandler: @escaping ([Feed]) -> Void, failureHandler: @escaping (Error) -> Void) {
        failureHandler(Error.connetivity)
    }
    
    
}
