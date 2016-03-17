//
//  Channel.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation

class Channel {
    
    var title:String?
    var link:String?
    var description:String?
    var items:Array<Item>?
    
    init() {}
    
    init(title:String, link:String, description:String, items:Array<Item>){
        
        self.title = title
        self.link = link
        self.description = description
        self.items = items
    }
}