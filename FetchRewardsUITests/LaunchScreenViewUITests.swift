//
//  LaunchScreenViewUITests.swift
//  FetchRewardsUITests
//
//  Created by Taha Metwally on 8/6/2024.
//

import XCTest
import SwiftUI
@testable import FetchRewards

class LaunchScreenViewUITests: XCTestCase {
    func testLaunchScreenImage() {
        let app = XCUIApplication()
        app.launch()
        
        // Assuming the image view has an accessibility identifier set to "launch_image"
        let imageView = app.images["launch_image"]
        XCTAssertTrue(imageView.exists, "Launch screen image view should exist")
    }
}
