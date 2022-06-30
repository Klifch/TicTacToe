//
//  5x5ComputerViewController.swift
//  TicTacToe
//
//  Created by Alex Demidenko on 30.06.2022.
//

import UIKit

class _x5ComputerViewController: UIViewController {
    
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
    
    var playerChoices: [Box25] = []
    var computerChoices: [Box25] = []
    var tapsAllowed = true
    var firstStands: String = ""
    var player: String = "X"
    var ai: String = "O"

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
        
        whoWillGoFirst()
    }
    
    @IBAction func resetButtonPressed() {
        resetGame()
        whoWillGoFirst()
    }
    
    @IBAction func exitButtonPressed() {
        dismiss(animated: true)
    }
    
    func rollFirstStep() {
        let bestVariants: [Box25] = [.one, .five, .twentyOne, .twentyFive, .thirteen]
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
    
    // function to recognize the tap on Images and exact Image that was tapped
    func makeTap(on image: UIImageView, index box: Box25) {
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
        var availableBoxes = [Box25]()
        for name in Box25.allCases {
            let box = getBox(for: name.rawValue)
            if box.image == nil {
                availableSpaces.append(box)
                availableBoxes.append(name)
            }
        }
        
        guard availableBoxes.count > 0 else { return }
        if availableBoxes.count >= 18 {
            makeChoiceComputer(availableSpaces[Int.random(in: 0 ..< availableSpaces.count)])
            tapsAllowed = true
        }
        else if availableBoxes.count < 18 && availableBoxes.count > 9 {
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
        
        for name in Box25.allCases {
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
        
        for name in Box25.allCases {
            let box = getBox(for: name.rawValue)
            if box == selectedBox {
                computerChoices.append(name)
            }
        }
        checkIfWin()
    }
    
    func bestMove(userBoxes: [Box25], compBoxes: [Box25], emptySpaces: [UIImageView]) -> UIImageView {
        var bestScore = -1000
        let randIndex = Int.random(in: 0 ..< emptySpaces.count)
        let human = userBoxes
        var computer = compBoxes
        var move: Box25 = .one
        for i in Box25.allCases {
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
        
        for name in Box25.allCases {
            let box = getBox(for: name.rawValue)
            if name == move {
                return box
            }
        }
        return(emptySpaces[randIndex])
    }
    
    func miniMax(userBoxes: [Box25], compBoxes: [Box25], depth: Int, alpha: Int, beta: Int, isMaximizing: Bool) -> Int {
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
            for i in Box25.allCases {
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
            for i in Box25.allCases {
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
    
    func doMove(combinationComputer: [Box25], combinationUser: [Box25], availableBoxes: [Box25]) -> Box25 {
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
        
        var bestMove: Box25 = availableBoxes[Int.random(in: 0 ..< availableBoxes.count)]
        var bestMatch: [Box25] = []
        var bestCount: Int = 0
        
        for match in correct {
            let combinationMatchComputer = combinationComputer.filter { match.contains($0) }
            let combinationMatchUser = combinationUser.filter { match.contains($0) }
            if combinationMatchComputer.count >= 1 {
                if combinationMatchComputer.count > bestCount {
                    bestMatch = match
                    bestCount = combinationMatchComputer.count
                }
            }
            if combinationMatchUser.count == 4 {
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
    
    func calculate(computerBoxes: [Box25], userBoxes: [Box25], availableBoxes: [Box25]) -> UIImageView {
        var safe = getBox(for: availableBoxes[Int.random(in: 0 ..< availableBoxes.count)].rawValue)
        let bestMove = doMove(combinationComputer: computerBoxes, combinationUser: userBoxes, availableBoxes: availableBoxes)
        for i in Box25.allCases {
            let name = getBox(for: i.rawValue)
            if i == bestMove {
                safe = name
                return safe
            }
        }
        return safe
    }
    
    func checkWinner(user combinationUser: [Box25], computer combinationComputer: [Box25]) -> String {
        let result = "none"
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
            let combinationMatchComputer = combinationComputer.filter { match.contains($0) }.count
            let combinationMatchUser = combinationUser.filter { match.contains ($0) }.count
            
            if combinationMatchComputer == match.count {
                return ai
            }
            else if combinationMatchUser == match.count {
                return player
            }
            else if combinationUser.count + combinationComputer.count == 25 {
                for i in correct {
                    let combinationMatchCPV2 = combinationComputer.filter { i.contains($0) }.count
                    let combinationMatchUSV2 = combinationUser.filter { i.contains($0) }.count

                    if combinationMatchCPV2 == i.count {
                        return ai
                    }
                    else if combinationMatchUSV2 == i.count {
                        return player
                    }
                    if i == [.five, .nine, .thirteen, .seventeen, .twentyOne] && combinationMatchCPV2 != i.count && combinationMatchUSV2 != i.count {
                        return "Tie"
                    }
                }
            }
        }
        return result
    }
    
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
            else if playerChoices.count + computerChoices.count == 25 {
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
                    else if i == [.five, .nine, .thirteen, .seventeen, .twentyOne] && firstUserMatchV2 != i.count && computerMatchV2 != i.count {
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
        for name in Box25.allCases {
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
