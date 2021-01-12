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

// MARK: Get forum question
extension ForumService {
    func fetchForumQuestion(for questionId: String, completion: @escaping (_ status: Bool, _ message: String, _ question: ForumQuestion?) -> ()) {
        let document = Firestore.firestore().collection("forum").document(questionId)
        
        document.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(false, error.localizedDescription, nil)
            } else {
                do {
                    let question = try documentSnapshot?.data(as: ForumQuestion.self)
                    completion(true, "Success", question)
                } catch {
                    debugPrint(error)
                    completion(false, error.localizedDescription, nil)
                }
            }
        }
    }
}

// MARK: Get answers for a forum question
extension ForumService {
    func fetchAnswers(for questionId: String, completion: @escaping (_ status: Bool, _ message: String, _ questions: [ForumAnswer]?) -> ()) {
        let collection = Firestore.firestore().collection("forum")
            .document(questionId).collection("answers")
            .order(by: "dateTime", descending: false)
        
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

// MARK: Post a forum answer
extension ForumService {
    func postAnswer(for questionId: String, answer: ForumAnswer, completion: @escaping (_ status: Bool, _ message: String) -> ()) {
        let collection = Firestore.firestore().collection("forum").document(questionId).collection("answers")
        
        do {
            let _ = try collection.addDocument(from: answer)
            completion(true, "Success")
        } catch {
            debugPrint(error)
            completion(false, error.localizedDescription)
        }
    }
}

// MARK: Vote a forum question
extension ForumService {
    func voteQuestion(questionId: String, vote: Vote, completion: @escaping (_ status: Bool, _ message: String) -> ()) {
        let document = Firestore.firestore().collection("forum").document(questionId)
        
        
        document.updateData([
            "votes": FieldValue.arrayUnion(
                [["isUpVote": vote.isUpVote,
                  "userID": vote.userID ?? ""]]
            )
        ]) { (error) in
            if let error = error {
                debugPrint(error)
                completion(false, error.localizedDescription)
            }
        }
        
        completion(true, "Vote updated")
    }
}
