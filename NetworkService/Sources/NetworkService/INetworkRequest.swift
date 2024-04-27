//
//  INetworkRequest.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

public protocol INetworkRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum Parameters {
    case none
    case url([String: Any])
}
