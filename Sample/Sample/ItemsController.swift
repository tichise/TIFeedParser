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
        
        let item = self.items[indexPath.row]
        cell.textLabel?.text = item.title

        if let pubDate = item.pubDate {
            cell.detailTextLabel?.text = self.getPubDateString(pubDate: pubDate)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.items[indexPath.row]

        guard let link =  item.link else {
            return
        }

        guard let url = URL(string: link) else {
            return
        }

        let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func loadRSS() {
        
        let feedUrlString = "https://news.google.com/_/rss/topics/CAAqKAgKIiJDQkFTRXdvSkwyMHZNR1ptZHpWbUVnSnFZUm9DU2xBb0FBUAE?hl=ja&gl=JP&ceid=JP:ja"

        AF.request(feedUrlString).responseData { (response) in
            if 200 != response.response?.statusCode {
                return
            }

            guard let data = response.data else {
                return
            }

            TIFeedParser.parseRSS(xmlData: data, onSuccess: { (channel) in
                self.items = channel.items
                self.tableView.reloadData()
            }, onNotFound: {
                print("onNotFound")
            }, onFailure: { (error) in
            })
        }
    }
    
    func loadAtom() {
        
        let feedUrlString = "https://news.google.com/_/atom/topics/CAAqKAgKIiJDQkFTRXdvSkwyMHZNR1ptZHpWbUVnSnFZUm9DU2xBb0FBUAE?hl=ja&gl=JP&ceid=JP:ja"
        

        AF.request(feedUrlString).responseData { (response) in
            if 200 != response.response?.statusCode {
                return
            }

            guard let data = response.data else {
                return
            }

            TIFeedParser.parseRSS(xmlData: data, onSuccess: { (channel) in
                self.items = channel.items
                self.tableView.reloadData()
            }, onNotFound: {
                print("onNotFound")
            }, onFailure: { (error) in
            })

        }
    }
    
    func getPubDateString(pubDate: Date) ->String {
        let format = DateFormatter()
        format.dateFormat = "yyyy/M/d HH:mm"
        
        let pubDateString = format.string(from: pubDate)
        return pubDateString
    }
}
