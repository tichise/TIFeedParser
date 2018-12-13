//
//  Entry.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation

public struct Entry {

    public internal(set) var id:String?
    public internal(set) var title:String?
    public internal(set) var link:String?
    public internal(set) var updated:Date?
    public internal(set) var summary:String?
    
    init(id: String?, title: String?, link: String?, updated: Date?, summary: String?){

        self.id = id
        self.title = title
        self.link = link
        self.updated = updated
        self.summary = summary
    }
}
