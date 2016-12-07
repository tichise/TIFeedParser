//
//  Feed.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation

public struct Feed {

    public internal(set) var id:String?
    public internal(set) var title:String?
    public internal(set) var updated:Date?
    public internal(set) var entries:Array<Entry>?
    
    init() {}
    
    init(id:String, title:String, updated:Date, entries:Array<Entry>){

        self.id = id
        self.title = title
        self.updated = updated
        self.entries = entries
    }
}
