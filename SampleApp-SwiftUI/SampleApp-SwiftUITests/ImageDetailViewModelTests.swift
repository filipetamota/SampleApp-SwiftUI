//
//  ImageDetailViewModelTests.swift
//  SampleApp-SwiftUITests
//
//  Created by Filipe Mota on 10/3/24.
//

import XCTest
import Combine
@testable import SampleApp_SwiftUI

final class ImageDetailViewModelTests: XCTestCase {

    func testImageDetailViewModelInit() {
        // Given
        
        // When
        let vm = ImageDetailViewModel()
        
        // Then
        XCTAssertEqual(vm.detailResponse, DetailResponseModel.empty)
        XCTAssertFalse(vm.showError)
    }
    
    func testSearchResultViewModelGetSearchResults() {
        // Given
        let vm = ImageDetailViewModel()
        let mockAPIClient = MockAPIClient()
        vm.apiClient = mockAPIClient
        
        // When
        vm.getImageDetail(photoId: "abc123")
        
        // Then
        XCTAssertNotEqual(vm.detailResponse, DetailResponseModel.empty)
        XCTAssertEqual(vm.detailResponse.photoId, "abc123")
        XCTAssertFalse(vm.showError)
    }
    
    func testSearchResultViewModelGetSearchResultsWithError() {
        // Given
        let vm = ImageDetailViewModel()
        let mockAPIClient = MockAPIClient()
        mockAPIClient.showError = true
        vm.apiClient = mockAPIClient
        
        // When
        vm.getImageDetail(photoId: "abc123")
        
        // Then
        XCTAssertEqual(vm.detailResponse, DetailResponseModel.empty)
        XCTAssertTrue(vm.showError)
    }
    
    

}

extension ImageDetailViewModelTests {
    class MockAPIClient: APIClient {
        var showError: Bool = false

        func fetchData<T>(request: URLRequest, type: T.Type) -> Future<T, URLError> where T : Decodable {
            if showError {
                return Future<T, URLError> { promise in
                    promise(.failure(URLError(.badServerResponse)))
                }
            } else {
                return Future<T, URLError> { promise in
                    promise(.success(DetailResponseModel(photoId: "abc123", width: 100, height: 100, title: nil, description: nil, likes: 654, user: .init(name: "Test User"), imageUrls: .init(regular: "", thumb: ""), equipment: .init(model: "Nikon D70"), location: nil) as! T))
                }
            }
        }
        
        
    }
}
