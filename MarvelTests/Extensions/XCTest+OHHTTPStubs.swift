//
//  XCTest+OHHTTPStubs.swift
//  MarvelTests
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

extension XCTest {
    func stub(
        pathEndsWith string: String,
        file: String,
        responseTime: Double = OHHTTPStubsDownloadSpeedWifi
    ) {
        OHHTTPStubsSwift.stub(condition: pathEndsWith(string)) { _ in
            let stubPath = OHPathForFile(file, type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"]).requestTime(0, responseTime: responseTime)
        }
    }

    func removeAllStubs() {
        HTTPStubs.removeAllStubs()
    }
}
