//
//  NetworkMonitor.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation
import Network

protocol INetworkMonitor {
    var isConnected: Bool { get }
    var connectionType: ConnectionType { get }

    func start()
    func stop()
}

final class NetworkMonitor: INetworkMonitor {
    // MARK: - Properties

    public static let shared = NetworkMonitor()

    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global()

    private(set) var isConnected: Bool
    private(set) var connectionType: ConnectionType

    // MARK: - Private Init

    private init() {
        self.monitor = NWPathMonitor()
        self.isConnected = false
        self.connectionType = .uncknown
    }

    // MARK: - Public Methods

    func start() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.connectionType = ConnectionType(path)
        }
    }

    func stop() {
        monitor.cancel()
    }
}
