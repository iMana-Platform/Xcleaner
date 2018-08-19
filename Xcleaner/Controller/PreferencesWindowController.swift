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
        
        setupTableView()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(calculatedDirectorySize(_:)),
                                               name: .CalculatedDirectorySize,
                                               object: nil)
    }
    
    @objc func calculatedDirectorySize(_ notification: NSNotification) {
//        tableView.cell
    }
    
    func setupTableView() {
        tableView.register(NSNib.init(nibNamed: .EnabledCellView,
                                      bundle: nil),
                           forIdentifier: .EnabledCellID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.enclosingScrollView?.horizontalScrollElasticity = .none
        tableView.enclosingScrollView?.hasHorizontalScroller = false
    }
    
    func calculatePathSize(_ path: Path, for column: Int, row: Int) {
//        let view = tableView.rowView(atRow: row, makeIfNecessary: false)
//        let v = view?.view(atColumn: column) as? NSTableCellView
//        v?.layer?.backgroundColor = NSColor.blue.cgColor
        
//        if cell = tableView.view(atColumn: column, row: row, makeIfNecessary: false) as  {
//            cell
//        }
    }
    
    func calculateSize(_ path: Path, for column: Int, row: Int, completion: @escaping (Path, Int, Int) -> Void) {
        completion(path, column, row)
//        let view = tableView.rowView(atRow: row, makeIfNecessary: false)
//        let v = view?.view(atColumn: column) as? NSTableCellView
//        v?.layer?.backgroundColor = NSColor.blue.cgColor
        
        //        if cell = tableView.view(atColumn: column, row: row, makeIfNecessary: false) as  {
        //            cell
        //        }
    }
    
    func startCalculate(_ path: Path, for column: Int, row: Int) {
        calculate {
            
        }
    }
    
    func calculate(completion: @escaping () -> Void) {
        
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
            
            if let url = openPanel.url?.absoluteString.replacingOccurrences(of: "file://", with: ""),
                let directory = url.removingPercentEncoding {
                let directories = self.pathItems.map { $0.directory }
                if directories.contains(directory) {
                    print("This directory: \(directory) is already added.")
                } else {
//                    DispatchQueue.global().async {
//                        let path = Path.init(directory: directory, isEnabled: false)
//                        self.pathItems.append(path)
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }
                    
//                    var path = Path.init(directory: directory, isEnabled: false)
//
//                    Path.calculate(path) { size in
//                        path.size = String(format: "%.2f", Double(size) / 1024 / 1024 / 1024)
////                        completion()
//                        self.tableView.reloadData()
//                    }
//
//                    self.pathItems.append(path)
//                    self.tableView.reloadData()
                    
                    let path = Path.init(directory: directory, isEnabled: false)
                    
                    self.pathItems.append(path)
                    self.tableView.reloadData()
                }
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
//                if pathItems[row].size == "Calculating..." {
////                    defer {
////                        // Calculate
////                        calculatePathSize(pathItems[row], for: 1, row: row)
////                    }
//////
//////                    cell.textField?.stringValue = "Calculating..."
////
//////                    calculateSize(pathItems[row], for: 1, row: row) { (path, column, row) in
//////                        let view = tableView.rowView(atRow: row, makeIfNecessary: false)
//////                        let v = view?.view(atColumn: column) as? NSTableCellView
//////                        v?.layer?.backgroundColor = NSColor.blue.cgColor
//////                    }
//////                    cell.textField?.stringValue = "webfrehj..."
////                    return cell
//                }
                
//                defer {
//                    if pathItems[row].size == "Calculating..." {
//                        // Calculate
//                        calculatePathSize(pathItems[row], for: 1, row: row)
//                    }
//                }
                
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
