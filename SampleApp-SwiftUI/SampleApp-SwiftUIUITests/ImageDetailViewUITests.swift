//
//  ImageDetailViewUITests.swift
//  SampleApp-SwiftUIUITests
//
//  Created by Filipe Mota on 10/3/24.
//

import XCTest

final class ImageDetailViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["enable-testing"]
        app.launch()
        doDogSearch(app: app)
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_ImageDetailView_backButton_shouldGoBackToList() {
        // GIVEN
        app.collectionViews.cells.firstMatch.tap()
        let navBar = app.navigationBars["Detail"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        
        // WHEN
        let backButton = navBar.buttons["Search"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()
        
        // THEN
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
    }
    
    func test_ImageDetailView_favoritesButton_shouldAddFavorite() {
        // GIVEN
        app.collectionViews.cells.firstMatch.tap()
        
        let navBar = app.navigationBars["Detail"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        
        // WHEN
        let favoritesButton = navBar.images["FavoriteButton"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        // THEN
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    func test_ImageDetailView_favoritesButton_shouldAddAndRemoveFavorite() {
        // GIVEN
        app.collectionViews.cells.firstMatch.tap()
        
        let navBar = app.navigationBars["Detail"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        
        // WHEN
        let favoritesButton = navBar.images["FavoriteButton"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        // THEN
        XCTAssertTrue(alert.exists)
    }
}
