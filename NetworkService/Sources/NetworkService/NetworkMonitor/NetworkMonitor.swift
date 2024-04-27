//
//  NetworkMonitor.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation
import Network

public protocol INetworkMonitor {
    var isConnected: Bool { get }
    var connectionType: ConnectionType { get }

    func start()
    func stop()
}

public final class NetworkMonitor: INetworkMonitor {
    // MARK: - Properties

    public static let shared = NetworkMonitor()

    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global()

    public private(set) var isConnected: Bool
    public private(set) var connectionType: ConnectionType

    // MARK: - Private Init

    private init() {
        self.monitor = NWPathMonitor()
        self.isConnected = false
        self.connectionType = .uncknown
    }

    // MARK: - Public Methods

    public func start() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.connectionType = ConnectionType(path)
        }
    }

    public func stop() {
        monitor.cancel()
    }
}
