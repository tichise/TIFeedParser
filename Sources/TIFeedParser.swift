//
//  TIFeedParser.swift
//
//  Created by tichise on 2016/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import Foundation
import Alamofire
import AEXML

class TIFeedParser {
    
    public func parse(urlString:String, completionHandler: (Bool, Channel) -> Void) -> Void {

        Alamofire.request(.GET, urlString, parameters:nil)
            .response { request, response, xmlData, error  in
                
            if (error != nil) {
                print(error?.debugDescription)
            }
            
            if xmlData != nil {
                do {
                    let xmlDoc = try AEXMLDocument(xmlData: xmlData!)
                    var items:Array<Item> = Array()
                    
                    for item in xmlDoc.root["channel"]["item"].all! {
                        
                        let title:String = item["title"].value!
                        let link:String = item["link"].value!
                        let pubDateString:String = item["pubDate"].value!
                        let pubDate:NSDate = self.stringFromDate(pubDateString)
                        
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
                    completionHandler(true, channel)
                    
                    return
                }
                catch {
                    print("\(error)")
                }
            }
        }
        
        completionHandler(false, Channel())
    }
    
    private func stringFromDate(dateString:String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "US")
        dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.dateFromString(dateString)
        
        return date!
    }
}