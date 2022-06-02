//
//  TwoPlayersViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 01.06.2022.
//

import UIKit

class TwoPlayersViewController: UIViewController {
    
    @IBOutlet var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonsSetUp(button: exitButton)
    }
    
    func buttonsSetUp(button: UIButton) {
        
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 15.0
        
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 0.0, alpha: borderAlpha).cgColor
        button.layer.cornerRadius = cornerRadius
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    class Game {
        
    }
}

