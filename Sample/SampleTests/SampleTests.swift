//
//  SampleTests.swift
//  SampleTests
//
//  Created by tichise on 2016年3月17日 16/03/17.
//  Copyright © 2016年 tichise. All rights reserved.
//

import XCTest
import TIFeedParser

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
        
        let feedString:String = "http://pickup.calamel.jp/feed"
        // "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=rss&num=3&hl=ja"
        
        TIFeedParser.parse(feedString, completionHandler: {(result:Bool, channel:Channel) -> Void in
            
            XCTAssertTrue(result)
            expectation.fulfill()
            
            /*
            if (result) {
                XCTAssertNotNil(channel.title)
                XCTAssertNotNil(channel.link)
                XCTAssertNotNil(channel.description)
                XCTAssertNotNil(channel.items)
                XCTAssertTrue(channel.items?.count > 0)
                
                let item:Item = channel.items![0]
                
                XCTAssertNotNil(item.title)
                XCTAssertNotNil(item.link)
                XCTAssertNotNil(item.description)
                XCTAssertNotNil(item.thumbnail)
                
                if (item.title != nil) {
                    print(item.title)
                    
                    XCTAssertTrue(true)
                    expectation.fulfill()
                }
            }
            */
        })
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testRSS1() {
        let expectation = expectationWithDescription("testRSS1.0")
        
        let feedString:String = "http://feeds.feedburner.com/hatena/b/hotentry"
        TIFeedParser.parse(feedString, completionHandler: {(result:Bool, channel:Channel) -> Void in
            
            XCTAssertTrue(result)
            expectation.fulfill()
            
            /*
            if (result) {
                XCTAssertNotNil(channel.title)
                XCTAssertNotNil(channel.link)
                XCTAssertNotNil(channel.description)
                XCTAssertNotNil(channel.items)
                XCTAssertTrue(channel.items?.count > 0)
                
                let item:Item = channel.items![0]

                XCTAssertNotNil(item.title)
                XCTAssertNotNil(item.link)
                XCTAssertNotNil(item.description)
                XCTAssertNotNil(item.thumbnail)
                
                if (item.title != nil) {
                    print(item.title)
                    expectation.fulfill()
                }
            }
            */
        })
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testAtom() {
        let expectation = expectationWithDescription("testAtom")
        
        let feedString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=atom&num=3&hl=ja"
        TIFeedParser.parse(feedString, completionHandler: {(result:Bool, channel:Channel) -> Void in
            
            XCTAssertTrue(result)
            expectation.fulfill()
            
            /*
            if (result) {
                XCTAssertNotNil(channel.title)
                XCTAssertNotNil(channel.link)
                XCTAssertNotNil(channel.description)
                XCTAssertNotNil(channel.items)
                XCTAssertTrue(channel.items?.count > 0)
                
                let item:Item = channel.items![0]
                
                XCTAssertNotNil(item.title)
                XCTAssertNotNil(item.link)
                XCTAssertNotNil(item.description)
                XCTAssertNotNil(item.thumbnail)
                
                if (item.title != nil) {
                    print(item.title)
                    expectation.fulfill()
                }
            }
            */
        })
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}
