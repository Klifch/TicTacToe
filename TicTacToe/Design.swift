//
//  Design.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 02.06.2022.
//

import Foundation
import UIKit

class DesignPreset {
    
    func buttonsSetUp(button: UIButton) {
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 15.0
        
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 0.0, alpha: borderAlpha).cgColor
        button.layer.cornerRadius = cornerRadius
    }
    
    func buttonTextSetup(button: UIButton, text: String) {
        button.setTitle(text, for: UIControl.State.normal)
    }
    
    func labelSetUp(label: UILabel) {
        let cornerRadius : CGFloat = 15.0
        
        //label.backgroundColor = UIColor.clear
        label.layer.borderColor = UIColor(white: 0.0, alpha: 0.7).cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = cornerRadius
    }
}


//class Player {
//
//    struct Mode {
//
//        enum mode {
//            case single, multi
//        }
//
//    }
//}

class Mode {
    
    enum mode {
        case single, multi
    }
    
    let typ: mode
    
    init(typ: mode) {
        self.typ = typ
    }
    
    func foo() {
        if typ == .single {
            print("Works")
        }
        else if typ == .multi {
            print("WorksX2")
        }
    }
}

// example of class work, should be made from ViewDidLoad
//let first = Mode(typ: .multi)
//first.foo()
