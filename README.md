#### TIFeedParser ![CocoaPods Version](https://img.shields.io/cocoapods/v/MaterialDesignSymbol.svg?style=flat) ![Platform](https://img.shields.io/cocoapods/p/MaterialDesignSymbol.svg?style=flat) ![License](https://img.shields.io/cocoapods/l/MaterialDesignSymbol.svg?style=flat)
==============

TIFeedParser is an parser for RSS, built on Alamofire and AEXML.


#### Examples

```
        let feedString:String = "https://news.google.com/news?hl=us&ned=us&ie=UTF-8&oe=UTF-8&output=rss"
        
        TIFeedParser.shared.parse(feedString, completionHandler: {(result:Bool, channel:Channel) -> Void in
            
            if (result) {
                self.items = channel.items!
            }
        })
```

#### Installation (CocoaPods)
`pod TIFeedParser`
