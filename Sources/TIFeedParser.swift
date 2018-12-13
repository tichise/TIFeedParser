//
//  TIFeedParser.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation
import AEXML
import SwiftDate

public class TIFeedParser {
    
    public static func parseRSS(xmlData:Data, onSuccess: @escaping (Channel) -> (), onNotFound: @escaping () -> (), onFailure: @escaping (Error?) -> ()) {
        
        
        DispatchQueue.global(qos: .default).async {
            // サブスレッド(バックグラウンド)で実行する方を書く
            do {
                
                let xmlDoc = try AEXMLDocument(xml: xmlData)
                var existChannel = false
                
                for child in xmlDoc.root.children {
                    if (child.name == "channel") {
                        existChannel = true
                    }
                }
                
                
                if (existChannel) {
                    if (xmlDoc.root.children.count == 1) {
                        // rss2.0
                        let channel = parseRSS2(xmlDoc: xmlDoc)
                        
                        DispatchQueue.main.async {
                            onSuccess(channel)
                        }
                    } else {
                        // rss1.0
                        let channel = parseRSS1(xmlDoc: xmlDoc)
                        
                        DispatchQueue.main.async {
                            onSuccess(channel)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        onNotFound()
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    onFailure(error)
                }
            }
        }
    }
    
    public static func parseAtom(xmlData: Data, onSuccess: @escaping (Feed) -> (), onNotFound: @escaping () -> (), onFailure: @escaping (Error?) -> ()) {
        
        DispatchQueue.global(qos: .default).async {
            do {
                
                let xmlDoc = try AEXMLDocument(xml: xmlData)
                var existChannel = false
                
                for child in xmlDoc.root.children {
                    if (child.name == "channel") {
                        existChannel = true
                    }
                }
                
                if (existChannel) {
                    DispatchQueue.main.async {
                        onNotFound()
                    }
                } else {
                    // atom
                    let feed = parseAtom(xmlDoc: xmlDoc)
                    
                    DispatchQueue.main.async {
                        onSuccess(feed)
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    onFailure(error)
                }
            }
        }
    }
    
    private static func parseRSS1(xmlDoc: AEXMLDocument) -> Channel {
        var items:Array<Item> = []

        if let all = xmlDoc.root["item"].all {
            for itemObject in all {

                let title = itemObject["title"].value
                let link = itemObject["link"].value

                var dcDate: Date? = nil

                if let dcDateString = itemObject["dc:date"].value {
                    dcDate = dcDateString.toDate()?.date
                }

                let description = itemObject["description"].value
                let contentEncoded = itemObject["content:encoded"].value

                let item = Item(title: title, link: link, pubDate: dcDate, description: description, contentEncoded:contentEncoded, thumbnail:nil, categories:[])
                items.append(item)
            }
        }
        
        let title = xmlDoc.root["channel"]["title"].value
        let link = xmlDoc.root["channel"]["link"].value
        let description = xmlDoc.root["channel"]["description"].value
        
        let channel = Channel(title: title, link: link, description: description, items: items)
        
        return channel
    }
    
    private static func parseRSS2(xmlDoc:AEXMLDocument) -> Channel {
        var items:Array<Item> = Array()

        if let all = xmlDoc.root["channel"]["item"].all {
            for itemObject in all {

                let title = itemObject["title"].value
                let link = itemObject["link"].value

                var pubDate: Date? = nil

                if let pubDateString = itemObject["pubDate"].value {
                    pubDate = pubDateString.toDate()?.date
                }

                let description = itemObject["description"].value

                var categories:Array<String> = []

                if let all = itemObject["category"].all {
                    for category in all {
                        if let categoryTitle = category.value {
                            categories.append(categoryTitle)
                        }
                    }
                }

                var contentEncoded:String?

                if itemObject["contentEncoded"].value != nil {
                    contentEncoded = itemObject["content:encoded"].value
                }

                var thumbnail:String?

                if itemObject["media:thumbnail"].value != nil {

                    if (itemObject["media:thumbnail"].value != "element <media:thumbnail> not found") {
                        let mediaThumbnails:Array = itemObject["media:thumbnail"].all!

                        if (mediaThumbnails.count > 0) {
                            thumbnail = mediaThumbnails[1].attributes["url"]
                        }
                    }
                }

                let item = Item(title: title, link: link, pubDate: pubDate, description: description, contentEncoded: contentEncoded, thumbnail:thumbnail, categories:categories)

                items.append(item)
            }
        }
        
        let title = xmlDoc.root["channel"]["title"].value
        let link = xmlDoc.root["channel"]["link"].value
        let description = xmlDoc.root["channel"]["description"].value
        
        let channel = Channel(title: title, link: link, description: description, items: items)
        
        return channel
    }
    
    private static func parseAtom(xmlDoc:AEXMLDocument) -> Feed {
        var entries:Array<Entry> = Array()

        if let all = xmlDoc.root["entry"].all {
            for entryObject in all {

                let id = entryObject["id"].value
                let title = entryObject["title"].value
                let link = entryObject["link"].attributes["href"]

                var updated: Date? = nil

                if let updatedString = entryObject["updated"].value {
                    updated = updatedString.toDate()?.date
                }

                let summary = entryObject["summary"].value

                let entry = Entry(id: id, title: title, link: link, updated: updated, summary: summary)
                entries.append(entry)
            }
        }
        
        let id = xmlDoc.root["id"].value
        let title = xmlDoc.root["title"].value


        var updated: Date? = nil

        if let updatedString = xmlDoc.root["updated"].value {
            updated = updatedString.toDate()?.date
        }

        let feed = Feed(id: id, title: title, updated: updated, entries: entries)
        
        return feed
    }
}
