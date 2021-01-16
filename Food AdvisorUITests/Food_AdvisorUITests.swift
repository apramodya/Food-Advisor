//
//  Food_AdvisorUITests.swift
//  Food AdvisorUITests
//
//  Created by Pramodya Abeysinghe on 2021-01-15.
//

import XCTest

class Food_AdvisorUITests: XCTestCase {
    
    func testLoadMainScreenWithHelloText() {
        let app = XCUIApplication()
        app.launch()
        
        let _ = app.wait(for: .runningForeground, timeout: 3)
        let greetingLabel = app.staticTexts["greetingLabel"].firstMatch
        XCTAssertNotNil(greetingLabel.label.range(of:"Hello"))
    }
    
    func testCanTapOnACellAndGoInside() {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.cells.element(boundBy:0).tap()
        
        let titleLabel = app.staticTexts["titleLabel"].firstMatch
        XCTAssertTrue(titleLabel.exists)
    }
    
    func testOpenBookingForm() {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.cells.element(boundBy:0).tap()
        app.buttons["makeABookingButton"].tap()
        
        let submitButton = app.buttons["submitButton"].firstMatch
        XCTAssertTrue(submitButton.exists)
    }
    
    func testOpenBookingFormAndSubmit() {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.cells.element(boundBy:0).tap()
        app.buttons["makeABookingButton"].tap()
        
        let submitButton = app.buttons["submitButton"].firstMatch
        XCTAssertTrue(submitButton.exists)
        
        let bookingDate = Date(timeIntervalSinceNow: 60*60*24*3)
        let dateformator = DateFormatter()
        dateformator.dateStyle = .medium
        dateformator.timeStyle = .none
        
        let dateTextField = app.textFields["dateTextField"]
        dateTextField.tap()
        dateTextField.typeText(dateformator.string(from: bookingDate))
       
        dateformator.dateStyle = .none
        dateformator.timeStyle = .medium
        let timeTextField = app.textFields["timeTextField"]
        timeTextField.tap()
        timeTextField.typeText(dateformator.string(from: bookingDate))
        
        let durationTextField = app.textFields["durationTextField"]
        durationTextField.tap()
        durationTextField.typeText("5")
        
        let headCountTextField = app.textFields["headCountTextField"]
        headCountTextField.tap()
        headCountTextField.typeText("4")

        submitButton.tap()
    }
    
    func testOpenBookingFormAndSubmitWithEmptyFieldsAndGetError() {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.cells.element(boundBy:0).tap()
        app.buttons["makeABookingButton"].tap()
        
        let submitButton = app.buttons["submitButton"].firstMatch
        XCTAssertTrue(submitButton.exists)
        
        let bookingDate = Date(timeIntervalSinceNow: 60*60*24*3)
        let dateformator = DateFormatter()
        dateformator.dateStyle = .medium
        dateformator.timeStyle = .none
        
        let dateTextField = app.textFields["dateTextField"]
        dateTextField.tap()
        dateTextField.typeText(dateformator.string(from: bookingDate))
       
        dateformator.dateStyle = .none
        dateformator.timeStyle = .medium
        let timeTextField = app.textFields["timeTextField"]
        timeTextField.tap()
        timeTextField.typeText(dateformator.string(from: bookingDate))
        
        let headCountTextField = app.textFields["headCountTextField"]
        headCountTextField.tap()
        headCountTextField.typeText("4")

        submitButton.tap()
        
        let alertTitleLabel = app.staticTexts["alertTitleLabel"]
        XCTAssertNotNil(alertTitleLabel.label.contains("Error"))
    }
}
