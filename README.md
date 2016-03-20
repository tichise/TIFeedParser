#### TIFeedParser ![CocoaPods Version](https://img.shields.io/cocoapods/v/TIFeedParser.svg?style=flat) ![Platform](https://img.shields.io/cocoapods/p/TIFeedParser.svg?style=flat) ![License](https://img.shields.io/cocoapods/l/TIFeedParser.svg?style=flat)
==============

TIFeedParser is an parser for RSS, built on Alamofire and AEXML.


#### Examples

#### RSS1.0, RSS2.0
```
    func loadRSS() {
        
        let feedString:String = "https://news.google.com/news?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss"
        
        TIFeedParser.parseRSS(feedString, completionHandler: {(result:Bool, channel:Channel, error:NSError?) -> Void in
            
            if (result) {
                if (channel.title != nil) {
                    // self.items = channel.items!
                    // self.tableView.reloadData()
                }
            } else {
                if (error != nil) {
                    print(error?.localizedDescription)
                }
            }
        })
    }
```

#### Atom
```
func loadAtom() {
        
        let feedString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=atom&num=3&hl=ja"
        
        TIFeedParser.parseAtom(feedString, completionHandler: {(result:Bool, feed:Feed, error:NSError?) -> Void in
            
            if (result) {
                if (feed.title != nil) {
                    // self.entries = feed.entries!
                    // self.tableView.reloadData()
                }
            } else {
                if (error != nil) {
                    print(error?.localizedDescription)
                }
            }
        })
    }
```

#### Installation (CocoaPods)
`pod TIFeedParser`
