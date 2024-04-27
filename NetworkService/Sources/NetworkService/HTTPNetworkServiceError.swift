//
//  HTTPNetworkServiceError.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

public enum HTTPNetworkServiceError: Error {
    case noNetwork
    case noData
    case failedToDecodeResponse(Error)
}
