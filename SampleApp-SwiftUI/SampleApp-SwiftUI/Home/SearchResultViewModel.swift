//
//  ImageListModel.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI
import Combine

struct SearchResponseModel: Decodable {
    let total: Int
    let total_pages: Int
    let results: [SearchResultModel]
}

struct SearchResultModel: Decodable, Hashable {
    let photoId: String
    let title: String?
    let likes: Int
    let user: User
    let imageUrls: ImageUrl
    
    struct User: Decodable, Hashable {
        let name: String
    }

    struct ImageUrl: Decodable, Hashable {
        let thumb: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case title = "alt_description"
        case likes, user
        case imageUrls = "urls"
    }
}

final class SearchResultViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var searchQuery: String = ""
    @Published private(set) var searchResults: [SearchResultModel] = []
    @Published var showLoadingIndicator: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    var nextPage: Int = 1
    private var totalResults: Int = 0
    private var totalPages: Int = 0
    
    public var apiClient: APIClient = AppAPIClient()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchQuery
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] searchQuery in
                self?.nextPage = 1
                self?.searchResults.removeAll()
                self?.getSearchResults(query: searchQuery)
            }
            .store(in: &cancellables)
    }
    
    func getSearchResults(query: String, page: Int = 1) {
        showLoadingIndicator = true
        guard let request = Utils.buildURLRequest(requestData: .search, queryParams: ["query": query, "page": String(page)]) else {
            showError = true
            errorMessage = NSLocalizedString("error_url_request", comment: "")
            showLoadingIndicator = false
            return
        }
        apiClient.fetchData(request: request, type: SearchResponseModel.self)
            .sink { [weak self ] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                    self?.showLoadingIndicator = false
                    break
                }
            } receiveValue: { [weak self ] searchResponse in
                self?.nextPage += 1
                self?.totalResults = searchResponse.total
                self?.totalPages = searchResponse.total_pages
                self?.searchResults += searchResponse.results
                self?.showLoadingIndicator = false
            }
            .store(in: &cancellables)
    }
    
    func loadMore() {
        getSearchResults(query: searchQuery, page: nextPage)
    }
    
    func shouldLoadMore(lastItem searchResult: SearchResultModel) -> Bool {
        searchResults.count < totalResults && searchResults.last?.photoId == searchResult.photoId
    }
}
