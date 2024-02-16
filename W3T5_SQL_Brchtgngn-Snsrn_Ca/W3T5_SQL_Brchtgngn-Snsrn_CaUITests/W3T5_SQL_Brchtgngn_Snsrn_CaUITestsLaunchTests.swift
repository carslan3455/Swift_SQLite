//
//  W3T5_SQL_Brchtgngn_Snsrn_CaUITestsLaunchTests.swift
//  W3T5_SQL_Brchtgngn-Snsrn_CaUITests
//
//  Created by alfa on 24.11.23.
//

import XCTest

final class W3T5_SQL_Brchtgngn_Snsrn_CaUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
