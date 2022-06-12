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

    var playerChoices: [Box] = []
    var computerChoices: [Box] = []
    var tapsAllowed = true
    var firstStands: String = ""
    var player: String = "X"
    var ai: String = "O"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = DesignPreset()
        design.labelSetUp(label: winLabel)
        winLabel.isHidden = true
        
        design.buttonsSetUp(button: exitButton)
        design.buttonsSetUp(button: resetButton)
        design.buttonTextSetup(button: resetButton, text: "Restart?")
        
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

        whoWillGoFirst()
        
    }
    
    @IBAction func exitButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func resetButtonPressed() {
        resetGame()
        whoWillGoFirst()
    }
    // randomly find the box to take
    func rollFirstStep() {
        let bestVariants: [Box] = [.one, .three, .five, .seven, .nine]
        let random = Int.random(in: 0 ..< bestVariants.count)
        let box = getBox(for: bestVariants[random].rawValue)
        makeChoiceComputer(box)
        tapsAllowed = true
    }
    // randomly decide who will be X player
    func whoWillGoFirst() {
        let firstStep = Int.random(in: 1...2)
        if firstStep == 1 {
            ai = "X"
            player = "O"
            tapsAllowed = false
            rollFirstStep()
        }
        else {
            ai = "O"
            player = "X"
        }
    }

    // function to recognize the tap on Images and exact Image that was tapped
    func makeTap(on image: UIImageView, index box: Box) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:))) // creating gestureRecognizer
        tap.name = box.rawValue
        image.isUserInteractionEnabled = true // user moves are not ignored
        image.addGestureRecognizer(tap) // connecting gestureRecognizer to the image
    }

    // action for the box and for ai right after it
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
        let selectedBox = getBox(for: sender.name ?? "")
        guard selectedBox.image == nil else { return }
        if tapsAllowed == true {
            makeChoiceHuman(selectedBox)
            
            }
        if tapsAllowed == true {
            tapsAllowed = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.computerPlay()
            }
        }
    }
    
    // find all empty boxes
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
        
        makeChoiceComputer(bestMove(userBoxes: playerChoices, compBoxes: computerChoices, emptySpaces: availableSpaces))
        tapsAllowed = true
    }
    
    // put a figure inside the chosen box
    func makeChoiceHuman(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }
        if player == "X" {
            selectedBox.image = UIImage(named: "jesus_killer_alpha")
        }
        else {
            selectedBox.image = UIImage(named: "circle_alpha")
        }
        
        for name in Box.allCases {
            let box = getBox(for: name.rawValue)
            if box == selectedBox {
                playerChoices.append(name)
            }
        }
        checkIfWin()
    }
    
    // put a figure inside the chosen box
    func makeChoiceComputer(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }
        if ai == "O" {
            selectedBox.image = UIImage(named: "circle_alpha")
        }
        else {
            selectedBox.image = UIImage(named: "jesus_killer_alpha")
        }
        
        for name in Box.allCases {
            let box = getBox(for: name.rawValue)
            if box == selectedBox {
                computerChoices.append(name)
            }
        }
        checkIfWin()
    }

    //find the best move from empty spaces
    func bestMove(userBoxes: [Box], compBoxes: [Box], emptySpaces: [UIImageView]) -> UIImageView {
        var bestScore = -1000
        let randIndex = Int.random(in: 0 ..< emptySpaces.count)
        let human = userBoxes
        var computer = compBoxes
        var move: Box = .one
        for i in Box.allCases {
            if human.contains(i) || computer.contains(i) {
                continue
            }
            else {
                computer.insert(i, at: 0)
                let score = miniMax(userBoxes: human, compBoxes: computer, depth: 1, isMaximizing: false)
                computer.remove(at: 0)
                if score > bestScore {
                    bestScore = score
                    move = i
                }
            }
        }
        
        for name in Box.allCases {
            let box = getBox(for: name.rawValue)
            if name == move {
                return box
            }
        }
        return(emptySpaces[randIndex])
    }
    
    // calculate the best move fo ai
    func miniMax(userBoxes: [Box], compBoxes: [Box], depth: Int, isMaximizing: Bool) -> Int {
        var human = userBoxes
        var computer = compBoxes
        let result = checkWinner(user: human, computer: computer)
        if result != "none" {
            if result == player {
                return -10
            }
            else if result == ai {
                return 10
            }
            else if result == "Tie" {
                return 0
            }
        }
        if isMaximizing == true {
            var bestScore = -10000
            for i in Box.allCases {
                if human.contains(i) || computer.contains(i) {
                    continue
                }
                else {
                    computer.insert(i, at: 0)
                    let score = miniMax(userBoxes: human, compBoxes: computer, depth: depth + 1, isMaximizing: false)
                    computer.remove(at: 0)
                    bestScore = max(score, bestScore)
                }
            }
            return bestScore
        }
        else {
            var bestScore = 10000
            for i in Box.allCases {
                if computer.contains(i) || human.contains(i) {
                    continue
                }
                else {
                    human.insert(i, at: 0)
                    let score = miniMax(userBoxes: human, compBoxes: computer, depth: depth + 1, isMaximizing: true)
                    human.remove(at: 0)
                    bestScore = min(bestScore, score)
                }
            }
            return bestScore
        }
    }
    
    // return result of the artificial game to the MiniMax
    func checkWinner(user combinationUser: [Box], computer combinationComputer: [Box]) -> String {
        let result = "none"
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
            let combinationMatchComputer = combinationComputer.filter { match.contains($0) }.count
            let combinationMatchUser = combinationUser.filter { match.contains ($0) }.count
            
            if combinationMatchComputer == match.count {
                return ai
            }
            else if combinationMatchUser == match.count {
                return player
            }
            else if combinationUser.count + combinationComputer.count == 9 {
                for i in correct {
                    let combinationMatchCPV2 = combinationComputer.filter { i.contains($0) }.count
                    let combinationMatchUSV2 = combinationUser.filter { i.contains($0) }.count
                    
                    if combinationMatchCPV2 == i.count {
                        return ai
                    }
                    else if combinationMatchUSV2 == i.count {
                        return player
                    }
                    else if i == [.three, .five, .seven] && combinationMatchCPV2 != match.count && combinationMatchUSV2 != i.count {
                        return "Tie"
                    }
                }
            }
        }
        return result
    }
    
    // check for a winning combination
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
            let firstUserMatch = playerChoices.filter { match.contains($0) }.count
            let computerMatch = computerChoices.filter { match.contains($0) }.count

            if firstUserMatch == match.count {
                tapsAllowed = false
                resetButton.isHidden = false
                winLabel.text = "\(player) Wins!"
                winLabel.isHidden = false
                break
            }
            else if computerMatch == match.count {
                tapsAllowed = false
                resetButton.isHidden = false
                winLabel.text = "\(ai) Wins!"
                winLabel.isHidden = false
                break
            }
            else if playerChoices.count + computerChoices.count == 9 {
                for i in correct {
                    let firstUserMatchV2 = playerChoices.filter { i.contains($0) }.count
                    let computerMatchV2 = computerChoices.filter { i.contains($0) }.count
                    
                    if firstUserMatchV2 == i.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winLabel.text = "\(player) Wins!"
                        winLabel.isHidden = false
                        break
                    }
                    else if computerMatchV2 == match.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winLabel.text = "\(player) Wins!"
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
    
    // restart the game
    func resetGame() {
        tapsAllowed = true
        for name in Box.allCases {
            let box = getBox(for: name.rawValue)
            box.image = nil
        }
        playerChoices = []
        computerChoices = []
        resetButton.isHidden = true
        winLabel.isHidden = true
        winLabel.text = ""
    }

    // find the box by index
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

