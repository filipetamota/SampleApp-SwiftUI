//
//  APIClient.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 28/2/24.
//

import Foundation
import Combine

enum RequestData {
    case search
    case get
    
    func path() -> String {
        switch self {
        case .search:
            return "search/photos"
        case .get:
            return "photos/"
        }
    }
    
    func method() -> String {
        switch self {
        case .search, .get:
            return "GET"
        }
    }
}

final class APIClient {
    private var cancellables = Set<AnyCancellable>()
    static var shared = APIClient()
    
    func getSearchResults<T: Decodable> (request: URLRequest, type: T.Type) -> Future<T, URLError> {
        return Future<T, URLError> { [weak self] promise in
            guard let self = self else {
                promise(.failure(URLError(.badURL)))
                return
            }
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap({ output in
                    guard
                        let response = output.response as? HTTPURLResponse,
                        response.statusCode >= 200 && response.statusCode < 300 else {
                        throw URLError(.badServerResponse)
                    }
                    return output.data
                })
                .decode(type: T.self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure:
                        promise(.failure(URLError(.cannotDecodeContentData)))
                    }
                } receiveValue: { results in
                    promise(.success(results))
                }
                .store(in: &cancellables)
        }
    }
}
