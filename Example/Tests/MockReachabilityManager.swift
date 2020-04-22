//
//  MockReachabilityManager.swift
//  ReachabilityManager_Tests
//
//  Created by David Cortes on 4/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import ReachabilityManager

@available(iOS 12.0, *)
class MockReachabilityManager: ReachabilityManager {
   
    var customAdapter = ReachabilityManager.Adapter.all
    var notificatorEnabled = false
    
    override var currentConnectionStatus: ReachabilityManager.Connection {
        didSet {
            if notificatorEnabled {
                if customAdapter != self.currentAdapterMode {
                    switch currentConnectionStatus {
                    case .online(_):
                        self.onConnectionUnReachable?(self)
                    case .offline:
                        self.onConnectionUnReachable?(self)
                    }
                }else {
                    switch currentConnectionStatus {
                    case .online(_):
                        self.onConnectionReachable?(self)
                    case .offline:
                        self.onConnectionUnReachable?(self)
                    }
                }
            }
        }
    }
    
    init(newAdapter: ReachabilityManager.Adapter = .all) {
        super.init()
        currentAdapterMode = newAdapter
        notificatorEnabled = true
    }
}
