//
//  ViewController.swift
//  HangMan_project
//
//  Created by Pranav Geek on 2023-10-26.
//

import UIKit

class ViewController: UIViewController {
    
    var wordArry = ["Academy", "Banking", "Captain", "Diamond", "Economy", "Finance", "Graphic", "History", "Insulin", "Journey"]
    
    @IBOutlet weak var keyboardStackView: UIStackView!
    @IBOutlet weak var hangmanImg: UIImageView!
    @IBOutlet weak var userWins: UILabel!
    @IBOutlet weak var userGuess: UILabel!
    @IBOutlet weak var userLosses: UILabel!

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var leftArmImageView: UIImageView!
    @IBOutlet weak var rightArmImageView: UIImageView!
    @IBOutlet weak var leftLegImageView: UIImageView!
    @IBOutlet weak var rightLegImageView: UIImageView!
    
    var wins = 0
    var losses = 0
    var currentWord = ""
    var gussedWord = ""
    var incorrectGuess = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letBeginGame()
        headImageView.isHidden = true
        bodyImageView.isHidden = true
        leftArmImageView.isHidden = true
        rightArmImageView.isHidden = true
        leftLegImageView.isHidden = true
        rightLegImageView.isHidden = true
    }
    
    func letBeginGame() {
        currentWord = getRandomWord()
        gussedWord = String(repeating: "?", count: currentWord.count)
        userGuess.text = gussedWord
        incorrectGuess = 0
        headImageView.isHidden = true
        bodyImageView.isHidden = true
        leftArmImageView.isHidden = true
        rightArmImageView.isHidden = true
        leftLegImageView.isHidden = true
        rightLegImageView.isHidden = true
    }
    
    
    func getRandomWord() -> String {
        return wordArry.randomElement() ?? "hangman"
    }
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        guard let letter = sender.titleLabel?.text else {
            return
        }
        
        if let labelText = userGuess.text, !currentWord.isEmpty {
            var modifiedText = labelText
            var guessedCorrectly = false
            
            for (index, char) in currentWord.enumerated() {
                if char.lowercased() == letter.lowercased(){
                    let startIndex = modifiedText.index(modifiedText.startIndex, offsetBy: index)
                    let endIndex = modifiedText.index(modifiedText.startIndex, offsetBy: index + 1)
                    modifiedText.replaceSubrange(startIndex..<endIndex, with: String(char))
                    guessedCorrectly = true
                }
            }
            userGuess.text = modifiedText
            
            if !modifiedText.contains("?") {
                wins += 1
                userWins.text = "WINS: \(wins)"
                showAlert(title: "Woohoo!", message: "You saved me! Would you like to play again?")
                letBeginGame()
            }else if !guessedCorrectly {
                incorrectGuess += 1
                checkLoss()
            }
        }
        
    }
    
    func checkLoss() {
        
        if incorrectGuess >= 1 {
            headImageView.isHidden = false
        }
        
        if incorrectGuess >= 2 {
            bodyImageView.isHidden = false
        }
        
        if incorrectGuess >= 3 {
            leftArmImageView.isHidden = false
        }
        
        if incorrectGuess >= 4 {
            rightArmImageView.isHidden = false
        }
        
        if incorrectGuess >= 5 {
            leftLegImageView.isHidden = false
        }
        
        if incorrectGuess >= 6 {
            rightLegImageView.isHidden = false
            losses += 1
            userLosses.text = "Losses: \(losses)"
            showAlertLoss()
            letBeginGame()
        }
    }
    
    func showAlertLoss() {
        showAlert(title: "Uh oh", message: "The correct word was \(currentWord). Would you like to try again?")
    }
    
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                self.letBeginGame()
            }))
            present(alert, animated: true, completion: nil)
        }
    
}
