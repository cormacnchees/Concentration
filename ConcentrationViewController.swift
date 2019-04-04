//
//  ViewController.swift
//  Concentration
//
//  Created by Cormac Hayden on 3/4/19.
//  Copyright © 2019 Cormac Hayden. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game : Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards) //model
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2 //read only
    }
    
    private(set) var flipCount = 0 { //read (get) only
        didSet {
            updateFlipCountLabel()
        }
    }
        
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
             .strokeColor : #colorLiteral(red: 0.08326194405, green: 0.5439284332, blue: 0.9942671657, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    var cardMatches = 0
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var restartBtn: UIButton!
    
    @IBAction private func restartGame(_ sender: UIButton) {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            //Flip cards over
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.5542243123, blue: 0.8053370714, alpha: 1)
            //Restart card model
            game.cards[index].isMatched = false
            game.cards[index].isFaceUp = false
            flipCount = 0
        }
    }
    
    @IBOutlet private var  cardButtons: [UIButton]!
    
    //Touches card
     @IBAction func touchCard(_ sender: UIButton) {
       flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp { //For each faceup card
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.9942671657, green: 0.4894910111, blue: 0.02981270223, alpha: 0) : #colorLiteral(red: 0, green: 0.5542243123, blue: 0.8053370714, alpha: 1) //If card is matched, set background clear, otherwise flip over (turn orange)
                    if card.isMatched { //Track to see if Game Over
                        cardMatches += 1
                    }
                }
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji  = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🌙🌊🌈🌸🌺🥝🏄🏼‍♂️🤙🏽🌴🍎🥥😁🕶🐬🙉" //default theme
    
    private var emoji = [Card:String]()
    
    //places emoji on card when flipped up
    private func emoji(for card: Card) -> String { 
        if emoji[card] == nil, emojiChoices.count > 0 { //double if
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex)) //returns emoji that is removed in order to avoid duplicate emojis
        }
    
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return  Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
