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
    @IBOutlet var testTwoPlayersButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = DesignPreset()
        design.buttonsSetUp(button: onePlayerButton)
        design.buttonsSetUp(button: twoPlayersButton)
        design.buttonsSetUp(button: testTwoPlayersButton)
        design.buttonTextSetup(button: onePlayerButton, text: "One Player")
        design.buttonTextSetup(button: twoPlayersButton, text: "Two Players")
        design.buttonTextSetup(button: testTwoPlayersButton, text: "Custom modes")
        
    }
}


