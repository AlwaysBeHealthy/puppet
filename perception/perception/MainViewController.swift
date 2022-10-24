//
//  MainViewController.swift
//  perception
//
//  Created by Hanzhang Song on 6/20/21.
//  Copyright © 2021 Hanzhang Song. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // 在主VC中添加一个打开debug页的按钮，现阶段所有的功能全部实现在DebugVC中，
        // 不考虑任何用户操作逻辑，只考虑功能实现
        let debugVCBtn = UIButton.init(type: .system)
        self.view.addSubview(debugVCBtn)
        debugVCBtn.setTitle("进入调试页", for: .normal)
        debugVCBtn.sizeToFit()
        debugVCBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.center.equalTo(self.view.center)
        }
        debugVCBtn.addTarget(self, action: #selector(onDebugVCBtnClick), for: .touchUpInside)
    }
    
    @objc func onDebugVCBtnClick(_: Any) {
        let debugVC = DebugVC.init()
        debugVC.modalPresentationStyle = .fullScreen
        self.present(debugVC, animated: true)
    }
}
