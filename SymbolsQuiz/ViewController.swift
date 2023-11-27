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
    case question, answer
}

class ViewController: UIViewController {
    let symbolList = ["A", "B", "C", "D", "E", "F", "G", "H", "I:J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U:V", "W", "X", "Y", "Z", "End of sentence"]
    var currentSymbolIndex = 0
    
    var mode: Mode = .flashCard
    var state: State = .question
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var quizAnswer: UITextField!
    
    
    @IBAction func showAnswer(_ sender: Any) {
        state = .answer
        
        updateFlashCardUI()
    }
    
    @IBAction func next(_ sender: Any) {
        currentSymbolIndex += 1
        
        if currentSymbolIndex >= symbolList.count {
            currentSymbolIndex = 0
        }
        
        state = .question
        
        updateFlashCardUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFlashCardUI()
    }
    
    // Updates the app's UI in flash card mode.
    func updateFlashCardUI() {
        let symbolName = symbolList[currentSymbolIndex]
        let image = UIImage(named: symbolName)
        imageView.image = image
        
        if state == .answer {
            answerLabel.text = symbolName
        } else {
            answerLabel.text = "?"
        }
    }
}

