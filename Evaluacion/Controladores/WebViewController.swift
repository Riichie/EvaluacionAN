//
//  WebViewController.swift
//  Evaluacion
//
//  Created by Ricardo Aguilar on 3/6/19.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    //MARK:- UIControl
    @IBOutlet weak var webView: WKWebView!
    
    //MARK:- Variables
    var url: String!
    var alert: UIAlertController = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        
        let loading: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loading.hidesWhenStopped = true
        loading.style = UIActivityIndicatorView.Style.gray
        loading.startAnimating();
        
        alert.view.addSubview(loading)
        present(alert, animated: true, completion: nil)
        
        
        self.webView.navigationDelegate = self
        self.webView.load(URLRequest(url: URL(string: url)!))
        // Do any additional setup after loading the view.
    }
    
    //MARK:- WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        alert.dismiss(animated: true, completion: nil)
    }
}
