//
//  LaunchScreenViewUITests.swift
//  FetchRewardsUITests
//
//  Created by Taha Metwally on 8/6/2024.
//

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
    
    override func setUpWithError() throws {
        // Stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    }
    
    func testLaunchScreenImage() {
        // Access the app instance
        let app = XCUIApplication()
        
        // Check if the launch screen image exists
        let imageView = app.images["launch_image"]
        XCTAssertTrue(imageView.exists, "Launch screen image view should exist")
        
    }
    
    func testLaunchScreenAppearance() throws {
        // Access the app instance
        let app = XCUIApplication()
        
        // Capture a screenshot of the launch screen
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testMainContentAfterLaunch() throws {
        // Access the app instance
        let app = XCUIApplication()
        
        // Wait for the launch screen to disappear and the main content to appear
        let mealsListView = app.otherElements["meals_list_view"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: mealsListView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        // Verify the main content is displayed
        XCTAssertTrue(mealsListView.exists, "The main content view should exist after the launch screen")
    }
    
    // Optionally, add more tests to cover additional UI elements and interactions
}
