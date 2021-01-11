//
//  ForumService.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-11.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ForumService {
    static let shared = ForumService()
}

// MARK: Get forum questions
extension ForumService {
    func fetchForumQuestions(completion: @escaping (_ status: Bool, _ message: String, _ questions: [ForumQuestion]?) -> ()) {
        let collection = Firestore.firestore().collection("forum")
        
        collection.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false, error.localizedDescription, nil)
            } else {
                guard let documents = querySnapshot?.documents else {
                    completion(false, "Error", nil)
                    return
                }
                
                let questions = documents.compactMap({ (document) -> ForumQuestion? in
                    do {
                        return try document.data(as: ForumQuestion.self)
                    } catch {
                        debugPrint(error)
                        completion(false, error.localizedDescription, nil)
                        return nil
                    }
                })
                
                completion(true, "Success", questions)
            }
        }
    }
}

// MARK: Get answers for a forum question
extension ForumService {
    func fetchAnswers(for questionId: String, completion: @escaping (_ status: Bool, _ message: String, _ questions: [ForumAnswer]?) -> ()) {
        let collection = Firestore.firestore().collection("forum").document(questionId).collection("answers")
        
        collection.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false, error.localizedDescription, nil)
            } else {
                guard let documents = querySnapshot?.documents else {
                    completion(false, "Error", nil)
                    return
                }
                
                let answers = documents.compactMap({ (document) -> ForumAnswer? in
                    do {
                        return try document.data(as: ForumAnswer.self)
                    } catch {
                        debugPrint(error)
                        completion(false, error.localizedDescription, nil)
                        return nil
                    }
                })
                
                completion(true, "Success", answers)
            }
        }
    }
}

// MARK: Post a forum question
extension ForumService {
    func postQuestion(question: ForumQuestion, completion: @escaping (_ status: Bool, _ message: String) -> ()) {
        let collection = Firestore.firestore().collection("forum")
        
        do {
            let _ = try collection.addDocument(from: question)
            completion(true, "Success")
        } catch {
            debugPrint(error)
            completion(false, error.localizedDescription)
        }
    }
}
