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
import Alamofire

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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item:Item = self.items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = self.pubDateStringFromDate(item.pubDate!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.items[indexPath.row]
        
        let url:URL = URL(string: item.link!)!
        let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func loadRSS() {
        
        let feedUrlString:String = "https://news.google.com/news?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss"
        
        
        Alamofire.request(.GET, feedUrlString, parameters:nil)
            .response {request, response, xmlData, error  in
                
                if (xmlData == nil) {
                    return
                }
                
                TIFeedParser.parseRSS(xmlData!, completionHandler: {(isSuccess, channel, error) -> Void in
                    
                    if (isSuccess) {
                        self.items = channel!.items!
                        self.tableView.reloadData()
                    }
                    
                    if (error != nil) {
                        print(error?.localizedDescription)
                    }
                })
        }
    }
    
    func loadAtom() {
        
        let feedUrlString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=atom&num=3&hl=ja"
        
        Alamofire.request(.GET, feedUrlString, parameters:nil)
            .response {request, response, xmlData, error  in
                
                if (xmlData == nil) {
                    return
                }
                
                TIFeedParser.parseAtom(xmlData!, completionHandler: {(isSuccess, feed, error) -> Void in
                    
                    if (isSuccess) {
                        self.entries = feed!.entries!
                        self.tableView.reloadData()
                    }
                    
                    if (error != nil) {
                        print(error?.localizedDescription)
                    }
                })
        }
    }
    
    func pubDateStringFromDate(_ pubDate:Date)->String {
        let format = DateFormatter()
        format.dateFormat = "yyyy/M/d HH:mm"
        
        let pubDateString = format.string(from: pubDate)
        return pubDateString
    }
}
