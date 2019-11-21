//
//  FeedsService.swift
//  RedditClient
//
//  Created by Alejandro Tami on 21/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//

import Foundation

class FeedsService {
    
    enum Page:String {
        case after = "after"
        case before = "before"
    }
    
    func getTopFeeds(with page:Page, successHandler: @escaping ([Feed]) -> Void, failureHandler:@escaping (String)->Void) {
        var url = URLComponents(string: ServiceContext.shared.baseUrl +
               "/top.json")

        url?.queryItems = [
            URLQueryItem(name: page.rawValue, value: ""),
            URLQueryItem(name: "limit", value: "50")
           ]
        guard let _url = url else{
            failureHandler("Could not get URL")
            return
        }
        
        URLSession.shared.dataTask(with: _url.url!) { (data, response, error) in
               if let data = data {
                   do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any], let subJson = json["data"] as? [String:Any], let sub = subJson["children"] else {
                           failureHandler("Could not get JSON")
                           return
                       }
                       let jsonData = try? JSONSerialization.data(withJSONObject: sub, options: .prettyPrinted)
                       let feeds = try JSONDecoder().decode([Feed].self, from: jsonData!)
                       DispatchQueue.main.async {
                           successHandler(feeds)
                       }
                   } catch {
                       failureHandler("Could not get JSON \(error)")
                   }
               } else if error != nil {
                   failureHandler(error?.localizedDescription ?? "")
               }
               
           }.resume()
       }
}
