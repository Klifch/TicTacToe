//
//  TwoPlayersViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 01.06.2022.
//

import UIKit

class TwoPlayersViewController: UIViewController {
    
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var winnerLabel: UILabel!
    
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    
    var lastValue = "O"
    var firstPlayerChoices: [Box] = []
    var secondPlayerChoices: [Box] = []
    var tapsAllowed = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = DesignPreset()
        design.labelSetUp(label: winnerLabel)
        winnerLabel.isHidden = true
        
        design.buttonsSetUp(button: exitButton)
        design.buttonsSetUp(button: restartButton)
        design.buttonTextSetup(button: restartButton, text: "Restart?")
        
        restartButton.isHidden = true
        
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
    
    @IBAction func restartButtonPressed() {
        resetGame()
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
        if tapsAllowed == true {
            makeChoice(selectedBox)
        }
    }

    func makeChoice(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }

        if lastValue == "O" {
            selectedBox.image = UIImage(named: "jesus_killer_alpha")

            for name in Box.allCases {
                let box = getBox(for: name.rawValue)
                if box == selectedBox {
                    firstPlayerChoices.append(name)
                }
            }
            lastValue = "X"
            checkIfWin()
        } else {
            selectedBox.image = UIImage(named: "circle_alpha")

            for name in Box.allCases {
                let box = getBox(for: name.rawValue)
                if box == selectedBox {
                    secondPlayerChoices.append(name)
                }
            }
            lastValue = "O"
            checkIfWin()
        }
    }

    func checkIfWin() {
        var correct = [[Box]]()

        let firstRow: [Box] = [.one, .two, .three]
        let secondRow: [Box] = [.four, .five, .six]
        let thirdRow: [Box] = [.seven, .eight, .nine]

        let firstColumn: [Box] = [.one, .four, .seven]
        let secondColumn: [Box] = [.two, .five, .eight]
        let thirdColumn: [Box] = [.three, .six, .nine]

        let firsDiagonal: [Box] = [.one, .five, .nine]
        let secondDiagonal: [Box] = [.three, .five, .seven]

        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(firstColumn)
        correct.append(secondColumn)
        correct.append(thirdColumn)
        correct.append(firsDiagonal)
        correct.append(secondDiagonal)

        for match in correct {
            let firstUserMatch = firstPlayerChoices.filter { match.contains($0) }.count
            let secondUserMatch = secondPlayerChoices.filter { match.contains($0) }.count

            if firstUserMatch == match.count {
                tapsAllowed = false
                restartButton.isHidden = false
                winnerLabel.text = "X Wins!"
                winnerLabel.isHidden = false
                break
            }
            else if secondUserMatch == match.count {
                tapsAllowed = false
                restartButton.isHidden = false
                winnerLabel.text = "O Wins!"
                winnerLabel.isHidden = false
                break
            }
            else if firstPlayerChoices.count + secondPlayerChoices.count == 9 {
                for i in correct {
                    let firstUserMatchV2 = firstPlayerChoices.filter { i.contains($0) }.count
                    let secondUserMatchV2 = secondPlayerChoices.filter { i.contains($0) }.count
                    
                    if firstUserMatchV2 == i.count {
                        tapsAllowed = false
                        restartButton.isHidden = false
                        winnerLabel.text = "X Wins!"
                        winnerLabel.isHidden = false
                        break
                    }
                    else if secondUserMatchV2 == match.count {
                        tapsAllowed = false
                        restartButton.isHidden = false
                        winnerLabel.text = "O Wins!"
                        winnerLabel.isHidden = false
                        break
                    }
                    else if i == [.three, .five, .seven] && firstUserMatchV2 != i.count && secondUserMatchV2 != match.count {
                        tapsAllowed = false
                        restartButton.isHidden = false
                        winnerLabel.text = "Tie!"
                        winnerLabel.isHidden = false
                        break
                    }
                }
            }
        }

    }

    func resetGame() {
        tapsAllowed = true
        for name in Box.allCases {
            let box = getBox(for: name.rawValue)
            box.image = nil
        }
        lastValue = "O"
        firstPlayerChoices = []
        secondPlayerChoices = []
        restartButton.isHidden = true
        winnerLabel.isHidden = true
        winnerLabel.text = ""
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
enum Box: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
}
