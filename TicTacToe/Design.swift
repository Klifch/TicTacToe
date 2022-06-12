//
//  Design.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 02.06.2022.
//

import Foundation
import UIKit

// class with design presets for the app
class DesignPreset {
    
    //design for button
    func buttonsSetUp(button: UIButton) {
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 15.0
        
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 0.0, alpha: borderAlpha).cgColor
        button.layer.cornerRadius = cornerRadius
    }
    
    // text for button
    func buttonTextSetup(button: UIButton, text: String) {
        button.setTitle(text, for: UIControl.State.normal)
    }
    
    // design for label
    func labelSetUp(label: UILabel) {
        let cornerRadius : CGFloat = 15.0
        
        label.layer.borderColor = UIColor(white: 0.0, alpha: 0.7).cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = cornerRadius
    }
}

