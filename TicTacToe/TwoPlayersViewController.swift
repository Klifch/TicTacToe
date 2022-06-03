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
        
        makeTap(on: box1, type: .one)
        makeTap(on: box2, type: .two)
        makeTap(on: box3, type: .three)
        makeTap(on: box4, type: .four)
        makeTap(on: box5, type: .five)
        makeTap(on: box6, type: .six)
        makeTap(on: box7, type: .seven)
        makeTap(on: box8, type: .eight)
        makeTap(on: box9, type: .nine)
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    // function to recognize the tap on Images and exact Image() that was tapped
    func makeTap(on image: UIImageView, type box: Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:))) // creating gestureRecognizer
        tap.name = box.rawValue
        image.isUserInteractionEnabled = true // user moves are not ignored
        image.addGestureRecognizer(tap) // connecting gestureRecognizer to the image
    }
    
    // action for the box
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
        let selectedBox = getBox(for: sender.name ?? "")
        selectedBox.image = UIImage(named: "jesus_killer_alpha")
    }
    
    func getBox(for name: String) -> UIImageView {
        let box = Box(rawValue: name) ?? .one
        
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
        }
    }
    
}

// all boxes for game figures
enum Box: String {
    case one, two, three, four, five, six, seven, eight, nine
}
