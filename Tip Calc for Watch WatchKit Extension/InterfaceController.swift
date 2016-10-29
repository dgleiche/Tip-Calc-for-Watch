//
//  InterfaceController.swift
//  Tip Calc for Watch WatchKit Extension
//
//  Created by Dylan on 7/2/15.
//  Copyright (c) 2015 DIG Productions. All rights reserved.
//

import WatchKit
import Foundation

protocol ModalBillDelegate {
    func didChangeBill(bill: Double)
    func getBill() -> Double
}

protocol ModalTipDelegate {
    func didChangePercent(percent: Double)
    func getPercent() -> Double
}

protocol ModalPeopleDelegate {
    func didChangeNumPeople(numPeople: Int)
    func getNumPeople() -> Int
}

class InterfaceController: WKInterfaceController, ModalBillDelegate, ModalTipDelegate, ModalPeopleDelegate {

    @IBOutlet weak var billLabel: WKInterfaceLabel!
    @IBOutlet weak var percentLabel: WKInterfaceLabel!
    @IBOutlet weak var tipLabel: WKInterfaceLabel!
    @IBOutlet weak var totalLabel: WKInterfaceLabel!
    @IBOutlet weak var peopleLabel: WKInterfaceLabel!
    
    //Values
    var bill = 0.00
    var percent = 20.0
    var people = 1
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        formatData()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        formatData()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
        if segueIdentifier == "changeBill" || segueIdentifier == "changePercent" || segueIdentifier == "changeNumber" {
            return self
        }
        
        return nil
    }
    
    func didChangeBill(bill: Double) {
        self.bill = bill
        
        formatData()
    }
    
    func getBill() -> Double {
        return bill
    }
    
    func didChangePercent(percent: Double) {
        self.percent = percent
        
        formatData()
    }
    
    func getPercent() -> Double {
        return percent
    }
    
    func didChangeNumPeople(numPeople: Int) {
        self.people = numPeople
        
        formatData()
    }
    
    func getNumPeople() -> Int {
        return people
    }
    
    private func formatData() {
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        billLabel.setText(formatter.stringFromNumber(bill))
        
        percentLabel.setText("\(percent)%:")
        
        let tip = ((percent/100)*bill)/Double(people)
        let tipStr = formatter.stringFromNumber(tip)!
        
        let smallFont = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        
        var tipLabelStr = NSMutableAttributedString()
        
        if people == 1 {
            tipLabelStr.setAttributedString(NSAttributedString(string: "\(tipStr)"))
        } else {
            tipLabelStr.setAttributedString(NSAttributedString(string: "\(tipStr)/person"))
            tipLabelStr.addAttribute(kCTFontAttributeName as String, value: smallFont, range: NSMakeRange(count(tipStr), 7))
        }
        
        tipLabel.setAttributedText(tipLabelStr)
        
        let total = (tip+bill)/Double(people)
        let totalStr = formatter.stringFromNumber(total)!

        var totalLabelStr = NSMutableAttributedString()
        
        if people == 1 {
            totalLabelStr.setAttributedString(NSAttributedString(string: "\(totalStr)"))
        } else {
            totalLabelStr.setAttributedString(NSAttributedString(string: "\(totalStr)/person"))
            totalLabelStr.addAttribute(kCTFontAttributeName as String, value: smallFont, range: NSMakeRange(count(totalStr), 7))
        }
        
        totalLabel.setAttributedText(totalLabelStr)
        
        (people == 1) ? peopleLabel.setText("") : peopleLabel.setText("\(people) People")
    }

}
