//
//  ImageDetailViewModel.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 29/2/24.
//

import SwiftUI
import Combine

struct DetailResponseModel: Decodable {
    let photoId: String
    let width: Int
    let height: Int
    let title: String?
    let description: String?
    let likes: Int
    let user: User
    let imageUrls: ImageUrl
    let equipment: Equipment?
    let location: Location?
    
    struct User: Decodable {
        let name: String
    }

    struct ImageUrl: Decodable {
        let regular: String
        let thumb: String
    }
    
    struct Equipment: Decodable {
        let model: String?
    }
    
    struct Location: Decodable {
        let name: String?
    }
    
    private enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case title = "alt_description"
        case imageUrls = "urls"
        case equipment = "exif"
        case width, height, description, likes, user, location
    }
    
    static var empty = DetailResponseModel(photoId: "",
                                           width: 0,
                                           height: 0,
                                           title: nil,
                                           description: nil,
                                           likes: 0,
                                           user: User(name: ""),
                                           imageUrls: ImageUrl(regular: "", thumb: ""),
                                           equipment: nil,
                                           location: nil)
}

final class ImageDetailViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var detailResponse: DetailResponseModel = .empty
    @Published var showLoadingIndicator: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    
    func getImageDetail(photoId: String) {
        showLoadingIndicator = true
        guard let request = Utils.buildURLRequest(requestData: .get, pathVariable: photoId) else {
            showError = true
            errorMessage = NSLocalizedString("error_url_request", comment: "")
            showLoadingIndicator = false
            return
        }
        APIClient.shared.getSearchResults(request: request, type: DetailResponseModel.self)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                    self?.showLoadingIndicator = false
                    break
                }
            } receiveValue: { [weak self] detailResponse in
                self?.detailResponse = detailResponse
                self?.showLoadingIndicator = false
            }
            .store(in: &cancellables)
    }
}
