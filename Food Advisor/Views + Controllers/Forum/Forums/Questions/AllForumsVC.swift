//
//  AllForumsVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-11.
//

import UIKit
import SwiftSpinner
import FirebaseFirestore

class AllForumsVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    static let id = "AllForumsVC"
    var questions = [ForumQuestion]()
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        fetchQuestions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: IBActions
    @IBAction func didTapOnAddButton(_ sender: Any) {
        AskQuestionVC.presentAskQuestionPopup(for: self, for: .Q) { (question, isAnon) in
            self.dismiss(animated: true) {
                self.postQuestion(question: question, isAnon: isAnon)
            }
        }
    }
}

// MARK: UITableView
extension AllForumsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForumQuestionCell.id, for: indexPath) as! ForumQuestionCell
        let question = questions[indexPath.row]
        
        cell.setupCell(with: question)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = questions[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(identifier: ForumQnAVC.id) as! ForumQnAVC
        vc.question = question
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ForumQuestionCell.nib, forCellReuseIdentifier: ForumQuestionCell.id)
    }
}

// MARK: Private methods
extension AllForumsVC {
    private func setupUI() {
        title = "Forum - Questions"
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: Network requests
extension AllForumsVC {
    private func fetchQuestions() {
        SwiftSpinner.show("Hang tight!\n We are fetching questions")
        ForumService.shared.fetchForumQuestions { (success, message, questions) in
            SwiftSpinner.hide()
            
            if success, let questions = questions {
                self.questions = questions
                self.tableView.reloadData()
            } else {
                print(message)
            }
        }
    }
    
    private func postQuestion(question: String, isAnon: Bool) {
        guard let userId = LocalUser.shared.getUserID()
        else { return }
        
        var author: Author?
        
        if isAnon {
            author = Author(avatar: "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png", name: "Anonymous", userID: userId)
        } else {
            guard let name = LocalUser.shared.getFirstName(),
                  let avatar = LocalUser.shared.getUserAvatarURL()
            else { return }
            
            author = Author(avatar: avatar, name: name, userID: userId)
        }
        
        let question = ForumQuestion(id: nil, author: author, question: question, votes: nil, dateTime: Timestamp(date: Date()))
        
        SwiftSpinner.show("Hang tight!\n We are submitting your question")
        ForumService.shared.postQuestion(question: question) { (success, message) in
            SwiftSpinner.hide()
            
            if success {
                self.fetchQuestions()
            } else {
                print(message)
            }
        }
    }
}
