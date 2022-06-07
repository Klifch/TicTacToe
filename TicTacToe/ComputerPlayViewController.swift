//
//  ComputerPlayViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 06.06.2022.
//

import UIKit

class ComputerPlayViewController: UIViewController {
    
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var winLabel: UILabel!
    
    
    var lastValue = "O"
    var firstPlayerChoices: [Box] = []
    var computerChoices: [Box] = []
    var tapsAllowed = true
    var firstStands: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = DesignPreset()
        design.labelSetUp(label: winLabel)
        winLabel.isHidden = true
        
        design.buttonsSetUp(button: exitButton)
        design.buttonsSetUp(button: resetButton)
        design.buttonTextSetup(button: resetButton, text: "Restart?")
        
        resetButton.isHidden = true
        
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
    
    @IBAction func exitButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func resetButtonPressed() {
        resetGame()
    }
    
    func rollForRole() {
        let num = Int.random(in: 1...2)
        if num == 1 {
            firstStands = "player"
        }
        else if num == 2 {
            firstStands = "computer"
        }
    }
    
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
        if tapsAllowed == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.computerPlay()
            }
        }
    }
    
    func computerPlay() {
        var availableSpaces = [UIImageView]()
        var availableBoxes = [Box]()
        for name in Box.allCases {
            let box = getBox(for: name.rawValue)
            if box.image == nil {
                availableSpaces.append(box)
                availableBoxes.append(name)
            }
        }
        
        guard availableBoxes.count > 0 else { return }
        
        makeChoice(findBest(in: availableSpaces, type: availableBoxes))
    }
    
    func findBest(in spaces: [UIImageView], type boxes: [Box]) -> UIImageView {
        
        return returnSpace(in: spaces,
                           and: boxes,
                           for: computerChoices,
                           to: firstPlayerChoices)
    }
    
    func returnSpace(in emptySpaces: [UIImageView],
                     and emptyBoxes: [Box],
                     for compChoices: [Box],
                     to compare: [Box]) -> UIImageView {
        
        let testBoxes = emptyBoxes
        let randIndex = Int.random(in: 0 ..< emptySpaces.count)
        let bestScore = 0
        
        for oneBox in testBoxes {
            var cpuChoices = compChoices
            cpuChoices.append(oneBox)
            let result = check(for: cpuChoices)
            if result == 1 {
                for box in Box.allCases {
                    if box == oneBox {
                        let name = getBox(for: oneBox.rawValue)
                        return name
                    }
                }
            } else if result == 0 {
                continue
            } else {
                return emptySpaces[randIndex]
            }
            
        }
        return emptySpaces[randIndex]
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
        }
        else {
            selectedBox.image = UIImage(named: "circle_alpha")

            for name in Box.allCases {
                let box = getBox(for: name.rawValue)
                if box == selectedBox {
                    computerChoices.append(name)
                }
            }
            lastValue = "O"
            checkIfWin()
        }
    }

    func check(for combination: [Box]) -> Int {
        var result = 0
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
            let combinationMatch = combination.filter { match.contains($0) }.count

            if combinationMatch == match.count {
                result += 1
                return result
            }
            else if firstPlayerChoices.count + combination.count == 9 {
                for i in correct {
                    let combinationMatchV2 = combination.filter { i.contains($0) }.count
                    
                    if combinationMatchV2 == i.count {
                        result += 1
                        return result
                    } else if i == [.three, .five, .seven] && combinationMatchV2 != match.count {
                        result += 0
                        return result
                    }
                }
            }
        }
        return result
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
            let computerMatch = computerChoices.filter { match.contains($0) }.count

            if firstUserMatch == match.count {
                tapsAllowed = false
                resetButton.isHidden = false
                winLabel.text = "X Wins!"
                winLabel.isHidden = false
                break
            }
            else if computerMatch == match.count {
                tapsAllowed = false
                resetButton.isHidden = false
                winLabel.text = "O Wins!"
                winLabel.isHidden = false
                break
            }
            else if firstPlayerChoices.count + computerChoices.count == 9 {
                for i in correct {
                    let firstUserMatchV2 = firstPlayerChoices.filter { i.contains($0) }.count
                    let computerMatchV2 = computerChoices.filter { i.contains($0) }.count
                    
                    if firstUserMatchV2 == i.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winLabel.text = "X Wins!"
                        winLabel.isHidden = false
                        break
                    }
                    else if computerMatchV2 == match.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winLabel.text = "O Wins!"
                        winLabel.isHidden = false
                        break
                    }
                    else if i == [.three, .five, .seven] && firstUserMatchV2 != i.count && computerMatchV2 != match.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winLabel.text = "Tie!"
                        winLabel.isHidden = false
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
        computerChoices = []
        resetButton.isHidden = true
        winLabel.isHidden = true
        winLabel.text = ""
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

