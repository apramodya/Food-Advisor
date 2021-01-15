//
//  MessengerVC.swift
//  Food Advisor
//
//  Created by Pramodya Abeysinghe on 2021-01-14.
//

import UIKit
import WebKit

enum WebViewType: String {
    case Messsenger = "Chat with us"
    case PrivacyPolicy = "Privacy Policy"
    case TermsAndConditions = "Terms And Conditions"
    
    var webUrl: String {
        switch self {
        case .Messsenger: return "https://food-advisor-messaging.herokuapp.com"
        case .PrivacyPolicy: return "https://food-advisor-c95e4.firebaseapp.com/pp"
        case .TermsAndConditions: return "https://food-advisor-c95e4.firebaseapp.com/tnc"
        }
    }
}

class WebViewVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Variables
    static let id = "WebViewVC"
    var webViewType: WebViewType = .Messsenger
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebsite(for: webViewType)
    }
}

// MARK: WKWebView
extension WebViewVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}

// MARK: Private methods
extension WebViewVC {
    private func configureView() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        title = webViewType.rawValue
        webView.navigationDelegate = self
    }
    
    private func loadWebsite(for type: WebViewType) {
        guard let url = URL(string: type.webUrl) else { return }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
