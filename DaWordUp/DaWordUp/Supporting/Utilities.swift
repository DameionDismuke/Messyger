//
//  Utilities.swift
//  DaWordUp
//
//  Created by Dameion on 1/25/23.
// STYLIN ON DEM CODES

import Foundation
import UIKit

class Utilities {

    static func styleTextField(_ textField : UITextField) {
        
        // The Bottom Line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 128/255, blue: 0/255, alpha: 1).cgColor
        
        //removing border on the text field
        textField.borderStyle = .none
        
        //the line to the text field
        textField.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button : UIButton) {
        
        // Filled rounded corner style
        button.layer.borderColor = UIColor.init(red: 255/255, green: 128/255, blue: 0/255, alpha: 1).cgColor
        button.layer.cornerRadius = 25.0
        button.layer.backgroundColor = UIColor.init(red: 255/255, green: 128/255, blue: 0/255, alpha: 1).cgColor
        button.tintColor = UIColor.black
        button.alpha = 0.6
        
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
        
    }
    
    

} 
