//
//  TIFeedParser.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation
import Alamofire
import AEXML

public class TIFeedParser {
    
    public static func parseRSS(urlString:String, completionHandler: (Bool, Channel, NSError?) -> Void) -> Void {
        
        Alamofire.request(.GET, urlString, parameters:nil)
            .response { request, response, xmlData, error  in
                
                if (error != nil) {
                    completionHandler(false, Channel(), error!)
                    return
                }
                
                if xmlData != nil {
                    do {
                        let xmlDoc = try AEXMLDocument(xmlData: xmlData!)
                        
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
                                completionHandler(true, channel, nil)
                            } else {
                                // rss1.0
                                let channel = parseRSS1(xmlDoc)
                                completionHandler(true, channel, nil)
                            }
                        } else {
                            // atomの場合はエラーを出す
                            completionHandler(false, Channel(), error)
                        }
                    }
                    catch let error as NSError {
                        completionHandler(false, Channel(), error)
                    }
                } else {
                    completionHandler(false, Channel(), nil)
                }
        }
    }
    
    public static func parseAtom(urlString:String, completionHandler: (Bool, Feed, NSError?) -> Void) -> Void {
        
        Alamofire.request(.GET, urlString, parameters:nil)
            .response { request, response, xmlData, error  in
                
                if (error != nil) {
                    completionHandler(false, Feed(), error!)
                    return
                }
                
                if xmlData != nil {
                    do {
                        let xmlDoc = try AEXMLDocument(xmlData: xmlData!)
                        
                        var existChannel = false
                        
                        for child in xmlDoc.root.children {
                            if (child.name == "channel") {
                                existChannel = true
                            }
                        }
                        
                        if (existChannel) {
                            // RSSの場合はエラーを出す
                            completionHandler(false, Feed(), nil)
                        } else {
                            // atom
                            completionHandler(true, Feed(), error)
                        }
                    }
                    catch let error as NSError {
                        completionHandler(false, Feed(), error)
                    }
                } else {
                    completionHandler(false, Feed(), nil)
                }
        }
    }
    
    private static func parseRSS1(xmlDoc:AEXMLDocument) -> Channel {
        var items:Array<Item> = Array()
        
        for item in xmlDoc.root["item"].all! {
            
            let title:String = item["title"].value!
            let link:String = item["link"].value!
            
            let dcDateString = item["dc:date"].value!
            let dcDate:NSDate = stringFromDate(dcDateString, format: "yyyy-MM-dd'T'HH:mm:sszzz")
            
            let description:String = item["description"].value!
            
            let thumbnail:String = ""
            
            let item:Item = Item(title: title, link: link, pubDate: dcDate, description: description, thumbnail:thumbnail)
            items.append(item)
        }
        
        let title:String = xmlDoc.root["channel"]["title"].value!
        let link:String = xmlDoc.root["channel"]["link"].value!
        let description:String = xmlDoc.root["channel"]["description"].value!
        
        let channel:Channel = Channel(title: title, link: link, description: description, items: items)
        
        return channel
    }
    
    private static func parseRSS2(xmlDoc:AEXMLDocument) -> Channel {
        var items:Array<Item> = Array()
        
        for item in xmlDoc.root["channel"]["item"].all! {
            
            let title:String = item["title"].value!
            let link:String = item["link"].value!
            let pubDateString:String = item["pubDate"].value!
            let pubDate:NSDate = stringFromDate(pubDateString, format: "EEE, d MMM yyyy HH:mm:ss Z")
            
            let description:String = item["description"].value!
            
            var thumbnail:String = ""
            
            if item["media:thumbnail"].value != nil {
                
                if (item["media:thumbnail"].value! != "element <media:thumbnail> not found") {
                    let mediaThumbnails:Array = item["media:thumbnail"].all!
                    
                    if (mediaThumbnails.count > 0) {
                        thumbnail = mediaThumbnails[1].attributes["url"]! as String
                    }
                }
            }
            
            let item:Item = Item(title: title, link: link, pubDate: pubDate, description: description, thumbnail:thumbnail)
            items.append(item)
        }
        
        let title:String = xmlDoc.root["channel"]["title"].value!
        let link:String = xmlDoc.root["channel"]["link"].value!
        let description:String = xmlDoc.root["channel"]["description"].value!
        
        let channel:Channel = Channel(title: title, link: link, description: description, items: items)
        
        return channel
    }
    
    private static func parseAtom(xmlDoc:AEXMLDocument) -> Feed {
        var entries:Array<Entry> = Array()
        
        for entry in xmlDoc.root["entry"].all! {

            let id:String = entry["id"].value!
            let title:String = entry["title"].value!
            let link:String = entry["link"].value!
            
            let updatedString = entry["updated"].value!
            let updated:NSDate = stringFromDate(updatedString, format: "yyyy-MM-dd'T'HH:mm:sszzz")
            
            let summary:String = entry["summary"].value!
            
            
            let entry:Entry = Entry(id:id, title: title, link: link, updated:updated, summary: summary)
            entries.append(entry)
        }

        let id:String = xmlDoc.root["feed"]["id"].value!
        let title:String = xmlDoc.root["feed"]["title"].value!
        let updatedString = xmlDoc.root["feed"]["updated"].value!
        let updated:NSDate = stringFromDate(updatedString, format: "yyyy-MM-dd'T'HH:mm:sszzz")
        
        let feed:Feed = Feed(id:id, title: title, updated:updated, entries: entries)
        
        return feed
    }
    
    private static func stringFromDate(dateString:String, format:String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.dateFromString(dateString)
        
        return date!
    }
}