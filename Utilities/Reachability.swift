//
//  Reachability.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//

import Network
import Combine

class Reachability: ObservableObject {
    @Published var isConnected: Bool = true

    private var monitor: NWPathMonitor
    private var queue: DispatchQueue

    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue(label: "NetworkMonitor")
        self.monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = (path.status == .satisfied)
            }
        }
        self.monitor.start(queue: self.queue)
    }
}
