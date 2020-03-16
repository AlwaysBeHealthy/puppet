//
//  CommandProtocol.swift
//  stage
//
//  Created by Hanzhang Song on 3/15/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.
//

import Network
import Foundation

class CommandProtocol: NWProtocolFramerImplementation {
    static var label: String
    
    required init(framer: NWProtocolFramer.Instance) {
        <#code#>
    }
    
    func start(framer: NWProtocolFramer.Instance) -> NWProtocolFramer.StartResult {
        <#code#>
    }
    
    func handleInput(framer: NWProtocolFramer.Instance) -> Int {
        <#code#>
    }
    
    func handleOutput(framer: NWProtocolFramer.Instance, message: NWProtocolFramer.Message, messageLength: Int, isComplete: Bool) {
        <#code#>
    }
    
    func wakeup(framer: NWProtocolFramer.Instance) {
        <#code#>
    }
    
    func stop(framer: NWProtocolFramer.Instance) -> Bool {
        <#code#>
    }
    
    func cleanup(framer: NWProtocolFramer.Instance) {
        <#code#>
    }
    
    
}
