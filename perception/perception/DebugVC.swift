//
//  DebugVC.swift
//  perception
//
//  Created by 宋瀚章 on 2022/6/12.
//  Copyright © 2022 Hanzhang Song. All rights reserved.
//

import UIKit
import SnapKit

class DebugVC: UIViewController {
    var workAsCentralBtn: UIButton? = nil
    var workAsPeripheralBtn: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // 作为central角色进行工作
        workAsCentralBtn = UIButton.init()
        if let workAsCentralBtn = workAsCentralBtn {
            workAsCentralBtn.backgroundColor = .gray
            workAsCentralBtn.setTitle("作为Central工作", for: .normal)
            workAsCentralBtn.setTitleColor(.white, for: .normal)
            workAsCentralBtn.sizeToFit()
            self.view.addSubview(workAsCentralBtn)
            workAsCentralBtn.snp.makeConstraints{ (make) -> Void in
                make.height.equalTo(50)
                make.centerX.equalTo(self.view.snp.centerX)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            }
            workAsCentralBtn.addTarget(self, action: #selector(onChooseRoleBtnClicked), for: .touchUpInside)
        }
        
        // 作为peripheral角色进行工作
        workAsPeripheralBtn = UIButton.init()
        if let workAsPeripheralBtn = workAsPeripheralBtn {
            workAsPeripheralBtn.backgroundColor = .gray
            workAsPeripheralBtn.setTitle("作为Peripheral工作", for: .normal)
            workAsPeripheralBtn.setTitleColor(.white, for: .normal)
            workAsPeripheralBtn.sizeToFit()
            self.view.addSubview(workAsPeripheralBtn)
            workAsPeripheralBtn.snp.makeConstraints{ (make) -> Void in
                make.height.equalTo(50)
                make.centerX.equalTo(self.view.snp.centerX)
                make.top.equalTo(workAsCentralBtn!.snp.bottom).offset(10)
            }
            workAsPeripheralBtn.addTarget(self, action: #selector(onChooseRoleBtnClicked), for: .touchUpInside)
        }
    }
    
    @objc func onChooseRoleBtnClicked(btn: UIButton) {
        if (btn == workAsCentralBtn) {
            let debugCentralVC = DebugCentralVC.init()
            debugCentralVC.modalPresentationStyle = .fullScreen
            self.present(debugCentralVC, animated: true)
        }
    }
}
