//
//  PreferencesWindowController.swift
//  Xcleaner
//
//  Created by kingcos on 2018/6/21.
//  Copyright © 2018 kingcos. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController {
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "PreferencesWindowController")
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.center()
        window?.makeKeyAndOrderFront(nil)
        
        NSApp.activate(ignoringOtherApps: true)
    }
    
    
}

// MARK: IBAction
extension PreferencesWindowController {
    @IBAction func clickOnSelect(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.showsHiddenFiles = true
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        
        openPanel.beginSheetModal(for: window!) { response in
            guard response == NSApplication.ModalResponse.OK else {
                return
            }
            
            print(openPanel.url?.absoluteString)
        }
    }
}
