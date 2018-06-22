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
        return .PreferencesWindowController
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.center()
        window?.makeKeyAndOrderFront(nil)
        
        NSApp.activate(ignoringOtherApps: true)
        
        tableView.register(NSNib.init(nibNamed: .EnabledCellView,
                                      bundle: nil),
                           forIdentifier: .EnabledCellID)
        
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
                let path = Path.init(directory: directory, size: 1000000.99, isEnabled: false)
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
    func tableView(_ tableView: NSTableView,
                   viewFor tableColumn: NSTableColumn?,
                   row: Int) -> NSView? {
        switch tableColumn {
        case tableView.tableColumns[0]:
            if let cell = tableView.makeView(withIdentifier: .PathCellID,
                                             owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = pathItems[row].directory
                return cell
            }
        case tableView.tableColumns[1]:
            if let cell = tableView.makeView(withIdentifier: .SizeCellID,
                                             owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = "\(pathItems[row].size)"
                return cell
            }
        case tableView.tableColumns[2]:
            if let cell = tableView.makeView(withIdentifier: .EnabledCellID,
                                             owner: nil) as? EnabledCellView {
                cell.enabledButton.state = NSControl.StateValue(rawValue: pathItems[row].isEnabled ? 1 : 0)
                return cell
            }
        default: break
        }
        
        return nil
        
    }
}
