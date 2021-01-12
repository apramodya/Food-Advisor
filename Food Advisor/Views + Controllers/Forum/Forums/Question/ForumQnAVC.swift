//
//  ForumQnAVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-12.
//

import UIKit
import SwiftSpinner
import FirebaseFirestore

class ForumQnAVC: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    static let id = "ForumQnAVC"
    var sections = [Section(type: .Question), Section(type: .Answers)]
    var question: ForumQuestion?
    var answers = [ForumAnswer]()
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        fetchAnswers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: IBActions
    @IBAction func didTapOnAddButton(_ sender: Any) {
        AskQuestionVC.presentAskQuestionPopup(for: self, for: .A) { (answer, isAnon) in
            self.dismiss(animated: true) {
                guard let id = self.question?.id else { return }
                
                self.postAnswer(questionId: id, answer: answer, isAnon: isAnon)
            }
        }
    }
}

// MARK: UITableView
extension ForumQnAVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section].type
        
        switch section {
        case .Question: return 1
        case .Answers: return answers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section].type
        
        switch section {
        case .Question:
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionDetailsCell.id, for: indexPath) as! QuestionDetailsCell
            
            if let question = question {
                cell.setupCell(with: question)
            }
            
            cell.didUpVote = { [weak self] vote in
                guard let id = self?.question?.id else { return }
                
                self?.voteQuestion(questionId: id, isUpVote: vote)
            }
            
            return cell
        case .Answers:
            let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.id, for: indexPath) as! AnswerCell
            let answer = answers[indexPath.row]
            cell.setupCell(with: answer)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuestionDetailsCell.nib, forCellReuseIdentifier: QuestionDetailsCell.id)
        tableView.register(AnswerCell.nib, forCellReuseIdentifier: AnswerCell.id)
    }
    
    struct Section {
        var type: SectionType
    }
    
    enum SectionType {
        case Question, Answers
    }
}

// MARK: Private methods
extension ForumQnAVC {
    private func setupUI() {
        title = "Forum - QnA"
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
}

// MARK: Network requests
extension ForumQnAVC {
    private func fetchAnswers() {
        guard let questionId = question?.id else { return }
        
        SwiftSpinner.show("Hang tight!\n We are fetching forum question and answers")
        ForumService.shared.fetchAnswers(for: questionId) { (success, message, answers) in
            SwiftSpinner.hide()
            
            if success, let answers = answers {
                self.answers = answers
                self.tableView.reloadData()
            } else {
                print(message)
            }
        }
    }
    
    private func fetchQuestion(for id: String) {
        SwiftSpinner.show("Hang tight!\n We are fetching question")
        ForumService.shared.fetchForumQuestion(for: id) { (success, message, question) in
            SwiftSpinner.hide()
            
            if success, let question = question {
                self.question = question
                self.tableView.reloadData()
            } else {
                print(message)
            }
        }
    }
    
    private func postAnswer(questionId: String, answer: String, isAnon: Bool) {
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
        
        let answer = ForumAnswer(id: nil, author: author, answer: answer, dateTime: Timestamp.init(date: Date()))
        
        SwiftSpinner.show("Hang tight!\n We are submitting your answer")
        ForumService.shared.postAnswer(for: questionId, answer: answer) { (success, message) in
            SwiftSpinner.hide()
            
            if success {
                self.fetchAnswers()
            } else {
                print(message)
            }
        }
    }
    
    private func voteQuestion(questionId: String, isUpVote: Bool) {
        guard let userId = LocalUser.shared.getUserID()
        else { return }
        
        let vote = Vote(isUpVote: isUpVote, userID: userId)
        
        SwiftSpinner.show("Hang tight!\n We are updating your vote")
        ForumService.shared.voteQuestion(questionId: questionId, vote: vote) { (success, message) in
            SwiftSpinner.hide()
            
            if success {
                self.fetchQuestion(for: questionId)
            } else {
                print(message)
            }
        }
    }
}
