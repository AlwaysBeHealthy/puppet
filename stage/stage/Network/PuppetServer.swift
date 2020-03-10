//
//  connectionListener.swift
//  stage
//
//  Created by Hanzhang Song on 3/1/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.
//

import Foundation
import Network

class PuppetServer {
    
    var commandChannel: Channel?
    var dataChannel: Channel?
    var serverName: String
    let passcode: String

    // Create a listener with a name to advertise, a passcode for authentication,
    // and a delegate to handle inbound connections.
    init(serverName: String, passcode: String) {
        self.serverName = serverName
        self.passcode = passcode
    }

    // Start listening and advertising the command service.
    func turnOn() {
        guard let commandChannel = commandChannel else {
            return
        }
        
        commandChannel.start()
    }
    
    // Stop the command and data service
    func turnOff() {
        guard let commandChannel = commandChannel, let dataChannel = dataChannel else {
            return
        }
        commandChannel.stop()
        dataChannel.stop()
    }
    
    // Update the advertised server name.
    func resetName(_ serverName: String) {
    }
}
