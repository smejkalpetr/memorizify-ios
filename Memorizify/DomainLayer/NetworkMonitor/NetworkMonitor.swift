//
//  NetworkMonitor.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 25.04.2024.
//

import SwiftUI
import Network
import Foundation

/*
    Idea for this Network Montior class has been taken from the following publicly available source:
    https://medium.com/@grujic.nikola91/how-to-check-for-network-connection-in-swiftui-using-nwpathmonitor-a2eb2e508ea8
 */

/// Monitors the network connection status.
final class NetworkMonitor: ObservableObject {
    
    /// The network path monitor instance.
    private let monitor: NWPathMonitor = NWPathMonitor()
    
    /// The queue for handling network path updates.
    private let queue = DispatchQueue(label: "monitorQueue", qos: .default, target: .main)
    
    /// Indicates whether the device is currently connected to the network.
    @Published var isConnected = true
    
    /// Initializes the NetworkMonitor instance.
    init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
        }
        
        monitor.start(queue: queue)
    }
}
