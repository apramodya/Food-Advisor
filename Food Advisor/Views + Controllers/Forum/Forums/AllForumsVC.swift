//
//  AllForumsVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-11.
//

import UIKit
import SwiftSpinner

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
}
