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

class ViewController: UIViewController {
    let symbolList = ["A", "B", "C", "D", "E", "F", "G", "H", "I:J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U:V", "W", "X", "Y", "Z", "End of sentence"]
    var currentSymbolIndex = 0
    
    var mode: Mode = .flashCard
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var quizAnswer: UITextField!
    
    
    @IBAction func showAnswer(_ sender: Any) {
        answerLabel.text = symbolList[currentSymbolIndex]
    }
    
    @IBAction func next(_ sender: Any) {
        currentSymbolIndex += 1
        
        if currentSymbolIndex >= symbolList.count {
            currentSymbolIndex = 0
        }
        
        updateSymbol()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSymbol()
    }
    
    func updateSymbol() {
        let symbolName = symbolList[currentSymbolIndex]
        
        let image = UIImage(named: symbolName)
        imageView.image = image
        
        answerLabel.text = "?"
    }
}

