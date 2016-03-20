//
//  ItemsController.swift
//  Sample
//
//  Created by tichise on 2016年3月17日 16/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//


import UIKit
import SafariServices
import TIFeedParser

class ItemsController: UITableViewController {
    
    var items : Array<Item> = []
    var entries : Array<Entry> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRSS()
        loadAtom()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath)
        
        let item:Item = self.items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = self.pubDateStringFromDate(item.pubDate!)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = self.items[indexPath.row]
        
        let url:NSURL = NSURL(string: item.link!)!
        let safariViewController = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
        presentViewController(safariViewController, animated: true, completion: nil)
    }
    
    func loadRSS() {
        
        let feedString:String = "https://news.google.com/news?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss"
        
        TIFeedParser.parseRSS(feedString, completionHandler: {(result:Bool, channel:Channel, error:NSError?) -> Void in
            
            if (result) {
                if (channel.title != nil) {
                    self.items = channel.items!
                    self.tableView.reloadData()
                }
            } else {
                if (error != nil) {
                    print(error?.localizedDescription)
                }
            }
        })
    }
    
    func loadAtom() {
        
        let feedString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=atom&num=3&hl=ja"
        
        TIFeedParser.parseAtom(feedString, completionHandler: {(result:Bool, feed:Feed, error:NSError?) -> Void in
            
            if (result) {
                if (feed.title != nil) {
                    self.entries = feed.entries!
                    self.tableView.reloadData()
                }
            } else {
                if (error != nil) {
                    print(error?.localizedDescription)
                }
            }
        })
    }
    
    func pubDateStringFromDate(pubDate:NSDate)->String {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy/M/d HH:mm"
        
        let pubDateString = format.stringFromDate(pubDate)
        return pubDateString
    }
}
