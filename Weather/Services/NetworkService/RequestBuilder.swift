//
//  RequestBuilder.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

struct RequestBuilder {
    // MARK: - Properties

    var baseUrl: URL
    var token: String?

    // MARK: - Init

    init(baseUrl: URL, token: String? = nil) {
        self.token = token

        self.baseUrl = baseUrl
    }

    // MARK: - Public Methods

    func urlRequest(forRequest request: INetworkRequest) -> URLRequest {
        let url = baseUrl.appendingPathComponent(request.path)

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = request.method.rawValue

        urlRequest.add(parameters: request.parameters)
        
        return urlRequest
    }
}

fileprivate extension URLRequest {
    mutating func add(parameters: Parameters) {
        switch parameters {
        case .none:
            break
        case .url(let params):
            guard var components = URLComponents(url: self.url!, resolvingAgainstBaseURL: false) else { return }
            var queryItems = components.queryItems ?? []
            for (key, value) in params {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            components.queryItems = queryItems
            self.url = components.url
        }
    }
}
