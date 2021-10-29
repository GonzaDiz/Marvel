//
//  ThumbnailTests.swift
//  MarvelTests
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import Foundation
import XCTest
@testable import Marvel

class ThumbnailTests: XCTestCase {
    func test_thumbnail_withPathAndExtension_shouldReturnExpectedURL() {
        let thumbnail = Thumbnail(path: "https://www.image.com/234234", extension: "jpg")

        let expectedURL = URL(string: "https://www.image.com/234234.jpg")

        XCTAssertEqual(thumbnail.url, expectedURL)
    }
}
