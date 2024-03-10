//
//  SearchResultViewModelTest.swift
//  SampleApp-SwiftUITests
//
//  Created by Filipe Mota on 10/3/24.
//

import XCTest
import Combine
@testable import SampleApp_SwiftUI

final class SearchResultViewModelTests: XCTestCase {
    
    func testSearchResultViewModelInit() {
        // Given
        
        // When
        let vm = SearchResultViewModel()
        
        // Then
        XCTAssertTrue(vm.searchResults.isEmpty)
        XCTAssertFalse(vm.showError)
        XCTAssertEqual(vm.searchQuery, "")
    }
    
    func testSearchResultViewModelGetSearchResults() {
        // Given
        let vm = SearchResultViewModel()
        let mockAPIClient = MockAPIClient()
        vm.apiClient = mockAPIClient
        
        // When
        vm.getSearchResults(query: "dog", page: 1)
        
        // Then
        XCTAssertFalse(vm.searchResults.isEmpty)
        XCTAssertEqual(vm.searchResults.first?.photoId, "abc123")
        XCTAssertFalse(vm.showError)
    }
    
    func testSearchResultViewModelGetSearchResultsWithError() {
        // Given
        let vm = SearchResultViewModel()
        let mockAPIClient = MockAPIClient()
        mockAPIClient.showError = true
        vm.apiClient = mockAPIClient
        
        // When
        vm.getSearchResults(query: "dog", page: 1)
        
        // Then
        XCTAssertTrue(vm.searchResults.isEmpty)
        XCTAssertTrue(vm.showError)
    }
    
    func testSearchResultViewModelGetSearchResultsAndLoadMore() {
        // Given
        let vm = SearchResultViewModel()
        let mockAPIClient = MockAPIClient()
        vm.apiClient = mockAPIClient
        
        // When
        vm.getSearchResults(query: "dog", page: 1)
        XCTAssertFalse(vm.searchResults.isEmpty)
        XCTAssertEqual(vm.searchResults.first?.photoId, "abc123")
        XCTAssertFalse(vm.showError)
        XCTAssertEqual(vm.nextPage, 2)
        vm.loadMore()
        
        // Then
        XCTAssertEqual(vm.nextPage, 3)
    }
    
    func testSearchResultViewModelShouldGetMore() {
        // Given
        let vm = SearchResultViewModel()
        let mockAPIClient = MockAPIClient()
        vm.apiClient = mockAPIClient
        
        // When
        vm.getSearchResults(query: "dog", page: 1)
        XCTAssertFalse(vm.searchResults.isEmpty)
        XCTAssertEqual(vm.searchResults.first?.photoId, "abc123")
        XCTAssertFalse(vm.showError)
        XCTAssertEqual(vm.nextPage, 2)
        
        // Then
        XCTAssertFalse(vm.shouldLoadMore(lastItem: SearchResultModel(photoId: "tre765", title: nil, likes: 0, user: .init(name: ""), imageUrls: .init(thumb: ""))))
        XCTAssertTrue(vm.shouldLoadMore(lastItem: SearchResultModel(photoId: "abc123", title: nil, likes: 0, user: .init(name: ""), imageUrls: .init(thumb: ""))))
    }

}

extension SearchResultViewModelTests {
    class MockAPIClient: APIClient {
        var showError: Bool = false

        func fetchData<T>(request: URLRequest, type: T.Type) -> Future<T, URLError> where T : Decodable {
            if showError {
                return Future<T, URLError> { promise in
                    promise(.failure(URLError(.badServerResponse)))
                }
            } else {
                return Future<T, URLError> { promise in
                    promise(.success(SearchResponseModel(total: 10, total_pages: 100, results: [SearchResultModel(photoId: "abc123", title: nil, likes: 567, user: .init(name: "Test User"), imageUrls: .init(thumb: ""))]) as! T))
                }
            }
        }
        
        
    }
}
