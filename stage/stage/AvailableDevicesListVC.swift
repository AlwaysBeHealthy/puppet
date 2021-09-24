//
//  AvailableDevicesListVC.swift
//  stage
//
//  Created by hzsong on 2021/8/1.
//  Copyright © 2021 Hanzhang Song. All rights reserved.
//

import Foundation
import Cocoa

class AvailableDevicesListVC: NSViewController {
    
    override func loadView() {
        self.view = DeviceListView(frame: CGRect(x: 0, y: 100, width: 800, height: 600))
    }
}

class DeviceListView: NSView {
    
    let container: NSStackView
    let serverSwitcher = NSButton(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
    let debugInfo = NSView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
    
    override init(frame frameRect: NSRect) {
        // configure the debug area
        debugInfo.wantsLayer = true
        debugInfo.layer?.backgroundColor = NSColor.white.cgColor
        
        container = NSStackView(views: [serverSwitcher, debugInfo])
        container.distribution = .fill
        container.spacing = 10
        container.orientation = .vertical
        
        super.init(frame: frameRect)
        
        self.frame = frame
        
        // configure the serverSwitcher button
        serverSwitcher.title = "OFF"
        serverSwitcher.wantsLayer = true
        serverSwitcher.layer?.backgroundColor = NSColor.red.cgColor
        serverSwitcher.setButtonType(.onOff)
        serverSwitcher.target = self
        serverSwitcher.action = #selector(serverSwitcherPressed(_:))
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        layer?.backgroundColor = NSColor.gray.cgColor
        
        addSubview(container)

        // align container from the left and right
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view": container]));

        var titleHeight: CGFloat = 0.0
        if let contentHeight = NSApplication.shared.mainWindow?.contentLayoutRect.height,
            let windowHeight = NSApplication.shared.mainWindow?.frame.height {
            titleHeight = windowHeight - contentHeight
        }
        
        // align container from the top and bottom
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-titleHeight-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: ["titleHeight": titleHeight + 20], views: ["view": container]));
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func serverSwitcherPressed(_ button: NSButton) {
        switch button.state {
        case .on:
            button.title = "ON"
            button.layer?.backgroundColor = NSColor.green.cgColor
        case .off:
            button.title = "OFF"
            button.layer?.backgroundColor = NSColor.red.cgColor
        default:
            break
        }
    }
}
