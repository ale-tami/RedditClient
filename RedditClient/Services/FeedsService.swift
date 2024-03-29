//
//  FeedsService.swift
//  RedditClient
//
//  Created by Alejandro Tami on 21/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import Foundation

public class FeedsService:FeedsLoader {   
    
    public static var lastPageName: String = "null"
    
    public init() {
        
    }
        
    public func load(with page:Page, successHandler: @escaping ([Feed]) -> Void, failureHandler:@escaping (Error)->Void) {
        var url = URLComponents(string: ServiceContext.shared.baseUrl +
               "/top.json")

        url?.queryItems = [
            URLQueryItem(name: page.rawValue, value: FeedsService.lastPageName),
            URLQueryItem(name: "limit", value: "50")
           ]
        guard let _url = url else{
            failureHandler(.urlUngettable)
            return
        }
        URLSession.shared.dataTask(with: _url.url!) { (data, response, error) in
            DispatchQueue.main.async {

               if let data = data {
                   do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any], let subJson = json["data"] as? [String:Any], let sub = subJson["children"] else {
                        failureHandler(.parsingJson)
                           return
                       }

                        let jsonData = try? JSONSerialization.data(withJSONObject: sub, options: .prettyPrinted)
                        let feeds = try JSONDecoder().decode([Feed].self, from: jsonData!)
                        successHandler(feeds)
                       
                   } catch {
                    failureHandler(.parsingJson)
                   }
               } else if error != nil {
                    failureHandler(.serverError)
               }
                
            }
           }.resume()
       }
}
