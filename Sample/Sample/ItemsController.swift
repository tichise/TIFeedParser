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

        if let pubDate = item.pubDate {
            cell.detailTextLabel?.text = self.getPubDateString(pubDate: pubDate)
        }

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
        
        Alamofire.request(feedUrlString).response { response in

            if let data = response.data, let _ = String(data: data, encoding: .utf8) {


                TIFeedParser.parseRSS(xmlData: data, onSuccess: { (channel) in
                    self.items = channel.items
                    self.tableView.reloadData()
                }, onNotFound: {
                }, onFailure: { (error) in
                })
            }
        }
    
    }
    
    func loadAtom() {
        
        let feedUrlString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=atom&num=3&hl=ja"
        
        Alamofire.request(feedUrlString).response { response in
            
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {

                TIFeedParser.parseAtom(xmlData: data, onSuccess: { (feed) in
                    self.entries = feed.entries
                    self.tableView.reloadData()
                }, onNotFound: {
                }, onFailure: { (error) in
                })
            }
        }
    }
    
    func getPubDateString(pubDate: Date) ->String {
        let format = DateFormatter()
        format.dateFormat = "yyyy/M/d HH:mm"
        
        let pubDateString = format.string(from: pubDate)
        return pubDateString
    }
}
