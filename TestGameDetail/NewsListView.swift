//
//  NewsListView.swift
//  TestGameDetail
//
//  Created by Jason Fan on 2017/5/31.
//  Copyright © 2017年 jason. All rights reserved.
//

import UIKit

class NewsListView: UIView,UITableViewDelegate,UITableViewDataSource {
    var listView : UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        self.listView = UITableView(frame: self.bounds)
        self.listView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.className)
        self.listView.delegate = self
        self.listView.dataSource = self
        self.listView.tableFooterView = UIView()
        self.listView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
        self.addSubview(self.listView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NewsCell = self.listView.dequeueReusableCell(withIdentifier: NewsCell.className) as! NewsCell
        cell.setupInfo()
        return cell
    }
    
    
    //MARK: - table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
