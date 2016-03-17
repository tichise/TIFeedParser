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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFeeds()
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
    
    func loadFeeds() {
        
        let feedString:String = "https://news.google.com/news?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss"
        
        TIFeedParser.parse(feedString, completionHandler: {(result:Bool, channel:Channel) -> Void in
            
            if (result) {
                if (channel.title != nil) {
                    self.items = channel.items!
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func pubDateStringFromDate(pubDate:NSDate)->String {
        let format = NSDateFormatter()
        format.dateFormat = "yyyyM月d日 HH:mm"
        
        let pubDateString = format.stringFromDate(pubDate)
        return pubDateString
    }
}
