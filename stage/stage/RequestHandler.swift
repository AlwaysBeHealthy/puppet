//
//  RequestHandler.swift
//  stage
//
//  Created by Hanzhang Song on 3/14/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.
//

import Foundation
import Network

/**
 *  @Brief: The RequestHandler is used to parse all clients' requests including the command requests and the data requests.
 */
class RequestHandler: NWProtocolFramerImplementation {
    static var label: String { return "Puppet" }
    
    init() {
    }
    
    required init(framer: NWProtocolFramer.Instance) {
        
    }
    
    func start(framer: NWProtocolFramer.Instance) -> NWProtocolFramer.StartResult {
        return .ready
    }
    
    func handleInput(framer: NWProtocolFramer.Instance) -> Int {
        return 0
    }
    
    func handleOutput(framer: NWProtocolFramer.Instance, message: NWProtocolFramer.Message, messageLength: Int, isComplete: Bool) {
        
    }
    
    func wakeup(framer: NWProtocolFramer.Instance) {
        
    }
    
    func stop(framer: NWProtocolFramer.Instance) -> Bool {
        return true
    }
    
    func cleanup(framer: NWProtocolFramer.Instance) {
        
    }
    
    static let definition = NWProtocolFramer.Definition(implementation: RequestHandler.self)
    
    func receivedMessage(content: Data?, message: NWProtocolFramer.Message) {
        
    }
}
