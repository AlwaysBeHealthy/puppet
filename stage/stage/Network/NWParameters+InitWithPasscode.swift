/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Set up parameters for secure peer-to-peer connections and listeners.
*/

import Network
import CryptoKit

extension NWParameters {

	// Create parameters for use in PeerConnection and PeerListener.
	convenience init(tcpWithPasscode passcode: String) {
		// Customize TCP options to enable keepalives.
		let tcpOptions = NWProtocolTCP.Options()

		tcpOptions.enableKeepalive = true
		tcpOptions.keepaliveIdle = 2

		// Create parameters with custom TLS and TCP options.
		self.init(tls: NWParameters.tlsOptions(passcode: passcode), tcp: tcpOptions)

		// Enable using a peer-to-peer link.
		self.includePeerToPeer = true

		// Add command protocol
//		let gameOptions = NWProtocolFramer.Options(definition: GameProtocol.definition)
//		self.defaultProtocolStack.applicationProtocols.insert(gameOptions, at: 0)
	}
    
    // UDP connection parameters for data transport
    convenience init(udpWithPasscode passcode: String){
        
        self.init(dtls: NWParameters.tlsOptions(passcode: passcode), udp: NWProtocolUDP.Options())
        
        self.includePeerToPeer = true
        
        // Add data protocol
        
    }

	// Create TLS options using a passcode to derive a pre-shared key.
	private static func tlsOptions(passcode: String) -> NWProtocolTLS.Options {
		let tlsOptions = NWProtocolTLS.Options()

		let authenticationKey = SymmetricKey(data: passcode.data(using: .utf8)!)
		var authenticationCode = HMAC<SHA256>.authenticationCode(for: "Puppet".data(using: .utf8)!, using: authenticationKey)

		let authenticationDispatchData = withUnsafeBytes(of: &authenticationCode) { (ptr: UnsafeRawBufferPointer) in
			DispatchData(bytes: ptr)
		}

		sec_protocol_options_add_pre_shared_key(tlsOptions.securityProtocolOptions,
												authenticationDispatchData as __DispatchData,
												stringToDispatchData("Puppet")! as __DispatchData)
        sec_protocol_options_append_tls_ciphersuite(tlsOptions.securityProtocolOptions, .AES_128_GCM_SHA256)
		return tlsOptions
	}

	// Create a utility function to encode strings as pre-shared key data.
	private static func stringToDispatchData(_ string: String) -> DispatchData? {
		guard let stringData = string.data(using: .unicode) else {
			return nil
		}
		let dispatchData = withUnsafeBytes(of: stringData) { (ptr: UnsafeRawBufferPointer) in
			DispatchData(bytes: UnsafeRawBufferPointer(start: ptr.baseAddress, count: stringData.count))
		}
		return dispatchData
	}
}
