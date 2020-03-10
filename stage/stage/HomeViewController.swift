//
//  HomeViewController.swift
//  stage
//
//  Created by Hanzhang Song on 3/9/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.
//

import Foundation
import Cocoa

class HomeViewController: NSViewController {
    
    override func loadView() {
        guard let mainWindowFrame = NSApplication.shared.mainWindow?.frame else {
            return
        }
        print(mainWindowFrame)
        self.view = HomeView(frame: mainWindowFrame)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            self.keyDown(with: event)
            return event
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.characters {
        case "w":
            NSLog("'w' is pressed")
            CGDisplayMoveCursorToPoint(CGMainDisplayID(), CGPoint(x: 100, y: 100))
            break
        default:
            break
        }
    }
}

class HomeView: NSView {
    
    let container: NSStackView
    let serverSwitcher = NSButton(title: "on/off", target: nil, action: nil)
    let debugInfo = NSView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
    
    override init(frame frameRect: NSRect) {
        
        serverSwitcher.setButtonType(.onOff)
        
        debugInfo.wantsLayer = true
        debugInfo.layer?.backgroundColor = NSColor.white.cgColor
        
        container = NSStackView(views: [serverSwitcher, debugInfo])
        container.distribution = .fill
        container.spacing = 10
        container.orientation = .vertical
        
        super.init(frame: frameRect)
        self.frame = frame
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
    
    
//    override func performKeyEquivalent(with event: NSEvent) -> Bool {
//        return true
//    }
}
