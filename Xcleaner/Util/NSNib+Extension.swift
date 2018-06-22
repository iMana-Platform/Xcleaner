//
//  NSNib+Extension.swift
//  Xcleaner
//
//  Created by kingcos on 2018/6/22.
//  Copyright © 2018 kingcos. All rights reserved.
//

import Cocoa

extension NSNib.Name {
    static let PreferencesWindowController = NSNib.Name.init("PreferencesWindowController")
    static let EnabledCellView = NSNib.Name.init("EnabledCellView")
}

extension NSUserInterfaceItemIdentifier {
    static let PathCellID = NSUserInterfaceItemIdentifier.init("PathCellID")
    static let SizeCellID = NSUserInterfaceItemIdentifier.init("SizeCellID")
    static let EnabledCellID = NSUserInterfaceItemIdentifier.init("EnabledCellID")
}
