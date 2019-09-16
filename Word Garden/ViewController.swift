//
//  ViewController.swift
//  Word Garden
//
//  Created by Richard Jove on 9/11/19.
//  Copyright © 2019 Richard Jove. All rights reserved.
//
//Richard Jové
import UIKit

class ViewController: UIViewController {

    //Treat below like they're going to eventually have information in there, we don't currently have a value to initialize it with.
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    //var wordToGuess = "SWIFT"
    var wordsToGuess = ["SWIFT", "BC", "APPLE", "EAGLES", "FUN"]
    var wordToGuess = ""
    var wordToGuessIndex = 0
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordToGuess = wordsToGuess[wordToGuessIndex]
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        //Use nested for loop to solve the challenge problem about cycling through an array?
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord = revealedWord + " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        // Decrements the wrongGuessesRemaining and shows the next flower image with one less petal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)") //Decrementing flower to flower8, flower7, etc. to get the different images
        }
        
        
        let revealedWord = userGuessLabel.text!
        // Stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
        } else if !revealedWord.contains("_") {
            //You've won a game!
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            //Update our guess count
            let guess = (guessCount == 1 ? "Guess" : "Guesses") //This is a ternery operator
//            var guess = "guesses"
//            if guessCount == 1 {
//                guess = "guess"
//            }
            guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }
    
    @IBAction func guessLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            //Disable the button if I don't have a single character in the guessedLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) { //Refreshes everything to how it was when we first started the game
        //Increment to new word in the array
        wordToGuessIndex += 1
        if wordToGuessIndex == wordsToGuess.count {
            wordToGuessIndex = 0
        }
        wordToGuess = wordsToGuess[wordToGuessIndex]
        
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")//Reset the flower image
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
    }
}

