//
//  AppDelegate.swift
//  stage
//
//  Created by Hanzhang Song on 3/9/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        window = NSWindow(contentRect: NSMakeRect(0, 0, 640, 480),
                          styleMask: [.titled, .miniaturizable, .closable, .fullSizeContentView],
                          backing: .buffered, defer: false)
        window.center()
        
        window.makeKeyAndOrderFront(nil)

        NSApplication.shared.mainWindow?.title = "Hello world"
        
        window.contentViewController = HomeViewController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

