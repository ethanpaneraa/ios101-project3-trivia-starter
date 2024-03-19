////
////  TriviaQuestionService.swift
////  Trivia
////
////  Created by Ethan Pineda on 3/18/24.
////
//
//import Foundation
//
//struct TriviaQuestion: Decodable {
//    let type: String
//    let difficulty: String
//    let category: String
//    let question: String
//    let correctAnswer: String
//    let incorrectAnswers: String
//    
//    enum CodingKeys: String, CodingKey {
//        case type, difficulty, category, question
//        case correctAnswer = "correct_answer"
//        case incorrectAnswers = "incorrect_answers"
//    }
//}
//
//
//class TriviaQuestionService {
//    
//    static let urlString = "https://opentdb.com/api.php"
//    
//    
//    static func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
//        var urlComponents = URLComponents(string: urlString)
//        
//        urlComponents?.queryItems = [
//            URLQueryItem(name: "amount", value: "5")
//        ]
//        
//        guard let url = urlComponents.url else {
//                   completion(nil)
//                   return
//               }
//               
//               let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                   guard let data = data, error == nil else {
//                       completion(nil)
//                       return
//                   }
//                   
//                   do {
//                       let decoder = JSONDecoder()
//                       let response = try decoder.decode(APIResponse.self, from: data)
//                       completion(response.results)
//                   } catch {
//                       completion(nil)
//                   }
//               }
//               
//               task.resume()
//    }
//}
