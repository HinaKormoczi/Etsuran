//
//  InterfaceController.swift
//  Etsuran WatchKit Extension
//
//  Created by Hina Kormoczi on 2020. 03. 09..
//  Copyright © 2020. Hina Kormoczi. All rights reserved.
//

import WatchKit
import Alamofire
import SwiftSoup

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var webViewGroup: WKInterfaceGroup!
    @IBOutlet weak var webViewTable: WKInterfaceTable!
    
    var texts : [String] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        configureLayout()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func configureLayout() {
        let webURL = "https://bbc.com/"
        requestSite(webURL) { result in
            self.showHTML(result)
            print(self.texts)
            self.webViewTable.setNumberOfRows(self.texts.count, withRowType: "LabelRow")

            for (index, labelText) in self.texts.enumerated() {
                let row = self.webViewTable.rowController(at: index) as! LabelRowController
                row.watchLabel.setText(labelText)
            }
        }
    }
    
    func requestSite(_ url: String, completionHandler: @escaping (String) -> Void) {
        let request = AF.request(url)
        request.response { (data) in
            if let safeData = data.data { completionHandler(String(decoding: safeData, as: UTF8.self)) }
        }
    }

    func showHTML(_ string: String){
        guard let doc: Document = try? SwiftSoup.parse(string) else { return }
        guard let elements = try? doc.getAllElements() else { return }
        for element in elements {
            for textNode in element.textNodes() {
                if textNode.text() != " " { texts.append(textNode.text()) }
            }
        }
    }
    
}
