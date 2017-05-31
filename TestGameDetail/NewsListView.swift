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
    let cellId : String = "newsCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        self.listView = UITableView(frame: self.bounds)
        self.listView.delegate = self
        self.listView.dataSource = self
        self.addSubview(self.listView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = "the row number of this cell is \(indexPath.row)"
        
        return cell!
    }
    
    
    //MARK: - table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
