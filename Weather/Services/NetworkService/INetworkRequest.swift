//
//  INetworkRequest.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

protocol INetworkRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Parameters {
    case none
    case url([String: Any])
}
