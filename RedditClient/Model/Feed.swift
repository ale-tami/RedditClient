//
//  Feed+CoreDataClass.swift
//  RedditClient
//
//  Created by Alejandro Tami on 20/11/2019.
//  Copyright © 2019 Alejandro Tami. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Feed)
public class Feed: NSManagedObject, Codable {

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var created: Int
    @NSManaged public var imageURL: String?
    @NSManaged public var commentsCount: Int
    @NSManaged public var isRead: Bool
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case author = "author"
        case imageURL = "thumbnail"
        case title = "title"
        case created = "created"
        case commentsCount = "num_comments"
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy:
        CodingKeys.self)
  
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("----Failed to decode FEED")
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Feed", in: context) else {
            fatalError("----Failed to decode FEED")
        }
        self.init(entity: entity, insertInto: context)
        
        let keysContainer = try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
      
        self.title = try keysContainer.decodeIfPresent(String.self, forKey: .title)
        self.imageURL = try keysContainer.decodeIfPresent(String.self, forKey: .imageURL)
        self.author = try keysContainer.decodeIfPresent(String.self, forKey: .author)
        self.commentsCount = try keysContainer.decode(Int.self, forKey: .commentsCount)
        self.created = try keysContainer.decode(Int.self, forKey: .created)

    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:
            CodingKeys.self)
        var keysContainer = container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        try keysContainer.encodeIfPresent(self.title, forKey: .title)
        try keysContainer.encodeIfPresent(self.imageURL, forKey: .imageURL)
        try keysContainer.encodeIfPresent(self.author, forKey: .author)
        try keysContainer.encode(self.commentsCount, forKey: .commentsCount)
        try keysContainer.encode(self.created, forKey: .created)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feed> {
        return NSFetchRequest<Feed>(entityName: "Feed")
    }

    
}
