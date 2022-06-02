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
        
        let design = DesignPreset()
        design.buttonsSetUp(button: onePlayerButton)
        design.buttonsSetUp(button: twoPlayersButton)
        design.buttonTextSetup(button: onePlayerButton, text: "One Player")
        design.buttonTextSetup(button: twoPlayersButton, text: "Two Players")
        
    }
}


