//
//  ImageDetailViewModel.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 29/2/24.
//

import SwiftUI
import Combine

struct DetailResponseModel: Codable, Hashable {
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
    
    struct User: Codable, Hashable {
        let name: String
    }

    struct ImageUrl: Codable, Hashable {
        let regular: String
        let thumb: String
    }
    
    struct Equipment: Codable, Hashable {
        let model: String?
    }
    
    struct Location: Codable, Hashable {
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
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    
    func getImageDetail(photoId: String) {
        guard let request = Utils.buildURLRequest(requestData: .get, pathVariable: photoId) else {
            showError = true
            errorMessage = "Error in URLRequest"
            return
        }
        APIClient.shared.getSearchResults(request: request, type: DetailResponseModel.self)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.showError = true
                    self.errorMessage = error.localizedDescription
                    break
                }
            } receiveValue: { detailResponse in
                self.detailResponse = detailResponse
            }
            .store(in: &cancellables)
    }
}
