//
//  Channel.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation

public struct Channel {
    
    public internal(set) var title:String?
    public internal(set) var link:String?
    public internal(set) var description:String?
    public internal(set) var items:Array<Item>?
    
    init() {}
    
    init(title:String, link:String, description:String, items:Array<Item>){
        
        self.title = title
        self.link = link
        self.description = description
        self.items = items
    }
}