//
//  Item.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation

public struct Item {
    
    var title:String?
    var link:String?
    var pubDate:NSDate?
    var description:String?
    var thumbnail:String?
    
    init(title:String, link:String, pubDate:NSDate, description:String, thumbnail:String){
        
        self.title = title
        self.link = link
        self.pubDate = pubDate
        self.description = description
        self.thumbnail = thumbnail
        
    }
}
