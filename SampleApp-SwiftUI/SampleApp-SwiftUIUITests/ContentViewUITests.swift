//
//  ContentViewUITests.swift
//  SampleApp-SwiftUIUITests
//
//  Created by Filipe Mota on 10/3/24.
//

import XCTest

final class ContentViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_ContentView_homeTableView_shouldDoSearchAndShowResults() {
        // GIVEN
        
        // WHEN
        doDogSearch(app: app)
        
        // THEN
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
    }
    
    func test_ContentView_homeTableView_shouldDoSearchAndShowResultsAndCancel() {
        // GIVEN
        doDogSearch(app: app)
        
        // WHEN
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
        let cancelButton = app.navigationBars["Search"].buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
        cancelButton.tap()
        
        // THEN
        let placeholderText = app.staticTexts["PlaceholderText"]
        XCTAssertTrue(placeholderText.waitForExistence(timeout: 5))
    }
    
    func test_ContentView_homeTableView_shouldDoSearchAndOpenDetail() {
        // GIVEN
        doDogSearch(app: app)
        
        // WHEN
        app.collectionViews.cells.firstMatch.tap()
        
        // THEN
        let navBar = app.navigationBars["Detail"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
    }
    
}

extension XCTestCase {
    func doDogSearch(app: XCUIApplication) {
        let searchBar = app.navigationBars["Search"].searchFields["Search"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5))
        searchBar.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["D"]/*[[".keyboards.keys[\"D\"]",".keys[\"D\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"buscar\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
