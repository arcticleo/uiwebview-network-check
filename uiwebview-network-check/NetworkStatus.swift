//
//  NetworkStatus.swift
//  uiwebview-network-check
//
//  Created by Michael Edlund on 4/14/17.
//  Copyright © 2017 MIchael Edlund. All rights reserved.
//

import Foundation

struct NetworkStatus {
    static var lastStatus: ReachabilityStatus = .unknown
    static var timer: Timer?
    
    static func fireRepeatedOnlineCheck() {
        NetworkStatus.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: {(Void)  in
            ViewController().checkNetwork()
            if case .online = NetworkStatus.lastStatus {
                ViewController().loadWebApp()
            }
        })
    }
    
    static func invalidateRepeatedOnlineCheck() {
        NetworkStatus.timer?.invalidate()
    }
}
