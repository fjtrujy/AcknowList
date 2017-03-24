//
//  AcknowParserTests.swift
//  AcknowExampleTests
//
//  Created by Vincent Tourraine on 15/08/15.
//  Copyright © 2015-2017 Vincent Tourraine. All rights reserved.
//

import UIKit
import XCTest

import AcknowList

class AcknowParserTests: XCTestCase {

    func testHeaderFooter() {
        let bundle = Bundle(for: AcknowParserTests.self)
        let path = bundle.path(forResource: "Pods-acknowledgements", ofType: "plist")
        if let path = path {
            let parser = AcknowParser(plistPath: path)
            XCTAssertNotNil(parser)

            let headerFooter = parser.parseHeaderAndFooter()
            if let header = headerFooter.header,
                let footer = headerFooter.footer {
                    XCTAssertEqual(header, "This application makes use of the following third party libraries:")
                    XCTAssertEqual(footer, "Generated by CocoaPods - https://cocoapods.org")
            }
            else {
                XCTAssert(false, "Header/footer not found")
            }
        }
        else {
            XCTAssert(false, "Plist not found")
        }
    }

    func testAcknowledgements() {
        let bundle = Bundle(for: AcknowParserTests.self)
        let path = bundle.path(forResource: "Pods-acknowledgements", ofType: "plist")
        if let path = path {
            let parser = AcknowParser(plistPath: path)
            XCTAssertNotNil(parser)

            let acknowledgements = parser.parseAcknowledgements()
            XCTAssertEqual(acknowledgements.count, 1)

            let acknow = acknowledgements.first
            if let acknow = acknow {
                XCTAssertEqual(acknow.title, "AcknowList")
                XCTAssertTrue(acknow.text.hasPrefix("Copyright (c) 2015-2016 Vincent Tourraine (http://www.vtourraine.net)"))
            }
            else {
                XCTAssert(false, "Acknowledgement not found")
            }
        }
        else {
            XCTAssert(false, "Plist not found")
        }
    }
    
    func testGeneralPerformance() {
        let bundle = Bundle(for: AcknowParserTests.self)
        let path = bundle.path(forResource: "Pods-AcknowExampleTests-acknowledgements", ofType: "plist")

        self.measure() {
            if let path = path {
                let parser = AcknowParser(plistPath: path)
                _ = parser.parseHeaderAndFooter()
                _ = parser.parseAcknowledgements()
            }
        }
    }
    
}
