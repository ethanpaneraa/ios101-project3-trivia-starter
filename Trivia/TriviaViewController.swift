//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Ethan Pineda on 3/12/24.
//

import UIKit




class TriviaViewController: UIViewController {
    
    struct Question {
        let question: String
        let answers: [String]
        let correctAnswerIndex: Int
    }

    var questions: [Question] = []
    var currentQuestionIndex = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        questions = [Question(question: "What is the best food in Evanston?", answers: ["Tomate", "10Q Chicken", "Joyee", "Chipotle"], correctAnswerIndex: 0),
//            Question(question: "What is the Capital of France?", answers: ["Marseille", "Lyon", "Paris", "Nice"], correctAnswerIndex: 2),
//            Question(question: "Which element has the chemical symbol of `O`?", answers: ["Gold", "Oxygen", "Silver", "Hydrogen"], correctAnswerIndex: 1)
//        ]
//        loadQuestion()
        fetchTriviaQuestions()
    }
    
    func fetchTriviaQuestions() {
            let url = URL(string: "https://opentdb.com/api.php?amount=5&type=multiple")!
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else { return }
                
                do {
                    let fetchedData = try JSONDecoder().decode(APIResponse.self, from: data)
                    self?.questions = fetchedData.results.map { result in
                        let allAnswers = result.incorrectAnswers + [result.correctAnswer]
                        let correctAnswerIndex = allAnswers.firstIndex(of: result.correctAnswer)!
                        return Question(question: result.question.htmlDecoded, answers: allAnswers.shuffled(), correctAnswerIndex: correctAnswerIndex)
                    }
                    DispatchQueue.main.async {
                        self?.currentQuestionIndex = 0
                        self?.loadQuestion()
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    
//    func loadQuestion() {
//        let currentQuestion = questions[currentQuestionIndex]
//        questionLabel.text = currentQuestion.question
//        
//        // Set the title for each button
//        buttonA.setTitle(currentQuestion.answers[0], for: .normal)
//        buttonB.setTitle(currentQuestion.answers[1], for: .normal)
//        buttonC.setTitle(currentQuestion.answers[2], for: .normal)
//        buttonD.setTitle(currentQuestion.answers[3], for: .normal)
//    }
//    
    func loadQuestion() {
           guard !questions.isEmpty else { return }
           let currentQuestion = questions[currentQuestionIndex]
           questionLabel.text = currentQuestion.question
           buttonA.setTitle(currentQuestion.answers[0], for: .normal)
           buttonB.setTitle(currentQuestion.answers[1], for: .normal)
           buttonC.setTitle(currentQuestion.answers[2], for: .normal)
           buttonD.setTitle(currentQuestion.answers[3], for: .normal)
       }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        print(currentQuestionIndex)
        let currentQuestion = questions[currentQuestionIndex]
        // Since buttons are separate, use their tags to identify them
        // Make sure to set the tags for each button in the storyboard accordingly (0 for A, 1 for B, etc.)
        if sender.tag == currentQuestion.correctAnswerIndex {
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


extension String {
    var htmlDecoded: String {
        guard let data = data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let decodedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil).string
        return decodedString ?? self
    }
}

// Models to decode the API response
struct APIResponse: Decodable {
    let responseCode: Int
    let results: [APITriviaQuestion]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
//        case correctAnswer = "correct_answer"
//        case incorrectAnswers = "incorrect_answers"
        case results
    }
}

struct APITriviaQuestion: Decodable {
    let type: String
        let difficulty: String
        let category: String
        let question: String
        let correctAnswer: String
        let incorrectAnswers: [String]
        
        enum CodingKeys: String, CodingKey {
            case type, difficulty, category, question
            case correctAnswer = "correct_answer"
            case incorrectAnswers = "incorrect_answers"
        }
}
