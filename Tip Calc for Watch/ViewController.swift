//
//  ViewController.swift
//  Tip Calc for Watch
//
//  Created by Dylan on 7/2/15.
//  Copyright (c) 2015 DIG Productions. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    @IBOutlet weak var billLabel: UITextField!
    @IBOutlet weak var splitLabel: UITextField!
    @IBOutlet weak var tipLabel: UITextField!
    
    @IBOutlet weak var totalAmntLabel: UILabel!
    @IBOutlet weak var tipAmntLabel: UILabel!
    @IBOutlet weak var totalSplitAmntLabel: UILabel!
    @IBOutlet weak var tipSplitAmntLabel: UILabel!
    
    @IBOutlet weak var totalSplitText: UILabel!
    @IBOutlet weak var tipSplitText: UILabel!
    
    //Val vars
    var bill = 0.0
    var people = 1
    var tipPercent = 20.0
    
    //Vars for pickerViews
    var splitOptions: [String] = []
    var tipOptions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitOptions.append("1 Person")
        for index in 2...20 {
            splitOptions.append("\(index) People")
        }
        
        for index in 1...100 {
            tipOptions.append("\(index)%")
        }
        
        var splitPickerView = UIPickerView()
        var tipPickerView = UIPickerView()
        
        splitPickerView.delegate = self
        splitPickerView.tag = 0
        
        tipPickerView.delegate = self
        tipPickerView.tag = 1
        
        tipPickerView.selectRow(19, inComponent: 0, animated: true)
        
        let tapGR = UITapGestureRecognizer(target: self, action: "pickerViewTapped")
        
        self.view.addGestureRecognizer(tapGR)
        
        splitLabel.inputView = splitPickerView
        tipLabel.inputView = tipPickerView
        
        formatData()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            //Split picker view
            return splitOptions.count
        } else if pickerView.tag == 1 {
            //Tip picker view
            return tipOptions.count
        }
        
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0 {
            //Split picker view
            return splitOptions[row]
        } else if pickerView.tag == 1 {
            //Tip picker view
            return tipOptions[row]
        }
        
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            //Split picker view
            let newSplit = (splitOptions[row] as NSString).integerValue
            if people != newSplit {
                people = newSplit
                
                formatData()
            }
        } else if pickerView.tag == 1 {
            //Tip picker view
            let newTipPercent = (tipOptions[row] as NSString).doubleValue
            tipPercent = newTipPercent
            
            formatData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //Clear text field before beginning to edit
        if textField.tag == 0 {
            //Bill field
            textField.text = ""
            
        } else if textField.tag == 1 {
            //Split field
        } else if textField.tag == 2 {
            //Tip field
        }
        
        return true
    }
    
    func pickerViewTapped() {
        splitLabel.resignFirstResponder()
        tipLabel.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField.tag == 0 {
            //Bill field
            let val = textField.text
            
            let letters = NSCharacterSet.letterCharacterSet()
            let numbers = NSCharacterSet.decimalDigitCharacterSet()
            
            //If it contains letters or is blank, default to zero
            if let testLetters = val.rangeOfCharacterFromSet(letters) {
                bill = 0.0
            } else if let testNumbers = val.rangeOfCharacterFromSet(numbers) {
                bill = (val as NSString).doubleValue
            } else {
                bill = 0.0
            }
        } else if textField.tag == 1 {
            //Split field
        } else if textField.tag == 2 {
            //Tip field
        }
        
        formatData()
        
        return true
    }
    
    private func formatData() {
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        billLabel.text = "\(bill)"
        
        tipLabel.text = "\(tipPercent)%"
        
        let tip = ((tipPercent/100)*bill)
        let tipStr = formatter.stringFromNumber(tip)!
        
        tipAmntLabel.text = tipStr
        
        let total = tip + bill
        let totalStr = formatter.stringFromNumber(total)
        
        totalAmntLabel.text = totalStr
        
        var splitStr = NSMutableAttributedString()
        
        let mediumFont = UIFont(name: "Helvetica Neue", size: 30)!
        let smallFont = UIFont(name: "Helvetica Neue", size: 17)!
        
        if people == 1 {
            //Hide the splits
            tipSplitAmntLabel.text = ""
            tipSplitText.text = ""
            
            totalSplitAmntLabel.text = ""
            totalSplitText.text = ""
            
            splitStr.setAttributedString(NSAttributedString(string: "1 Person"))
            splitStr.addAttribute(kCTFontAttributeName as String, value: mediumFont, range: NSMakeRange(2, 6))
            
            splitLabel.attributedText = splitStr
        } else {
            //Show the split labels
            
            splitStr.setAttributedString(NSAttributedString(string: "\(people) People"))
            splitStr.addAttribute(kCTFontAttributeName as String, value: mediumFont, range: NSMakeRange(count("\(people)")+1, 6))
            
            splitLabel.attributedText = splitStr
            
            var tipSplitTxt = NSMutableAttributedString()
            
            tipSplitTxt.setAttributedString(NSAttributedString(string: "Tip/person"))
            tipSplitTxt.addAttribute(kCTFontAttributeName as String, value: smallFont, range: NSMakeRange(3, 7))
            
            tipSplitText.attributedText = tipSplitTxt
            
            var totalSplitTxt = NSMutableAttributedString()
            
            totalSplitTxt.setAttributedString(NSAttributedString(string: "Total/person"))
            totalSplitTxt.addAttribute(kCTFontAttributeName as String, value: smallFont, range: NSMakeRange(5, 7))
            
            totalSplitText.attributedText = totalSplitTxt
            
            let tipPerPerson = tip/Double(people)
            let tipPerPersonStr = formatter.stringFromNumber(tipPerPerson)
            
            tipSplitAmntLabel.text = tipPerPersonStr
            
            let totalPerPerson = total/Double(people)
            let totalPerPersonStr = formatter.stringFromNumber(totalPerPerson)
            
            totalSplitAmntLabel.text = totalPerPersonStr
        }
        
    }
}

