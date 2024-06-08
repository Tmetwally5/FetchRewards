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

    init(monitor :NWPathMonitor) {
        self.monitor = monitor
        self.queue = DispatchQueue(label: "NetworkMonitor")
        self.monitor.pathUpdateHandler = {[weak self] path in
            DispatchQueue.main.async { [weak self] in
                self?.isConnected = (path.status == .satisfied)
            }
        }
        self.monitor.start(queue: self.queue)
    }
}
