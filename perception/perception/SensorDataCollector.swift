//
//  SensorDataCollector.swift
//  perception
//
//  Created by Hanzhang Song on 9/22/21.
//  Copyright © 2021 Hanzhang Song. All rights reserved.
//

import CoreMotion


class SensorDataCollector: NSObject {
    let motionManager = CMMotionManager()
    var timer: Timer!
    
    func setup() {
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
    }
    
    func startMonitor() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(SensorDataCollector.update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            print(accelerometerData)
        }
        if let gyroData = motionManager.gyroData {
            print(gyroData)
        }
        if let magnetometerData = motionManager.magnetometerData {
            print(magnetometerData)
        }
        if let deviceMotion = motionManager.deviceMotion {
            print(deviceMotion)
        }
    }
}
