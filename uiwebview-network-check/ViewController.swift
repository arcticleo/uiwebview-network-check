//
//  ViewController.swift
//  uiwebview-network-check
//
//  Created by Michael Edlund on 4/14/17.
//  Copyright © 2017 MIchael Edlund. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var browser: UIWebView!
    
    func checkNetwork() {
        let status = Reach().connectionStatus()
        NetworkStatus.lastStatus = status
    }
    
    func checkNLoad() {
        checkNetwork()
        switch NetworkStatus.lastStatus {
        case .unknown, .offline:
            displayOffline()
        default:
            loadWebApp()
        }
    }
    
    func loadWebViewFromURL(_ url: URL) {
        let request = URLRequest(url: url)
        Browser.webview?.loadRequest(request)
    }
    
    func displayOffline() {
        NetworkStatus.fireRepeatedOnlineCheck()
        let url = Bundle.main.url(forResource: "offline", withExtension: "html")
        loadWebViewFromURL(url!)
    }
    
    func loadWebApp() {
        NetworkStatus.invalidateRepeatedOnlineCheck()
        let url = URL(string: "http://www.techmeme.com")
        loadWebViewFromURL(url!)
    }

    func webView(_: UIWebView, didFailLoadWithError: Error) {
        checkNetwork()
        if case .offline = NetworkStatus.lastStatus {
            displayOffline()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browser.delegate = self
        Browser.webview = browser
        checkNLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

