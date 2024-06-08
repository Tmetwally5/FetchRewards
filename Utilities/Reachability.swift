//
//  Reachability.swift
//  FetchRewards
//
//  Created by Taha Metwally on 7/6/2024.
//

import Network
import Combine

/**
 A class that monitors the network reachability status and publishes updates when the network status changes.

 - Note: This class uses `NWPathMonitor` from the Network framework to monitor network status changes.
 */
class Reachability: ObservableObject {
    
    /// A published property that indicates whether the device is connected to the internet.
    @Published var isConnected: Bool = true

    /// The network path monitor instance that monitors changes in network status.
    private var monitor: NWPathMonitor
    
    /// A dispatch queue on which the network path monitor operates.
    private var queue: DispatchQueue

    /**
     Initializes a new `Reachability` instance with a specified network path monitor.
     
     - Parameter monitor: An `NWPathMonitor` instance to monitor network status changes.
     */
    init(monitor: NWPathMonitor) {
        self.monitor = monitor
        self.queue = DispatchQueue(label: "NetworkMonitor")
        
        // Set up the path update handler to update the isConnected property on the main thread
        self.monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        
        // Start the network path monitor on the specified queue
        self.monitor.start(queue: self.queue)
    }
}
