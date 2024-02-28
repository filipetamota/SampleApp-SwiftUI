//
//  Utils.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 28/2/24.
//

import Foundation

final class Utils {
    
    static func getAPIInfoFromPlist(propertyName: String) -> String? {
        guard
            let path = Bundle.main.path(forResource: "APIInfo", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let property = dict[propertyName] as? String
        else {
            return nil
        }
        
        return property
    }

    static func buildURLRequest(requestData: RequestData, queryParams: [URLQueryItem]? = nil, pathVariable: String? = nil) -> URLRequest? {
        guard
            let domain = getAPIInfoFromPlist(propertyName: "Domain"),
            let accessKey = getAPIInfoFromPlist(propertyName: "AccessKey"),
            let baseURL = URL(string: domain)
        else {
            assertionFailure()
            return nil
        }
        var url = baseURL.appendingPathComponent(requestData.path())
        
        if let pathVariable = pathVariable {
            url = url.appendingPathComponent(pathVariable)
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if
            let queryParams = queryParams,
            requestData.method() == "GET"
        {
            components?.queryItems = queryParams
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = requestData.method()
        urlRequest.addValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")

        return urlRequest
    }
}

