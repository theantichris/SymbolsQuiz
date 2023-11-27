//
//  ViewController.swift
//  SymbolsQuiz
//
//  Created by Christopher Lamm on 11/27/23.
//

import UIKit

class ViewController: UIViewController {
    let symbolList = ["A", "B", "C", "D", "E", "F", "G", "H", "IJ", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "UV", "W", "X", "Y", "Z", "End of sentence"]
    var currentSymbolIndex = 0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

