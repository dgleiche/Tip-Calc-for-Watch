//
//  BillInterfaceController.swift
//  Tip Calc for Watch
//
//  Created by Dylan on 7/5/15.
//  Copyright (c) 2015 DIG Productions. All rights reserved.
//

import WatchKit
import Foundation

class BillInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var billLabel: WKInterfaceLabel!
    
    var bill = ""
    
    var changed = false
    
    var originalBill = ""
    
    //For passing back data
    var delegate: InterfaceController?
    
    @IBAction func one() {
        addDigit("1")
    }
    
    @IBAction func two() {
        addDigit("2")
    }
    
    @IBAction func three() {
        addDigit("3")
    }
    
    @IBAction func four() {
        addDigit("4")
    }
    
    @IBAction func five() {
        addDigit("5")
    }
    
    @IBAction func six() {
        addDigit("6")
    }
    
    @IBAction func seven() {
        addDigit("7")
    }
    
    @IBAction func eight() {
        addDigit("8")
    }
    
    @IBAction func nine() {
        addDigit("9")
    }
    
    @IBAction func zero() {
        addDigit("0")
    }
    
    @IBAction func point() {
        addDigit(".")
    }
    
    @IBAction func back() {
        let billChars = count(bill)
        
        //Make sure bill isn't empty
        if (billChars > 0) {
            bill = bill.substringToIndex(advance(bill.startIndex, billChars-1))
            billLabel.setText(bill)
        } else {
            //Make the string empty
            billLabel.setText("")
        }
    }
    
    @IBAction func confirm() {
        //Send dollar amnt back as a double
        self.delegate?.didChangeBill((changed) ? (bill as NSString).doubleValue : (originalBill as NSString).doubleValue)
        
        self.dismissController()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.delegate = context as? InterfaceController
        
        if let bill = self.delegate?.getBill() {
            billLabel.setText("\(bill)")
            
            changed = false
            originalBill = "\(bill)"
        }
    }
    
    private func addDigit(digit: String) {
        changed = true
        bill = bill.stringByAppendingString(digit)
        
        billLabel.setText(bill)
    }
    
}