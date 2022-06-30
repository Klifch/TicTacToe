//
//  5x5TwoPlayersViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 30.06.2022.
//

import UIKit

class _x5TwoPlayersViewController: UIViewController {

    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    @IBOutlet weak var box10: UIImageView!
    @IBOutlet weak var box11: UIImageView!
    @IBOutlet weak var box12: UIImageView!
    @IBOutlet weak var box13: UIImageView!
    @IBOutlet weak var box14: UIImageView!
    @IBOutlet weak var box15: UIImageView!
    @IBOutlet weak var box16: UIImageView!
    @IBOutlet weak var box17: UIImageView!
    @IBOutlet weak var box18: UIImageView!
    @IBOutlet weak var box19: UIImageView!
    @IBOutlet weak var box20: UIImageView!
    @IBOutlet weak var box21: UIImageView!
    @IBOutlet weak var box22: UIImageView!
    @IBOutlet weak var box23: UIImageView!
    @IBOutlet weak var box24: UIImageView!
    @IBOutlet weak var box25: UIImageView!
    
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var winnerLabel: UILabel!
    
    var lastValue = "O"
    var firstPlayerChoices: [Box25] = []
    var secondPlayerChoices: [Box25] = []
    var tapsAllowed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = DesignPreset()
        design.buttonsSetUp(button: exitButton)
        design.buttonsSetUp(button: resetButton)
        design.buttonTextSetup(button: resetButton, text: "Restart?")
        design.labelSetUp(label: winnerLabel)
        
        winnerLabel.isHidden = true
        resetButton.isHidden = true
        
        makeTap(on: box1, index: .one)
        makeTap(on: box2, index: .two)
        makeTap(on: box3, index: .three)
        makeTap(on: box4, index: .four)
        makeTap(on: box5, index: .five)
        makeTap(on: box6, index: .six)
        makeTap(on: box7, index: .seven)
        makeTap(on: box8, index: .eight)
        makeTap(on: box9, index: .nine)
        makeTap(on: box10, index: .ten)
        makeTap(on: box11, index: .eleven)
        makeTap(on: box12, index: .twelve)
        makeTap(on: box13, index: .thirteen)
        makeTap(on: box14, index: .fourteen)
        makeTap(on: box15, index: .fifteen)
        makeTap(on: box16, index: .sixteen)
        makeTap(on: box17, index: .seventeen)
        makeTap(on: box18, index: .eighteen)
        makeTap(on: box19, index: .nineteen)
        makeTap(on: box20, index: .twenty)
        makeTap(on: box21, index: .twentyOne)
        makeTap(on: box22, index: .twentyTwo)
        makeTap(on: box23, index: .twentyThree)
        makeTap(on: box24, index: .twentyFour)
        makeTap(on: box25, index: .twentyFive)
    }
    
    @IBAction func resetButtonPressed() {
        resetGame()
    }
    
    @IBAction func exitButtonPressed() {
        dismiss(animated: true)
    }
    // function to recognize the tap on Images and exact Image that was tapped
    func makeTap(on image: UIImageView, index box: Box25) {
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
    // set an image and check for a win combination
    func makeChoice(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }

        if lastValue == "O" {
            selectedBox.image = UIImage(named: "jesus_killer_alpha")

            for name in Box25.allCases {
                let box = getBox(for: name.rawValue)
                if box == selectedBox {
                    firstPlayerChoices.append(name)
                }
            }
            lastValue = "X"
            checkIfWin()
        } else {
            selectedBox.image = UIImage(named: "circle_alpha")

            for name in Box25.allCases {
                let box = getBox(for: name.rawValue)
                if box == selectedBox {
                    secondPlayerChoices.append(name)
                }
            }
            lastValue = "O"
            checkIfWin()
        }
    }
    // check for a winning combination
    func checkIfWin() {
        var correct = [[Box25]]()

        let firstRow: [Box25] = [.one, .two, .three, .four, .five]
        let secondRow: [Box25] = [.six, .seven, .eight, .nine, .ten]
        let thirdRow: [Box25] = [.eleven, .twelve, .thirteen, .fourteen, .fifteen]
        let fourthRow: [Box25] = [.sixteen, .seventeen, .eighteen, .nineteen, .twenty]
        let fifthRow: [Box25] = [.twentyOne, .twentyTwo, .twentyThree, .twentyFour, .twentyFive]

        let firstColumn: [Box25] = [.one, .six, .eleven, .sixteen, .twentyOne]
        let secondColumn: [Box25] = [.two, .seven, .twelve, .seventeen, .twentyTwo]
        let thirdColumn: [Box25] = [.three, .eight, .thirteen, .eighteen, .twentyThree]
        let fourthColumn: [Box25] = [.four, .nine, .fourteen, .nineteen, .twentyFour]
        let fifthColumn: [Box25] = [.five, .ten, .fifteen, .twenty, .twentyFive]

        let firsDiagonal: [Box25] = [.one, .seven, .thirteen, .nineteen, .twentyFive]
        let secondDiagonal: [Box25] = [.five, .nine, .thirteen, .seventeen, .twentyOne]

        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(fourthRow)
        correct.append(fifthRow)
        correct.append(firstColumn)
        correct.append(secondColumn)
        correct.append(thirdColumn)
        correct.append(fourthColumn)
        correct.append(fifthColumn)
        correct.append(firsDiagonal)
        correct.append(secondDiagonal)

        for match in correct {
            let firstUserMatch = firstPlayerChoices.filter { match.contains($0) }.count
            let secondUserMatch = secondPlayerChoices.filter { match.contains($0) }.count

            if firstUserMatch == match.count {
                tapsAllowed = false
                resetButton.isHidden = false
                winnerLabel.text = "X Wins!"
                winnerLabel.isHidden = false
                break
            }
            else if secondUserMatch == match.count {
                tapsAllowed = false
                resetButton.isHidden = false
                winnerLabel.text = "O Wins!"
                winnerLabel.isHidden = false
                break
            }
            else if firstPlayerChoices.count + secondPlayerChoices.count == 25 {
                for i in correct {
                    let firstUserMatchV2 = firstPlayerChoices.filter { i.contains($0) }.count
                    let secondUserMatchV2 = secondPlayerChoices.filter { i.contains($0) }.count
                    
                    if firstUserMatchV2 == i.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winnerLabel.text = "X Wins!"
                        winnerLabel.isHidden = false
                        break
                    }
                    else if secondUserMatchV2 == match.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winnerLabel.text = "O Wins!"
                        winnerLabel.isHidden = false
                        break
                    }
                    else if i == [.five, .nine, .thirteen, .seventeen, .twentyOne] && firstUserMatchV2 != i.count && secondUserMatchV2 != match.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winnerLabel.text = "Tie!"
                        winnerLabel.isHidden = false
                        break
                    }
                }
            }
        }

    }
    // reset the game
    func resetGame() {
        tapsAllowed = true
        for name in Box25.allCases {
            let box = getBox(for: name.rawValue)
            box.image = nil
        }
        lastValue = "O"
        firstPlayerChoices = []
        secondPlayerChoices = []
        resetButton.isHidden = true
        winnerLabel.isHidden = true
        winnerLabel.text = ""
    }
    
    func getBox(for name: String) -> UIImageView {
        let box = Box25(rawValue: name) ?? .one

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
        case .ten:
            return box10
        case .eleven:
            return box11
        case .twelve:
            return box12
        case .thirteen:
            return box13
        case .fourteen:
            return box14
        case .fifteen:
            return box15
        case .sixteen:
            return box16
        case .seventeen:
            return box17
        case .eighteen:
            return box18
        case .nineteen:
            return box19
        case .twenty:
            return box20
        case .twentyOne:
            return box21
        case .twentyTwo:
            return box22
        case .twentyThree:
            return box23
        case .twentyFour:
            return box24
        case .twentyFive:
            return box25
        }
    }


}

enum Box25: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twentyOne, twentyTwo, twentyThree, twentyFour, twentyFive
}
