//
//  TIFeedParser.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation
import AEXML

open class TIFeedParser {
    
    open static func parseRSS(_ xmlData:Data, completionHandler: @escaping (Bool, Channel?, Error?) -> Void) -> Void {
        
        DispatchQueue.global().async {
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
                        let channel = parseRSS2(xmlDoc)
                        
                        DispatchQueue.main.async {
                            completionHandler(true, channel, nil)
                        }
                    } else {
                        // rss1.0
                        let channel = parseRSS1(xmlDoc)
                        
                        DispatchQueue.main.async {
                            completionHandler(true, channel, nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(false, nil, nil)
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completionHandler(false, nil, error)
                }
            }
        }
    }
    
    open static func parseAtom(_ xmlData:Data, completionHandler: @escaping (Bool, Feed?, Error?) -> Void) -> Void {
        DispatchQueue.global().async {
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
                        completionHandler(false, nil, nil)
                    }
                } else {
                    // atom
                    let feed = parseAtom(xmlDoc)
                    
                    DispatchQueue.main.async {
                        completionHandler(true, feed, nil)
                    }
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    completionHandler(false, nil, error)
                }
            }
        }
    }
    
    fileprivate static func parseRSS1(_ xmlDoc:AEXMLDocument) -> Channel {
        var items:Array<Item> = Array()
        
        for itemObject in xmlDoc.root["item"].all! {
            
            let title:String = itemObject["title"].value!
            let link:String = itemObject["link"].value!
            
            let dcDateString = itemObject["dc:date"].value!
            let dcDate:Date = stringFromDate(dcDateString, format: "yyyy-MM-dd'T'HH:mm:sszzz")
            
            var description:String? = nil
            
            if itemObject["description"].value != nil {
                description = itemObject["description"].value
            }
            
            var contentEncoded:String? = nil
            
            if itemObject["content:encoded"].value != nil {
                contentEncoded = itemObject["content:encoded"].value!
            }
            
            let item:Item = Item(title: title, link: link, pubDate: dcDate, description: description, contentEncoded:contentEncoded, thumbnail:nil)
            items.append(item)
        }
        
        let title:String = xmlDoc.root["channel"]["title"].value!
        let link:String = xmlDoc.root["channel"]["link"].value!
        let description:String = xmlDoc.root["channel"]["description"].value!
        
        let channel:Channel = Channel(title: title, link: link, description: description, items: items)
        
        return channel
    }
    
    fileprivate static func parseRSS2(_ xmlDoc:AEXMLDocument) -> Channel {
        var items:Array<Item> = Array()
        
        for itemObject in xmlDoc.root["channel"]["item"].all! {
            
            let title:String = itemObject["title"].value!
            let link:String = itemObject["link"].value!
            let pubDateString:String = itemObject["pubDate"].value!
            let pubDate:Date = stringFromDate(pubDateString, format: "EEE, d MMM yyyy HH:mm:ss Z")
            
            var description:String? = nil
            
            if itemObject["description"].value != nil {
                description = itemObject["description"].value
            }
            
            var contentEncoded:String? = nil
            
            if itemObject["contentEncoded"].value != nil {
                contentEncoded = itemObject["content:encoded"].value!
            }
            
            var thumbnail:String? = nil
            
            if itemObject["media:thumbnail"].value != nil {
                
                if (itemObject["media:thumbnail"].value! != "element <media:thumbnail> not found") {
                    let mediaThumbnails:Array = itemObject["media:thumbnail"].all!
                    
                    if (mediaThumbnails.count > 0) {
                        thumbnail = mediaThumbnails[1].attributes["url"]! as String
                    }
                }
            }
            
            let item:Item = Item(title: title, link: link, pubDate: pubDate, description: description, contentEncoded: contentEncoded, thumbnail:thumbnail)
            items.append(item)
        }
        
        let title:String = xmlDoc.root["channel"]["title"].value!
        let link:String = xmlDoc.root["channel"]["link"].value!
        let description:String = xmlDoc.root["channel"]["description"].value!
        
        let channel:Channel = Channel(title: title, link: link, description: description, items: items)
        
        return channel
    }
    
    fileprivate static func parseAtom(_ xmlDoc:AEXMLDocument) -> Feed {
        var entries:Array<Entry> = Array()
        
        for entryObject in xmlDoc.root["entry"].all! {
            
            let id:String = entryObject["id"].value!
            let title:String = entryObject["title"].value!
            let link:String = entryObject["link"]["href"].value!
            
            let updatedString = entryObject["updated"].value!
            let updated:Date = stringFromDate(updatedString, format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
            
            let summary:String = entryObject["summary"].value!
            
            
            let entry:Entry = Entry(id:id, title: title, link: link, updated:updated, summary: summary)
            entries.append(entry)
        }
        
        let id:String = xmlDoc.root["id"].value!
        let title:String = xmlDoc.root["title"].value!
        let updatedString = xmlDoc.root["updated"].value!
        let updated:Date = stringFromDate(updatedString, format: "yyyy-MM-dd'T'HH:mm:sszzz")
        
        let feed:Feed = Feed(id:id, title: title, updated:updated, entries: entries)
        
        return feed
    }
    
    fileprivate static func stringFromDate(_ dateString:String, format:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        let date = dateFormatter.date(from: dateString)
        
        return date!
    }
}
