//
//  MainViewController.swift
//  perception
//
//  Created by Hanzhang Song on 6/20/21.
//  Copyright © 2021 Hanzhang Song. All rights reserved.
//

import UIKit
import CoreBluetooth

class MainViewController: UIViewController, CBPeripheralManagerDelegate {
    
    let ppInitBtn = UIButton()
    let ppAddServiceBtn = UIButton()
    let ppAdvertisingBtn = UIButton()
    var peripheralManager:CBPeripheralManager? = nil
    let characterUUID = CBUUID(string: "99153E9F-CD59-42A4-BC90-063E6D4D841D")
    let serviceUUID = CBUUID(string: "880B85FD-2CD7-43CC-89A4-81E8DCEFE1EC")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupButtons()
    }
    

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print(peripheral.state.rawValue)
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print(error)
    }
    
    func updateButtonStyle(button: UIButton, text:String) {
        button.backgroundColor = .gray
        button.setTitle(text, for: UIControl.State.normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.frame = CGRect(x: 0, y: 0, width:300, height: 50)
    }
    
    func setupButtons() {
        updateButtonStyle(button: ppInitBtn, text: "init bluetooth object")
        ppInitBtn.center = CGPoint(x: self.view.center.x, y: 100)
        ppInitBtn.addTarget(self, action: #selector(onSetupBtnClicked), for: .touchUpInside)
        self.view.addSubview(ppInitBtn)
        
        updateButtonStyle(button: ppAddServiceBtn, text: "add service")
        ppAddServiceBtn.center = CGPoint(x: self.view.center.x, y: ppInitBtn.center.y + 50)
        ppAddServiceBtn.addTarget(self, action: #selector(onAddServiceBtnClicked), for: .touchUpInside)
        self.view.addSubview(ppAddServiceBtn)
        
        updateButtonStyle(button: ppAdvertisingBtn, text: "start advertising")
        ppAdvertisingBtn.center = CGPoint(x: self.view.center.x, y: ppAddServiceBtn.center.y + 50)
        ppAdvertisingBtn.addTarget(self, action: #selector(onAdvertisingBtnClicked), for: .touchUpInside)
        self.view.addSubview(ppAdvertisingBtn)
    }
    
    func setupBlueTooth() {
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        print(#function)
    }
    
    func addService() {
        let character = CBMutableCharacteristic(type: characterUUID, properties: .read, value: nil, permissions: .readable)
        let service = CBMutableService(type: serviceUUID, primary: true)
        service.characteristics = [character]
        peripheralManager?.add(service)
        print(#function)
    }
    
    func startAdversing() {
        peripheralManager?.startAdvertising([
            CBAdvertisementDataServiceUUIDsKey: [serviceUUID],
            CBAdvertisementDataLocalNameKey: "Puppet Service"
        ])
        print(#function)
    }
    
    @objc func onSetupBtnClicked(_:Any) {
        setupBlueTooth()
    }
    
    @objc func onAddServiceBtnClicked(_:Any) {
        addService()
    }
    
    @objc func onAdvertisingBtnClicked(_:Any) {
        startAdversing()
    }
}
