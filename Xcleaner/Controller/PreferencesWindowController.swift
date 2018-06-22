//
//  PreferencesWindowController.swift
//  Xcleaner
//
//  Created by kingcos on 2018/6/21.
//  Copyright © 2018 kingcos. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    var pathItems: [Path] = []
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "PreferencesWindowController")
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.center()
        window?.makeKeyAndOrderFront(nil)
        
        NSApp.activate(ignoringOtherApps: true)
        
        tableView.delegate = self
        tableView.dataSource = self
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
            
            if let directory = openPanel.url?.absoluteString {
                let path = Path.init(directory: directory, size: 1000.99, isEnabled: false)
                self.pathItems.append(path)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func clickOnAutoClean(_ sender: NSButton) {
        print(sender.state)
    }
    
    @IBAction func clickOnShowOnMenuBar(_ sender: NSButton) {
        print(sender.state)
    }
    
    @IBAction func clickOnAutoLaunch(_ sender: NSButton) {
        print(sender.state)
    }
}

extension PreferencesWindowController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return pathItems.count
    }
}

extension PreferencesWindowController: NSTableViewDelegate {
    enum CellIdentifier: String {
        case PathCellID
        case MaxCacheSizeCellID
        case EnabledCellID
    }
    
    func tableView(_ tableView: NSTableView,
                   viewFor tableColumn: NSTableColumn?,
                   row: Int) -> NSView? {
        let item = pathItems[row]
        
        var content = ""
        var cellID = ""
        
        switch tableColumn {
        case tableView.tableColumns[0]:
            content = item.directory
            cellID = CellIdentifier.PathCellID.rawValue
        case tableView.tableColumns[1]:
            content = "\(item.size)"
            cellID = CellIdentifier.MaxCacheSizeCellID.rawValue
        case tableView.tableColumns[2]:
//            content = item.isEnabled
            cellID = CellIdentifier.EnabledCellID.rawValue
        default: break
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellID),
                                         owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = content
            return cell
        }
        
        return nil
        
    }
}
