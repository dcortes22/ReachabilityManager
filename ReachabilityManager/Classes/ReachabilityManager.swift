//
//  ReachabilityManager.swift
//  ReachabilityManager
//
//  Created by David Cortes on 4/21/20.
//

import Foundation
import Network

@available(iOS 12.0, *)
open class ReachabilityManager {
    
    var monitor:NWPathMonitor?
    public var currentAdapterMode: Adapter = .all
    public var currentConnectionStatus: Connection = .offline {
        willSet(value) {
            if case .online(let adapter) = value {
                self.currentAdapterMode = adapter
            }
        }
    }
    public typealias ConnectionReachable = (ReachabilityManager) -> ()
    public typealias ConnectionUnReachable = (ReachabilityManager) -> ()
    
    public var onConnectionReachable: ConnectionReachable?
    public var onConnectionUnReachable: ConnectionUnReachable?
    
    public var managerStarted = false
    
    public enum Adapter: CustomStringConvertible, Equatable {
        case all, wifi, cellular, wiredEthernet, loopback, other
        public var description: String {
            switch self {
            case .cellular:
                return "Cellular"
            case .wifi:
                return "WiFi"
            case .wiredEthernet:
                return "Wired Ethernet"
            case .loopback:
                return "Loopback"
            case .other:
                return "Other"
            case .all:
                return "All"
            }
        }
        
        public func getInterfaceType() -> NWInterface.InterfaceType {
            switch self {
            case .cellular:
                return NWInterface.InterfaceType.cellular
            case .wifi:
                return NWInterface.InterfaceType.wifi
            case .wiredEthernet:
                return NWInterface.InterfaceType.wiredEthernet
            case .loopback:
                return NWInterface.InterfaceType.loopback
            case .other:
                return NWInterface.InterfaceType.other
            default:
                return NWInterface.InterfaceType.other
            }
        }
    }
    
    public enum Connection: CustomStringConvertible, Equatable {
        case online(adapter:Adapter), offline
        public var description: String {
            switch self {
            case .online(let adapter):
                return "Connection On Line on \(adapter.description)"
            case .offline:
                return "Connection is Off Line"
            }
        }
        
        public static func ==(lhs: Connection, rhs: Connection) -> Bool {
            switch (lhs, rhs) {
            case (let .online(code1), let .online(code2)):
                return code1 == code2
            case (.offline, .offline):
                return true
            default:
                return false
            }
        }
    }
    
    public init(adapter:Adapter = .all) {
        self.initMonitor(adapter: adapter)
    }
    
    public func startManager() {
        if (monitor == nil) {
            self.initMonitor(adapter: self.currentAdapterMode)
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor?.start(queue: queue)
    }
    
    public func stopManager() {
        monitor?.cancel()
        monitor = nil
        managerStarted = false
    }
    
    fileprivate func initMonitor(adapter:Adapter) {
        monitor = adapter == .all ? NWPathMonitor() : NWPathMonitor(requiredInterfaceType: adapter.getInterfaceType())
        currentAdapterMode = adapter
        managerStarted = true
        monitor?.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // We have connection
                let adapters:[Adapter] = path.availableInterfaces.map({(interface) -> Adapter in
                    switch interface.type {
                    case .wifi:
                        return Adapter.wifi
                    case .other:
                        return Adapter.other
                    case .cellular:
                        return Adapter.cellular
                    case .wiredEthernet:
                        return Adapter.wiredEthernet
                    case .loopback:
                        return Adapter.loopback
                    @unknown default:
                        fatalError()
                    }
                })
                if let firstAdapter = adapters.first {
                    self.currentConnectionStatus = .online(adapter: firstAdapter)
                }else {
                    self.currentConnectionStatus = .online(adapter: .other)
                }
                DispatchQueue.main.async {
                    self.onConnectionReachable?(self)
                }
                
            }else {
                self.currentConnectionStatus = .offline
                DispatchQueue.main.async {
                    self.onConnectionUnReachable?(self)
                }
            }
        }
    }
}


