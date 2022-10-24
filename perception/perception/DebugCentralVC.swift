//
//  DebugCentralVC.swift
//  perception
//
//  Created by 宋瀚章 on 2022/6/12.
//  Copyright © 2022 Hanzhang Song. All rights reserved.
//

import UIKit

class DebugCentralVC: UIViewController {
    var baby: BabyBluetooth? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // 搞个标题识别一下现在是central还是peripheral
        let titleView = UILabel.init()
        titleView.backgroundColor = .gray
        titleView.text = "Central"
        titleView.textColor = .white
        titleView.textAlignment = .center
        self.view.addSubview(titleView)
        titleView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(self.view.snp.top)
            make.width.equalTo(self.view.snp.width)
            make.left.equalTo(self.view.snp.left)
            make.height.equalTo(100)
        }
        
        // 扫描外设，过滤出我们关心的设备
        self.baby = BabyBluetooth.share()
        self.babyDelegate()
        self.baby?.setFilterOnConnectToPeripherals{ (peripheralName, advertisementData, RSSI) -> Bool in
            let localName = advertisementData?[CBAdvertisementDataLocalNameKey] ?? ""
            if ( localName as! String == "Blank" ) {
                return true
            }
            return false
        }
        self.baby?.scanForPeripherals()()?.enjoy()()
        
    }
    
    func babyDelegate() {
        self.baby?.setBlockOnDiscoverToPeripherals{(central, peripheral, advertismentData, RSSI) -> Void in
//            print("搜索到了设备:%s 设备信息:%s", peripheral?.name ?? "empty name", advertismentData?[CBAdvertisementDataLocalNameKey] ?? "")
        }
        
        self.baby?.setFilterOnDiscoverPeripherals{(peripheralName, advertisementData, RSSI) -> Bool in
            if (peripheralName?.count ?? 0 > 1) {
                return true
            }
            return false
        }
        
        self.baby?.setBlockOnConnected{ (central, peripheral) -> Void in
            print("connected !!!")
        }
        
        self.baby?.setBlockOnDiscoverCharacteristics{ (peripheral, service, error) -> Void in
            
        }
        
        self.baby?.setBlockOnReadValueForDescriptors{ (peripheral, descriptor, error) -> Void in
            print(descriptor?.characteristic?.uuid, descriptor?.characteristic?.value, descriptor?.value);
        }
    }
}
