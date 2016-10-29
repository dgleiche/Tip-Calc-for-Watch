//
//  TipInterfaceController.swift
//  Tip Calc for Watch
//
//  Created by Dylan on 7/5/15.
//  Copyright (c) 2015 DIG Productions. All rights reserved.
//

import WatchKit
import Foundation

class TipInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var tipLabel: WKInterfaceLabel!
    
    var tip = ""
    
    var changed = false
    
    var originalTip = ""
    
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
        let tipChars = count(tip)
        
        //Make sure it isn't empty
        if (tipChars > 0) {
            //Pop off last digit
            tip = tip.substringToIndex(advance(tip.startIndex, tipChars-1))
            tipLabel.setText(tip + "% Tip")
        } else {
            //Make the string empty
            tipLabel.setText("")
        }
    }
    
    @IBAction func confirm() {
        //Send dollar amnt back as a double
        self.delegate?.didChangePercent((changed) ? (tip as NSString).doubleValue : (originalTip as NSString).doubleValue)
        
        self.dismissController()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.delegate = context as? InterfaceController
        
        if let percent = self.delegate?.getPercent() {
            tipLabel.setText("\(percent)% Tip")
            
            changed = false
            originalTip = "\(percent)"
        }
    }
    
    private func addDigit(digit: String) {
        changed = true
        tip = tip.stringByAppendingString(digit)
        
        tipLabel.setText(tip + "% Tip")
    }
}