//
//  StatusMenuController.swift
//  Xcleaner
//
//  Created by kingcos on 2018/6/21.
//  Copyright © 2018 kingcos. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        setupStatusItem()
    }

    
}

// MARK: IBAction
extension StatusMenuController {
    @IBAction func clickOnAbout(_ sender: NSMenuItem) {
        guard let url = URL.init(string: "https://github.com/kingcos") else {
            fatalError()
        }
        
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func clickOnQuit(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}

extension StatusMenuController {
    func setupStatusItem() {
        statusItem.menu = statusMenu
        statusItem.title = "Xcleaner"
    }
    
    
}
