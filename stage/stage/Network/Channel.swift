//
//  Channel.swift
//  stage
//
//  Created by Hanzhang Song on 3/8/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.
//

import Foundation
import Network

enum ChannelType {
    case data
    case command
}

/**
 *  @Brief: The Channel class is owned by the PuppetServer class. Channel class is used to manage all clinents' connections. A channel has one listener which is used for setting up new connections with the clinents.
 */
class Channel {
    
    var listener: NWListener?
    var connectionList: [Connection] = []
    var name: String
    
    init(withType type: ChannelType, name: String) {
        self.name = name
        setupListener(type: type)
    }
    
    // Setup listener
    private func setupListener(type: ChannelType) {
        guard let sharedPuppetServer = PuppetServer.sharedPuppetServer else {
            return
        }
        do {
            switch type {
            case .command:
                self.listener = try NWListener(using: NWParameters(tcpWithPasscode: sharedPuppetServer.passcode))
                self.listener?.service = NWListener.Service(name: sharedPuppetServer.serverName + name, type: "_puppet._tcp")
            case .data:
                self.listener = try NWListener(using: NWParameters(udpWithPasscode: sharedPuppetServer.passcode))
                self.listener?.service = NWListener.Service(name: sharedPuppetServer.serverName + name, type: "_puppet._udp")
            }
            
            self.listener?.stateUpdateHandler = { newState in
                switch newState {
                case .ready:
                    print("Listener ready on \(String(describing: self.listener?.port))")
                case .failed(let error):
                    print("Listener failed with \(error), restarting")
                    self.listener?.cancel()
                default:
                    break
                }
            }
            
            self.listener?.newConnectionHandler = { newConnection in
                let connection = Connection(connection: newConnection, delegate: RequestHandler()) // TODO: to be revised
                self.connectionList.append(connection)
            }
            
        } catch {
            print("Failed to create listener")
            abort()
        }
    }
    
    // Start the listener
    func start() {
        self.listener?.start(queue: .main)
    }
    
    // Terminate all connections and close the listener
    func stop() {
        
    }
    
    //TODO:: Bind connection with the request handler
}
