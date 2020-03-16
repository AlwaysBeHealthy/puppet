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

enum ConnectionStatus {
    case connected
    case preparing
    case unconnected
}

class Connection {
    var connection: NWConnection?
    var delegate: RequestHandler?
    var status: ConnectionStatus {
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
    
    init(connection: NWConnection, delegate: RequestHandler) {
        self.connection = connection
        self.delegate = delegate
        
        self.connection?.stateUpdateHandler = { status in
            switch status {
            case .ready:
                self.receiveNextMessage()
                break
            case .failed(let error):
                print(error)
                break
            default:
                break
            }
        }
        self.connection?.start(queue: .main)
    }
    
    func receiveNextMessage() {
        guard let connection = connection else {
            return
        }
        
        connection.receiveMessage { (content, context, isComplete, error) in
            // Extract your message type from the received context.
            if let message = context?.protocolMetadata(definition: RequestHandler.definition) as? NWProtocolFramer.Message {
                self.delegate?.receivedMessage(content: content, message: message)
            }
            if error == nil {
                // Continue to receive more messages until you receive and error.
                self.receiveNextMessage()
            }
        }
    }
}
