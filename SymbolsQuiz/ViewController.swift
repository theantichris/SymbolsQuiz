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

enum State {
    case askingQuestion, showingAnswer, showingScore
}

class ViewController: UIViewController, UITextFieldDelegate {
    let symbolList = ["A", "B", "C", "D", "E", "F", "G", "H", "I:J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U:V", "W", "X", "Y", "Z", "End of sentence"]
    var currentSymbolIndex = 0
    
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case .flashCard:
                setUpFlashCards()
            case .quiz:
                setUpQuiz()
            }
            
            updateUI()
        }
    }
    
    var state: State = .askingQuestion
    
    // Quiz specific state.
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var quizAnswer: UITextField!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBAction func showAnswer(_ sender: Any) {
        state = .showingAnswer
        
        updateUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentSymbolIndex += 1
        
        // TODO: change this back to symbolList.count after testing.
        if currentSymbolIndex >= 4 {
            currentSymbolIndex = 0
            
            if mode == .quiz {
                state = .showingScore
                updateUI()
                
                return
            }
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
        // Update the displayed image.
        let symbolName = symbolList[currentSymbolIndex]
        let image = UIImage(named: symbolName)
        imageView.image = image
        
        switch mode {
        case .flashCard:
            updateFlashCardUI(symbolName: symbolName)
        case .quiz:
            updateQuizUI()
        }
    }
    
    // Updates the app's UI in flash card mode.
    func updateFlashCardUI(symbolName: String) {
        // Segmented control.
        modeSelector.selectedSegmentIndex = 0
        
        // Text field and keyboard.
        quizAnswer.isHidden = true
        quizAnswer.resignFirstResponder()
        
        // Answer label.
        if state == .showingAnswer {
            answerLabel.text = symbolName
        } else {
            answerLabel.text = "?"
        }
        
        // Buttons.
        showAnswerButton.isHidden = false
        
        nextButton.isEnabled = true
        nextButton.setTitle("Next Symbol", for: .normal)
    }
    
    // Updates the app's UI in quiz mode.
    func updateQuizUI() {
        // Segmented control.
        modeSelector.selectedSegmentIndex = 1
        
        // Text field and keyboard.
        quizAnswer.isHidden = false
        
        switch state {
        case .askingQuestion:
            quizAnswer.text = ""
            quizAnswer.becomeFirstResponder()
        case .showingAnswer:
            quizAnswer.resignFirstResponder()
        case .showingScore:
            quizAnswer.isHidden = true
            quizAnswer.resignFirstResponder()
        }
        
        // Answer label.
        switch state {
        case .askingQuestion:
            answerLabel.text = "?"
        case .showingAnswer:
            if answerIsCorrect {
                answerLabel.text = "✅"
            } else {
                answerLabel.text = "❌"
            }
        case .showingScore:
            answerLabel.text = ""
            displayScoreAlert()
        }
        
        // Buttons.
        showAnswerButton.isHidden = true
        
        if currentSymbolIndex == symbolList.count - 1 {
            nextButton.setTitle("Show Score", for: .normal)
        } else {
            nextButton.setTitle("Next Question", for: .normal)
        }
        
        switch state {
        case .askingQuestion:
            nextButton.isEnabled = false
        case .showingAnswer:
            nextButton.isEnabled = true
        case .showingScore:
            nextButton.isEnabled = false
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
    
    // Shows an alert with the user's quiz score.
    func displayScoreAlert() {
        let alert = UIAlertController(title: "Quiz Score", message: "Your score is \(correctAnswerCount) out of \(symbolList.count).", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: scoreAlertDismissed(_:))
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Sets the game mode to flash card after the score alert is dismissed.
    func scoreAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
    
    // Sets up a new flash card session.
    func setUpFlashCards() {
        state = .askingQuestion
        currentSymbolIndex = 0
    }
    
    // Sets up a new quiz session.
    func setUpQuiz() {
        state = .askingQuestion
        currentSymbolIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
    }
}

