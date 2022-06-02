//
//  ViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 01.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var onePlayerButton: UIButton!
    @IBOutlet var twoPlayersButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsSetUp(button: onePlayerButton, text: "One Player")
        buttonsSetUp(button: twoPlayersButton, text: "Two Players")
        
    }

    func buttonsSetUp(button: UIButton, text: String) {
        
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 15.0
        
        //onePlayerButton.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        button.setTitle(text, for: UIControl.State.normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 0.0, alpha: borderAlpha).cgColor
        button.layer.cornerRadius = cornerRadius
    }
    
    
    
}


