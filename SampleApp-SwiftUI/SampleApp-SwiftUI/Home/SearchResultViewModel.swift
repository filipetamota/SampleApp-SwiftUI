//
//  ImageListModel.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI
import Combine

struct SearchResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let photoId: String
    let alt_description: String
    let likes: Int
    let user: User
    let imageUrls: ImageUrl
    
    struct User: Codable {
        let name: String
    }

    struct ImageUrl: Codable {
        let thumb: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case alt_description
        case likes
        case user
        case imageUrls = "urls"
    }
}



final class SearchResultViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var searchResults: [SearchResult] = []
    @Published var totalResults: Int = 0
    @Published var totalPages: Int = 0
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        getSearchResults()
    }
    
    private func getSearchResults() {
        guard let request = Utils.buildURLRequest(requestData: .search, queryParams: [URLQueryItem(name: "query", value: "dog")]) else {
            // throw error
            return
        }
        APIClient.shared.getSearchResults(request: request, type: SearchResponse.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // throw error
                    break
                }
            } receiveValue: { searchResponse in
                self.searchResults = searchResponse.results
            }
            .store(in: &cancellables)
    }
}
