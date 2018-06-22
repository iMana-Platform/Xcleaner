//
//  EnabledCellView.swift
//  Xcleaner
//
//  Created by kingcos on 2018/6/22.
//  Copyright © 2018 kingcos. All rights reserved.
//

import Cocoa

class EnabledCellView: NSTableCellView {

    @IBOutlet weak var enabledButton: NSButton!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func clickOnEnabledButton(_ sender: NSButton) {
        
    }
}
