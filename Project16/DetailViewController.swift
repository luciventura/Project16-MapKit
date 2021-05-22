//
//  DetailViewController.swift
//  Project16
//
//  Created by Luciene Ventura on 15/05/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    var selectedCapital: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: selectedCapital!) else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

      
    }
    

   

}
