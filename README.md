#### TIFeedParser ![CocoaPods Version](https://img.shields.io/cocoapods/v/TIFeedParser.svg?style=flat) ![Platform](https://img.shields.io/cocoapods/p/TIFeedParser.svg?style=flat) ![License](https://img.shields.io/cocoapods/l/TIFeedParser.svg?style=flat)

TIFeedParser is an parser for RSS, built on Alamofire and AEXML.

TIFeedParserはSwiftで書かれた非常にシンプルなRSSパーサーです。Atom、RSS1.0、RSS2.0に対応しています。cocoapodsからダウンロードして使えます。詳細な使い方は[こちら](http://qiita.com/tichise/items/b9f55ce924159f4ad0cd)に記載してます。


#### Examples

#### RSS1.0, RSS2.0
```
    func loadRSS() {
        
        let feedString:String = "https://news.google.com/news?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss"

        Alamofire.request(.GET, feedUrlString, parameters:nil)
            .response {request, response, xmlData, error  in
                
                if (xmlData == nil) {
                    return
                }
                
                TIFeedParser.parseRSS(xmlData, completionHandler: {(isSuccess, channel, error) -> Void in
                    
                    if (isSuccess) {
                        // self.items = channel.items!
                        // self.tableView.reloadData()
                    } else {
                        if (error != nil) {
                            print(error?.localizedDescription)
                        }
                    }
                })
        }
    }
```

#### Atom
```
	func loadAtom() {
        
        let feedString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=atom&num=3&hl=ja"
        
        Alamofire.request(.GET, feedUrlString, parameters:nil)
            .response {request, response, xmlData, error  in
                
                if (xmlData == nil) {
                    return
                }
                
                TIFeedParser.parseAtom(xmlData, completionHandler: {(isSuccess, feed, error) -> Void in
                    
                    if (isSuccess) {
                        // self.entries = feed.entries!
                        // self.tableView.reloadData()
                    } else {
                        if (error != nil) {
                            print(error?.localizedDescription)
                        }
                    }
                })
        }
    }
```

#### Installation (CocoaPods)
`pod TIFeedParser`
