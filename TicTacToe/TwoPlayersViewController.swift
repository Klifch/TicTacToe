//
//  TwoPlayersViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 01.06.2022.
//

import UIKit

class TwoPlayersViewController: UIViewController {
    
    @IBOutlet var exitButton: UIButton!
    
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = DesignPreset()
        design.buttonsSetUp(button: exitButton)
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
}

enum Box: String {
    case one, two, three, four, five, six, seven, eight, nine
}
