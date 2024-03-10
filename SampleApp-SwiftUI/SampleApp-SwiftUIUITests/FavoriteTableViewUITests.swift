//
//  FavoriteTableViewUITests.swift
//  SampleApp-SwiftUIUITests
//
//  Created by Filipe Mota on 10/3/24.
//

import XCTest

final class FavoriteTableViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        doDogSearch(app: app)
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_FavoriteTableView_favoriteTableView_shouldBeEmpty() {
        // GIVEN
        
        let navBar = app.navigationBars["Search"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        
        let cancelButton = navBar.buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
        cancelButton.tap()
        
        // WHEN
        let favoritesButton = navBar.buttons["Bookmark"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        // THEN
        XCTAssertEqual(app.collectionViews.cells.count, 0)
    }

    
    func test_FavoriteTableView_favoriteTableView_shouldHaveItems() {
        // GIVEN
        addThreeItemsToFavoriteList()
        
        let navBar = app.navigationBars["Search"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        
        let cancelButton = navBar.buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
        cancelButton.tap()
        
        // WHEN
        let favoritesButton = navBar.buttons["Bookmark"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        // THEN
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
    }
    
    func test_FavoriteTableView_favoriteTableView_shouldHaveItemsAndOpenDetail() {
        // GIVEN
        addThreeItemsToFavoriteList()
        
        var navBar = app.navigationBars["Search"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        
        let cancelButton = navBar.buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
        cancelButton.tap()
        
        // WHEN
        let favoritesButton = navBar.buttons["Bookmark"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
        app.collectionViews.cells.firstMatch.tap()
        
        // THEN
        navBar = app.navigationBars["Detail"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
    }
    
    func test_FavoriteTableView_favoriteTableView_shouldHaveItemsAndRemoveOne() {
        // GIVEN
        addThreeItemsToFavoriteList()
        
        let navBar = app.navigationBars["Search"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        
        let cancelButton = navBar.buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
        cancelButton.tap()
        
        // WHEN
        let favoritesButton = navBar.buttons["Bookmark"]
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        XCTAssertGreaterThan(app.collectionViews.cells.count, 0)
        let numberOfCellsBeforeDelete = app.collectionViews.cells.count
        app.collectionViews.cells.firstMatch.swipeLeft()
        
        let deleteButton = app.collectionViews.buttons["Delete"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 5))
        deleteButton.tap()
        
        // THEN
        let numberOfCellsAfterDelete = app.collectionViews.cells.count
        XCTAssertEqual(numberOfCellsAfterDelete, numberOfCellsBeforeDelete - 1)
    }
}

extension FavoriteTableViewUITests {
    func addThreeItemsToFavoriteList() {
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
        
        let okButton = alert.buttons["OK"]
        XCTAssertTrue(okButton.waitForExistence(timeout: 5))
        okButton.tap()
        
        let backButton = navBar.buttons["Search"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()
        
        
        app.collectionViews.cells.element(boundBy: 1).tap()
        
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(okButton.waitForExistence(timeout: 5))
        okButton.tap()
        
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()
        
        app.collectionViews.cells.element(boundBy: 2).tap()
        
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
        XCTAssertTrue(favoritesButton.waitForExistence(timeout: 5))
        favoritesButton.tap()
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(okButton.waitForExistence(timeout: 5))
        okButton.tap()
        
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()
    }
}
