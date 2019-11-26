//
//  ImagesService.swift
//  RedditClient
//
//  Created by Alejandro Tami on 26/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import Foundation
import UIKit

class ImagesService:ImagesLoader {
    
    public init() {

    }

    func loadImage(from stringURL:String, successHandler: @escaping (UIImage) -> Void, failureHandler:@escaping (Error)->Void) {
        let url = URL(string: stringURL)
        guard let _url = url else{
            failureHandler(.urlUngettable)
            return
        }
        URLSession.shared.dataTask(with: _url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    successHandler(image)
                } else if error != nil {
                    failureHandler(.serverError)
                }
                      
            }
        }.resume()
    }
}
