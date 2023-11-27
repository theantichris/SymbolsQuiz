//
//  ViewController.swift
//  SymbolsQuiz
//
//  Created by Christopher Lamm on 11/27/23.
//

import UIKit

enum Mode {
    case flashCard, quiz
}

enum QuizState {
    case askingQuestion, showingAnswer
}

class ViewController: UIViewController, UITextFieldDelegate {
    let symbolList = ["A", "B", "C", "D", "E", "F", "G", "H", "I:J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U:V", "W", "X", "Y", "Z", "End of sentence"]
    var currentSymbolIndex = 0
    
    var mode: Mode = .flashCard {
        didSet {
            updateUI()
        }
    }
    
    var state: QuizState = .askingQuestion
    
    // Quiz specific state.
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var quizAnswer: UITextField!
    
    
    @IBAction func showAnswer(_ sender: Any) {
        state = .showingAnswer
        
        updateUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentSymbolIndex += 1
        
        if currentSymbolIndex >= symbolList.count {
            currentSymbolIndex = 0
        }
        
        state = .askingQuestion
        
        updateUI()
    }
    
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // Updates the app's UI based on its mode and state.
    func updateUI() {
        switch mode {
        case .flashCard:
            updateFlashCardUI()
        case .quiz:
            updateQuizUI()
        }
    }
    
    // Updates the app's UI in flash card mode.
    func updateFlashCardUI() {
        let symbolName = symbolList[currentSymbolIndex]
        let image = UIImage(named: symbolName)
        imageView.image = image
        
        if state == .showingAnswer {
            answerLabel.text = symbolName
        } else {
            answerLabel.text = "?"
        }
    }
    
    // Updates the app's UI in quiz mode.
    func updateQuizUI() {
        switch state {
        case .askingQuestion:
            answerLabel.text = ""
        case .showingAnswer:
            if answerIsCorrect {
                answerLabel.text = "Correct!"
            } else {
                answerLabel.text = "❌"
            }
        }
    }
    
    // Runs after the user hits the Return key on the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Get the text from the text field.
        let textFieldContents = textField.text!
        
        // Determine whether the user answered correctly and update appropriate quiz state.
        if textFieldContents.uppercased() == symbolList[currentSymbolIndex] {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        
        // The app should now display the answer to the user.
        state = .showingAnswer
        
        updateUI()
        
        return true
    }
}

