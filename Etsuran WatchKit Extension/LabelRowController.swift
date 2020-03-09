//
//  LabelRowController.swift
//  Etsuran WatchKit Extension
//
//  Created by Hina Kormoczi on 2020. 03. 09..
//  Copyright © 2020. Hina Kormoczi. All rights reserved.
//

import WatchKit

class LabelRowController: NSObject {
    @IBOutlet var watchLabel: WKInterfaceLabel!
    
    var label: String? {
      didSet {
        watchLabel.setText(label)
      }
    }
}
