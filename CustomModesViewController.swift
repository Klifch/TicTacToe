//
//  CustomModesViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 30.06.2022.
//

import UIKit

class CustomModesViewController: UIViewController {
    
    @IBOutlet var soloButton4x4: UIButton!
    @IBOutlet var duoButton4x4: UIButton!
    @IBOutlet var soloButton5x5: UIButton!
    @IBOutlet var duoButton5x5: UIButton!
    
    @IBOutlet var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = DesignPreset()
        design.buttonsSetUp(button: exitButton)
        design.buttonsSetUp(button: soloButton4x4)
        design.buttonsSetUp(button: soloButton5x5)
        design.buttonsSetUp(button: duoButton4x4)
        design.buttonsSetUp(button: duoButton5x5)
        
        design.buttonTextSetup(button: soloButton4x4, text: "Solo 4x4")
        design.buttonTextSetup(button: soloButton5x5, text: "Solo 5x5")
        design.buttonTextSetup(button: duoButton4x4, text: "Duo 4x4")
        design.buttonTextSetup(button: duoButton5x5, text: "Duo 5x5")
    }
    
    @IBAction func exitButtonPressed() {
        dismiss(animated: true)
    }
    
}
