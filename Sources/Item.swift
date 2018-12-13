//
//  Item.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation

public struct Item {
    
    public internal(set) var title: String?
    public internal(set) var link: String?
    public internal(set) var pubDate: Date?
    public internal(set) var description: String?
    public internal(set) var contentEncoded: String?
    public internal(set) var thumbnail: String?
    public internal(set) var categories: Array<String>?
    
    init(title:String, link:String, pubDate:NSDate, description:String?, contentEncoded:String?, thumbnail:String?, categories:Array<String>?){
        
        self.title = title
        self.link = link
        self.pubDate = pubDate
        self.description = description
        self.contentEncoded = contentEncoded
        self.thumbnail = thumbnail
        self.categories = categories
    }
}
