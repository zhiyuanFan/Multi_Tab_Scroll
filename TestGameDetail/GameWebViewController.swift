//
//  GameWebViewController.swift
//  TestGameDetail
//
//  Created by Jason Fan on 2017/6/1.
//  Copyright © 2017年 jason. All rights reserved.
//

import UIKit

class GameWebViewController: UIViewController {
    var webView: UIWebView?
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        self.webView = UIWebView(frame: UIScreen.main.bounds)
        if url != nil {
            let request = URLRequest(url: url!)
            self.webView?.loadRequest(request)
        }
        self.view.addSubview(self.webView!)
    }
}
