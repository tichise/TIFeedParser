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
        
        // 失敗後も続ける
        continueAfterFailure = true
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRSS2() {
        let expectation = self.expectation(description: "testRSS2.0")
        
        let feedUrlString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=rss&num=3&hl=ja"
        
        Alamofire.request(feedUrlString).response { response in
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {

                TIFeedParser.parseRSS(xmlData: data, onSuccess: { (channel) in

                    XCTAssertNotNil(channel.title)
                    XCTAssertNotNil(channel.link)
                    XCTAssertNotNil(channel.description)
                    XCTAssertNotNil(channel.items)
                    XCTAssertTrue(channel.items.count > 0)

                    if let title = channel.title {print(title)}
                    if let link = channel.link {print(link)}
                    if let description = channel.description {print(description)}

                    let item = channel.items[0]

                    XCTAssertNotNil(item.title)
                    XCTAssertNotNil(item.link)
                    XCTAssertNotNil(item.description)
                    // XCTAssertNotNil(item.contentEncoded)
                    XCTAssertNotNil(item.categories)
                    // XCTAssertNotNil(item.thumbnail)
                    XCTAssertNotNil(item.pubDate)

                    if let title = item.title {print(title)}
                    if let link = channel.link {print(link)}
                    if let description = item.description {print(description)}
                    if let thumbnail = item.thumbnail {print(thumbnail)}

                    print(item.categories)

                    XCTAssertTrue(true)
                    expectation.fulfill()

                }, onNotFound: {
                }, onFailure: { (error) in
                })
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    
    func testRSS1() {
        let expectation = self.expectation(description: "testRSS1.0")
        
        let feedUrlString:String = "http://feeds.feedburner.com/hatena/b/hotentry"
        
        Alamofire.request(feedUrlString).response { response in
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {

                TIFeedParser.parseRSS(xmlData: data, onSuccess: { (channel) in
                    XCTAssertNotNil(channel.title)
                    XCTAssertNotNil(channel.link)
                    XCTAssertNotNil(channel.description)
                    XCTAssertNotNil(channel.items)

                    if let title = channel.title {print(title)}
                    if let link = channel.link {print(link)}
                    if let description = channel.description {print(description)}

                    XCTAssertTrue(channel.items.count > 0)

                    let item = channel.items[0]

                    XCTAssertNotNil(item.title)
                    XCTAssertNotNil(item.link)
                    XCTAssertNotNil(item.description)
                    XCTAssertNotNil(item.contentEncoded)

                    if let title = item.title {print(title)}
                    if let link = channel.link {print(link)}
                    if let description = item.description {print(description)}
                    if let thumbnail = item.thumbnail {print(thumbnail)}

                    XCTAssertTrue(true)
                    expectation.fulfill()
                }, onNotFound: {
                }, onFailure: { (error) in
                })
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testAtomGihyo() {
        let expectation = self.expectation(description: "testAtom")
        
        let feedUrlString:String = "http://gihyo.jp/feed/atom"
        
        Alamofire.request(feedUrlString).response { response in
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {


                TIFeedParser.parseAtom(xmlData: data, onSuccess: { (feed) in
                    XCTAssertNotNil(feed.id)
                    XCTAssertNotNil(feed.title)
                    XCTAssertNotNil(feed.updated)

                    if let id = feed.id {print(id)}
                    if let title = feed.title {print(title)}
                    if let updated = feed.updated {print(updated)}

                    XCTAssertNotNil(feed.entries)
                    XCTAssertTrue(feed.entries.count > 0)

                    let entry = feed.entries[0]

                    XCTAssertNotNil(entry.id)
                    XCTAssertNotNil(entry.title)
                    XCTAssertNotNil(entry.updated)
                    XCTAssertNotNil(entry.summary)

                    if let id = entry.id {print(id)}
                    if let title = entry.title {print(title)}
                    if let updated = entry.updated {print(updated)}
                    if let summary = entry.summary {print(summary)}

                    XCTAssertTrue(true)
                    expectation.fulfill()
                }, onNotFound: {

                }, onFailure: { (error) in

                })
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testAtomGoogle() {
        let expectation = self.expectation(description: "testAtom")
        
        let feedUrlString:String = "https://news.google.com/news?ned=us&ie=UTF-8&oe=UTF-8&q=nasa&output=atom&num=3&hl=ja"
        
        Alamofire.request(feedUrlString).response { response in
            if let data = response.data, let _ = String(data: data, encoding: .utf8) {

                TIFeedParser.parseAtom(xmlData: data, onSuccess: { (feed) in
                    XCTAssertNotNil(feed.id)
                    XCTAssertNotNil(feed.title)
                    XCTAssertNotNil(feed.updated)

                    if let id = feed.id {print(id)}
                    if let title = feed.title {print(title)}
                    if let updated = feed.updated {print(updated)}

                    XCTAssertNotNil(feed.entries)
                    XCTAssertTrue(feed.entries.count > 0)

                    let entry = feed.entries[0]

                    XCTAssertNotNil(entry.id)
                    XCTAssertNotNil(entry.title)
                    XCTAssertNotNil(entry.updated)

                    if let id = entry.id {print(id)}
                    if let title = entry.title {print(title)}
                    if let updated = entry.updated {print(updated)}

                    XCTAssertTrue(true)
                    expectation.fulfill()

                }, onNotFound: {
                }, onFailure: { (error) in
                })
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
