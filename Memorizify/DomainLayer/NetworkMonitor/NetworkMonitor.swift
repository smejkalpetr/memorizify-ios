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
final class NetworkMonitor: ObservableObject {
    
    private let monitor: NWPathMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "monitorQueue", qos: .default, target: .main)
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
        }
        
        monitor.start(queue: queue)
    }
}
