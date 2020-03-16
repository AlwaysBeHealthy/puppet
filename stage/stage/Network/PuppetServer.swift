//  Created by Hanzhang Song on 3/1/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.


import Foundation
import Network

/**
 *  @Brief: The server class which manages all clients' connections. The server has two channels: the data channel which uses UDP protocol and the command channel which uses the TCP protocol. All clients share the data channel and the command channel, the tasks of parsing clients' data requests and command requests are designated to the request handler classes.
 *
 *  The configuration of the server concludes the following settings:
 *  serverName  -   The name of the server
 *  passcode - The security code of the server
 */
class PuppetServer {
    
    static var sharedPuppetServer: PuppetServer?
    private var commandChannel: Channel?
    private var dataChannel: Channel?
    var serverName: String
    var passcode: String
    
    static func setupServer(serverName: String, passcode: String) -> PuppetServer? {
        guard sharedPuppetServer != nil else {
            PuppetServer.sharedPuppetServer = PuppetServer(serverName: serverName, passcode: passcode)
            return PuppetServer.sharedPuppetServer
        }
        return PuppetServer.sharedPuppetServer
    }

    // Create a listener with a name to advertise, a passcode for authentication,
    // and a delegate to handle inbound connections.
    private init(serverName: String, passcode: String) {
        // initialize the data channel and the command channel
        self.commandChannel = Channel(withType: .command, name: "command")
        self.dataChannel = Channel(withType: .data, name: "data")
        self.serverName = serverName
        self.passcode = passcode
    }

    // Start listening and advertising the command service and the data service.
    func start() {
        guard let commandChannel = self.commandChannel, let dataChannel = self.dataChannel else {
            return
        }
        
        commandChannel.start()
        dataChannel.start()
    }
    
    // Stop the command and data service
    func stop() {
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
