//
//  Computer4x4ViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 24.06.2022.
//

import UIKit

class Computer4x4ViewController: UIViewController {

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
    
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    var playerChoices: [Box16] = []
    var computerChoices: [Box16] = []
    var tapsAllowed = true
    var firstStands: String = ""
    var player: String = "X"
    var ai: String = "O"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design = DesignPreset()
        design.buttonsSetUp(button: cancelButton)
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

        whoWillGoFirst()
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    
    }
    @IBAction func resetButtonPressed() {
        resetGame()
        whoWillGoFirst()
    }
    
    func rollFirstStep() {
        let bestVariants: [Box16] = [.one, .four, .six, .seven, .ten, .eleven, .thirteen, .sixteen]
        let random = Int.random(in: 0 ..< bestVariants.count)
        let box = getBox(for: bestVariants[random].rawValue)
        makeChoiceComputer(box)
        tapsAllowed = true
    }
    
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
    
    func makeTap(on image: UIImageView, index box: Box16) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:))) // creating gestureRecognizer
        tap.name = box.rawValue
        image.isUserInteractionEnabled = true // user moves are not ignored
        image.addGestureRecognizer(tap) // connecting gestureRecognizer to the image
    }
    
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
    
    func computerPlay() {
        var availableSpaces = [UIImageView]()
        var availableBoxes = [Box16]()
        for name in Box16.allCases {
            let box = getBox(for: name.rawValue)
            if box.image == nil {
                availableSpaces.append(box)
                availableBoxes.append(name)
            }
        }
        
        guard availableBoxes.count > 0 else { return }
        if availableBoxes.count >= 13 {
            makeChoiceComputer(availableSpaces[Int.random(in: 0 ..< availableSpaces.count)])
            tapsAllowed = true
        }
        else if availableBoxes.count < 13 && availableBoxes.count > 9 {
            makeChoiceComputer(calculate(computerBoxes: computerChoices, userBoxes: playerChoices, availableBoxes: availableBoxes))
            tapsAllowed = true
        }
        else if availableBoxes.count <= 9 {
            makeChoiceComputer(bestMove(userBoxes: playerChoices, compBoxes: computerChoices, emptySpaces: availableSpaces))
            tapsAllowed = true
        }
    }
    
    func makeChoiceHuman(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }
        if player == "X" {
            selectedBox.image = UIImage(named: "jesus_killer_alpha")
        }
        else {
            selectedBox.image = UIImage(named: "circle_alpha")
        }
        
        for name in Box16.allCases {
            let box = getBox(for: name.rawValue)
            if box == selectedBox {
                playerChoices.append(name)
            }
        }
        checkIfWin()
    }
    
    func makeChoiceComputer(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }
        if ai == "O" {
            selectedBox.image = UIImage(named: "circle_alpha")
        }
        else {
            selectedBox.image = UIImage(named: "jesus_killer_alpha")
        }
        
        for name in Box16.allCases {
            let box = getBox(for: name.rawValue)
            if box == selectedBox {
                computerChoices.append(name)
            }
        }
        checkIfWin()
    }
    
    func bestMove(userBoxes: [Box16], compBoxes: [Box16], emptySpaces: [UIImageView]) -> UIImageView {
        var bestScore = -1000
        let randIndex = Int.random(in: 0 ..< emptySpaces.count)
        let human = userBoxes
        var computer = compBoxes
        var move: Box16 = .one
        for i in Box16.allCases {
            if human.contains(i) || computer.contains(i) {
                continue
            }
            else {
                computer.insert(i, at: 0)
                let score = miniMax(userBoxes: human, compBoxes: computer, depth: 1, alpha: -1000, beta: 1000, isMaximizing: false)
                computer.remove(at: 0)
                if score > bestScore {
                    bestScore = score
                    move = i
                }
            }
        }
        
        for name in Box16.allCases {
            let box = getBox(for: name.rawValue)
            if name == move {
                return box
            }
        }
        return(emptySpaces[randIndex])
    }
    
    func miniMax(userBoxes: [Box16], compBoxes: [Box16], depth: Int, alpha: Int, beta: Int, isMaximizing: Bool) -> Int {
        var human = userBoxes
        var computer = compBoxes
        var tempAlpha = alpha
        var tempBeta = beta
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
            var bestScore = -1000
            for i in Box16.allCases {
                if human.contains(i) || computer.contains(i) {
                    continue
                }
                else {
                    computer.insert(i, at: 0)
                    let score = miniMax(userBoxes: human, compBoxes: computer, depth: depth + 1, alpha: tempAlpha, beta: tempBeta, isMaximizing: false)
                    computer.remove(at: 0)
                    bestScore = max(score, bestScore)
                    tempAlpha = max(tempAlpha, score)
                    if tempBeta <= tempAlpha {
                        break
                    }
                }
            }
            return bestScore
        }
        else {
            var bestScore = 1000
            for i in Box16.allCases {
                if computer.contains(i) || human.contains(i) {
                    continue
                }
                else {
                    human.insert(i, at: 0)
                    let score = miniMax(userBoxes: human, compBoxes: computer, depth: depth + 1, alpha: tempAlpha, beta: tempBeta, isMaximizing: true)
                    human.remove(at: 0)
                    bestScore = min(bestScore, score)
                    tempBeta = min(tempBeta, score)
                    if tempBeta <= tempAlpha {
                        break
                    }
                }
            }
            return bestScore
        }
    }
    
    func doMove(combinationComputer: [Box16], combinationUser: [Box16], availableBoxes: [Box16]) -> Box16 {
        var correct = [[Box16]]()
        
        let firstRow: [Box16] = [.one, .two, .three, .four]
        let secondRow: [Box16] = [.five, .six, .seven, .eight]
        let thirdRow: [Box16] = [.nine, .ten, .eleven, .twelve]
        let fourthRow: [Box16] = [.thirteen, .fourteen, .fifteen, .sixteen]

        let firstColumn: [Box16] = [.one, .five, .nine, .thirteen]
        let secondColumn: [Box16] = [.two, .six, .ten, .fourteen]
        let thirdColumn: [Box16] = [.three, .seven, .eleven, .fifteen]
        let fourthColumn: [Box16] = [.four, .eight, .twelve, .sixteen]

        let firsDiagonal: [Box16] = [.one, .six, .eleven, .sixteen]
        let secondDiagonal: [Box16] = [.four, .seven, .ten, .thirteen]
        
        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(fourthRow)
        correct.append(firstColumn)
        correct.append(secondColumn)
        correct.append(thirdColumn)
        correct.append(fourthColumn)
        correct.append(firsDiagonal)
        correct.append(secondDiagonal)
        
        var bestMove: Box16 = availableBoxes[Int.random(in: 0 ..< availableBoxes.count)]
        var bestMatch: [Box16] = []
        var bestCount: Int = 0
//        var bestEnemy: [Box16] = []
        
        for match in correct {
            let combinationMatchComputer = combinationComputer.filter { match.contains($0) }
            let combinationMatchUser = combinationUser.filter { match.contains($0) }
            if combinationMatchComputer.count >= 1 {
                if combinationMatchComputer.count > bestCount {
                    bestMatch = match
                    bestCount = combinationMatchComputer.count
                }
            }
            if combinationMatchUser.count == 3 {
                for i in match {
                    if combinationMatchUser.contains(i) || combinationMatchComputer.contains(i) {
                        continue
                    }
                    else {
                        return i
                    }
                }
            }
        }
        for i in bestMatch {
            if combinationUser.contains(i) || combinationComputer.contains(i) {
                continue
            }
            else {
                bestMove = i
                return bestMove
            }
        }
        return bestMove
    }
    
    func calculate(computerBoxes: [Box16], userBoxes: [Box16], availableBoxes: [Box16]) -> UIImageView {
        var safe = getBox(for: availableBoxes[Int.random(in: 0 ..< availableBoxes.count)].rawValue)
        let bestMove = doMove(combinationComputer: computerBoxes, combinationUser: userBoxes, availableBoxes: availableBoxes)
        for i in Box16.allCases {
            let name = getBox(for: i.rawValue)
            if i == bestMove {
                safe = name
                return safe
            }
        }
        return safe
    }
    
    func checkWinner(user combinationUser: [Box16], computer combinationComputer: [Box16]) -> String {
        let result = "none"
        var correct = [[Box16]]()

        let firstRow: [Box16] = [.one, .two, .three, .four]
        let secondRow: [Box16] = [.five, .six, .seven, .eight]
        let thirdRow: [Box16] = [.nine, .ten, .eleven, .twelve]
        let fourthRow: [Box16] = [.thirteen, .fourteen, .fifteen, .sixteen]

        let firstColumn: [Box16] = [.one, .five, .nine, .thirteen]
        let secondColumn: [Box16] = [.two, .six, .ten, .fourteen]
        let thirdColumn: [Box16] = [.three, .seven, .eleven, .fifteen]
        let fourthColumn: [Box16] = [.four, .eight, .twelve, .sixteen]

        let firsDiagonal: [Box16] = [.one, .six, .eleven, .sixteen]
        let secondDiagonal: [Box16] = [.four, .seven, .ten, .thirteen]

        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(fourthRow)
        correct.append(firstColumn)
        correct.append(secondColumn)
        correct.append(thirdColumn)
        correct.append(fourthColumn)
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
            else if combinationUser.count + combinationComputer.count == 16 {
                for i in correct {
                    let combinationMatchCPV2 = combinationComputer.filter { i.contains($0) }.count
                    let combinationMatchUSV2 = combinationUser.filter { i.contains($0) }.count

                    if combinationMatchCPV2 == i.count {
                        return ai
                    }
                    else if combinationMatchUSV2 == i.count {
                        return player
                    }
                    if i == [.four, .seven, .ten, .thirteen] && combinationMatchCPV2 != i.count && combinationMatchUSV2 != i.count {
                        return "Tie"
                    }
                }
            }
        }
        return result
    }
    
    func checkIfWin() {
        var correct = [[Box16]]()

        let firstRow: [Box16] = [.one, .two, .three, .four]
        let secondRow: [Box16] = [.five, .six, .seven, .eight]
        let thirdRow: [Box16] = [.nine, .ten, .eleven, .twelve]
        let fourthRow: [Box16] = [.thirteen, .fourteen, .fifteen, .sixteen]

        let firstColumn: [Box16] = [.one, .five, .nine, .thirteen]
        let secondColumn: [Box16] = [.two, .six, .ten, .fourteen]
        let thirdColumn: [Box16] = [.three, .seven, .eleven, .fifteen]
        let fourthColumn: [Box16] = [.four, .eight, .twelve, .sixteen]

        let firsDiagonal: [Box16] = [.one, .six, .eleven, .sixteen]
        let secondDiagonal: [Box16] = [.four, .seven, .ten, .thirteen]

        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(fourthRow)
        correct.append(firstColumn)
        correct.append(secondColumn)
        correct.append(thirdColumn)
        correct.append(fourthColumn)
        correct.append(firsDiagonal)
        correct.append(secondDiagonal)

        for match in correct {
            let firstUserMatch = playerChoices.filter { match.contains($0) }.count
            let computerMatch = computerChoices.filter { match.contains($0) }.count

            if firstUserMatch == match.count {
                tapsAllowed = false
                resetButton.isHidden = false
                winnerLabel.text = "\(player) Wins!"
                winnerLabel.isHidden = false
                break
            }
            else if computerMatch == match.count {
                tapsAllowed = false
                resetButton.isHidden = false
                winnerLabel.text = "\(ai) Wins!"
                winnerLabel.isHidden = false
                break
            }
            else if playerChoices.count + computerChoices.count == 16 {
                for i in correct {
                    let firstUserMatchV2 = playerChoices.filter { i.contains($0) }.count
                    let computerMatchV2 = computerChoices.filter { i.contains($0) }.count
                    
                    if firstUserMatchV2 == i.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winnerLabel.text = "\(player) Wins!"
                        winnerLabel.isHidden = false
                        break
                    }
                    else if computerMatchV2 == match.count {
                        tapsAllowed = false
                        resetButton.isHidden = false
                        winnerLabel.text = "\(ai) Wins!"
                        winnerLabel.isHidden = false
                        break
                    }
                    else if i == [.four, .seven, .ten, .thirteen] && firstUserMatchV2 != i.count && computerMatchV2 != i.count {
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
    
    func resetGame() {
        tapsAllowed = true
        for name in Box16.allCases {
            let box = getBox(for: name.rawValue)
            box.image = nil
        }
        playerChoices = []
        computerChoices = []
        resetButton.isHidden = true
        winnerLabel.isHidden = true
        winnerLabel.text = ""
    }
    
    func getBox(for name: String) -> UIImageView {
        let box = Box16(rawValue: name) ?? .one

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
        }
    }
}
