//
//  NetworkService.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

protocol INetworkService {
    func perform<T: Codable>(_ request: INetworkRequest) async throws -> T
}

final class NetworkService: INetworkService {
    // MARK: - Properties

    private let session: URLSession
    private let networkMonitor: INetworkMonitor
    private let requestBuilder: RequestBuilder
    private let decoder: JSONDecoder

    // MARK: - Init

    init(
        session: URLSession,
        networkMonitor: INetworkMonitor,
        requestBuilder: RequestBuilder,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.networkMonitor = networkMonitor
        self.requestBuilder = requestBuilder
        self.decoder = decoder
    }

    // MARK: - Public Methods

    func perform<T: Codable>(_ request: INetworkRequest) async throws -> T {
        guard networkMonitor.isConnected else {
            throw HTTPNetworkServiceError.noNetwork
        }

        let urlRequest = requestBuilder.urlRequest(forRequest: request)
        let (data, _) = try await session.data(for: urlRequest)

        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            throw HTTPNetworkServiceError.failedToDecodeResponse(error)
        }
    }
}
