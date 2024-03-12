//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Ethan Pineda on 3/12/24.
//

import UIKit


struct Question {
    let question: String
    let answers: [String]
    let CorrectAnswerIndex: Int
}

var questions: [Question] = []
var currentQuestionIndex = 0


class TriviaViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = [Question(question: "What is the best food in Evanston?", answers: ["Tomate", "10Q Chicken", "Joyee", "Chipotle"], CorrectAnswerIndex: 0),
            Question(question: "What is the Capital of France?", answers: ["Marseille", "Lyon", "Paris", "Nice"], CorrectAnswerIndex: 2),
            Question(question: "Which element has the chemical symbol of `O`?", answers: ["Gold", "Oxygen", "Silver", "Hydrogen"], CorrectAnswerIndex: 1)
        ]
        loadQuestion()
    }
    
    func loadQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        questionLabel.text = currentQuestion.question
        
        // Set the title for each button
        buttonA.setTitle(currentQuestion.answers[0], for: .normal)
        buttonB.setTitle(currentQuestion.answers[1], for: .normal)
        buttonC.setTitle(currentQuestion.answers[2], for: .normal)
        buttonD.setTitle(currentQuestion.answers[3], for: .normal)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        // Since buttons are separate, use their tags to identify them
        // Make sure to set the tags for each button in the storyboard accordingly (0 for A, 1 for B, etc.)
        if sender.tag == currentQuestion.CorrectAnswerIndex {
            currentQuestionIndex += 1
            if currentQuestionIndex < questions.count {
                loadQuestion()
            } else {
                print("End of the game!")
                currentQuestionIndex = 0
                loadQuestion()
            }
        } else {
            print("Incorrect answer selected")
        }
        
        // Load next question or finish the game if it was the last question
//        currentQuestionIndex += 1
//        if currentQuestionIndex < questions.count {
//            loadQuestion()
//        } else {
//            // Game finished, show some kind of completion message
//        }
    }
    
    // Rest of your code...
}
