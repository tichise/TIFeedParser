//
//  SampleTests.swift
//  SampleTests
//
//  Created by tichise on 2016年3月17日 16/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import XCTest
import TIFeedParser
import Alamofire

@testable import Sample

class SampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRSS2() {
        let expectation = expectationWithDescription("testRSS2.0")
        
        let feedString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=rss&num=3&hl=ja"
        
        
        Alamofire.request(.GET, feedUrlString, parameters:nil)
            .response {request, response, xmlData, error  in
                
                if (xmlData == nil) {
                    return
                }
                
                TIFeedParser.parseRSS(feedString, completionHandler: {(result:Bool, channel:Channel, error:NSError?) -> Void in
                    
                    XCTAssertTrue(result)
                    
                    if (result) {
                        XCTAssertNotNil(channel.title)
                        XCTAssertNotNil(channel.link)
                        XCTAssertNotNil(channel.description)
                        XCTAssertNotNil(channel.items)
                        XCTAssertTrue(channel.items?.count > 0)
                        
                        print(channel.title)
                        print(channel.link)
                        print(channel.description)
                        
                        let item:Item = channel.items![0]
                        
                        if (item.title != nil) {
                            XCTAssertNotNil(item.title)
                            XCTAssertNotNil(item.link)
                            XCTAssertNotNil(item.description)
                            XCTAssertNotNil(item.contentEncoded)
                            XCTAssertNotNil(item.thumbnail)
                            
                            print(item.title)
                            print(item.link)
                            print(item.description)
                            print(item.thumbnail)
                            
                            XCTAssertTrue(true)
                            expectation.fulfill()
                        }
                    }
                })
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testRSS1() {
        let expectation = expectationWithDescription("testRSS1.0")
        
        let feedUrlString:String = "http://feeds.feedburner.com/hatena/b/hotentry"
        
        Alamofire.request(.GET, feedUrlString, parameters:nil)
            .response {request, response, xmlData, error  in
                
                if (xmlData == nil) {
                    return
                }
                
                
                TIFeedParser.parseRSS(xmlData, completionHandler: {(result:Bool, channel:Channel, error:NSError?) -> Void in
                    
                    XCTAssertTrue(result)
                    
                    if (result) {
                        XCTAssertNotNil(channel.title)
                        XCTAssertNotNil(channel.link)
                        XCTAssertNotNil(channel.description)
                        XCTAssertNotNil(channel.items)
                        
                        print(channel.title)
                        print(channel.link)
                        print(channel.description)
                        
                        XCTAssertTrue(channel.items?.count > 0)
                        
                        let item:Item = channel.items![0]
                        
                        if (item.title != nil) {
                            XCTAssertNotNil(item.title)
                            XCTAssertNotNil(item.link)
                            XCTAssertNotNil(item.description)
                            XCTAssertNotNil(item.contentEncoded)
                            XCTAssertNotNil(item.thumbnail)
                            
                            print(item.title)
                            print(item.link)
                            print(item.description)
                            print(item.thumbnail)
                            
                            XCTAssertTrue(true)
                            expectation.fulfill()
                        }
                    }
                })
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testAtom() {
        let expectation = expectationWithDescription("testAtom")
        
        let feedString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=atom&num=3&hl=ja"
        
        Alamofire.request(.GET, feedUrlString, parameters:nil)
            .response {request, response, xmlData, error  in
                
                if (xmlData == nil) {
                    return
                }
                
                TIFeedParser.parseAtom(feedString, completionHandler: {(result:Bool, feed:Feed, error:NSError?) -> Void in
                    
                    XCTAssertTrue(result)
                    
                    if (result) {
                        XCTAssertNotNil(feed.id)
                        XCTAssertNotNil(feed.title)
                        XCTAssertNotNil(feed.updated)
                        
                        print(feed.id)
                        print(feed.title)
                        print(feed.updated)
                        
                        XCTAssertNotNil(feed.entries)
                        XCTAssertTrue(feed.entries?.count > 0)
                        
                        let entry:Entry = feed.entries![0]
                        
                        if (entry.title != nil) {
                            XCTAssertNotNil(entry.id)
                            XCTAssertNotNil(entry.title)
                            XCTAssertNotNil(entry.updated)
                            XCTAssertNotNil(entry.summary)
                            
                            print(entry.id)
                            print(entry.title)
                            print(entry.updated)
                            print(entry.summary)
                            
                            XCTAssertTrue(true)
                            expectation.fulfill()
                        }
                    }
                })
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}
