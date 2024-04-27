//
//  ConnectionType.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation
import Network

enum ConnectionType {
    case wifi
    case cellular
    case ethernet
    case uncknown

    init(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            self = .wifi
        } else if path.usesInterfaceType(.cellular) {
            self = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            self = .ethernet
        } else {
            self = .uncknown
        }
    }
}
