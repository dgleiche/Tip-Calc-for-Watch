//
//  PeopleInterfaceController.swift
//  Tip Calc for Watch
//
//  Created by Dylan on 7/5/15.
//  Copyright (c) 2015 DIG Productions. All rights reserved.
//

import WatchKit
import Foundation

class PeopleInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var peopleLabel: WKInterfaceLabel!
    
    var people = ""
    
    var changed = false
    
    var originalPeople = "1"
    
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
    
    @IBAction func back() {
        let peopleChars = count(people)
        
        //Make sure it isn't empty
        if (peopleChars > 0) {
            //Pop off last digit
            people = people.substringToIndex(advance(people.startIndex, peopleChars-1))
            
            formatPeople()
        } else {
            //Make the string empty
            peopleLabel.setText("")
        }
    }
    
    @IBAction func confirm() {
        //Make sure there's a person
        if (people as NSString).integerValue < 1 {
            people = "1"
        }
        
        //Send dollar amnt back as a double
        self.delegate?.didChangeNumPeople((changed) ? (people as NSString).integerValue : (originalPeople as NSString).integerValue)
        
        self.dismissController()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.delegate = context as? InterfaceController
        
        if let people = self.delegate?.getNumPeople() {
            
            //Format correctly
            (people == 1) ? peopleLabel.setText("\(people) Person") : peopleLabel.setText("\(people) People")
            
            changed = false
            originalPeople = "\(people)"
        }
    }
    
    private func addDigit(digit: String) {
        changed = true
        people = people.stringByAppendingString(digit)
        
        formatPeople()
    }
    
    func formatPeople() {
        //Make sure there is a "person"
        if (people as NSString).integerValue < 1 && people != "" {
            people = "1"
        }
        
        //Format correctly
        if people == "" {
            peopleLabel.setText("1 Person")
        } else {
            (people == "1") ? peopleLabel.setText(people + " Person") : peopleLabel.setText(people + " People")
        }
    }

}