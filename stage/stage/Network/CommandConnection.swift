//
//  CommandConnection.swift
//  stage
//
//  Created by Hanzhang Song on 3/1/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.
//

// Use this class to send/receive command to/from the phone

import Foundation
import Network

var sharedCommandConnection: CommandConnection?

enum CommandConnectionStatus {
    case connected
    case preparing
    case unconnected
}

protocol CommandDelegate: class {
    
}

class CommandConnection {
    var status: CommandConnectionStatus {
        get {
            if let state = connection?.state {
                switch state {
                case .ready:
                    return .connected
                case .preparing:
                    return .preparing
                default:
                    return .unconnected
                }
            }
            return .unconnected
        }
    }
    var connection: NWConnection?
    
//    init() {
//        connection = ConnectionListener(serverName: "shz-server", passcode: "123", commandDelegate: nil)
//    }
    
}
