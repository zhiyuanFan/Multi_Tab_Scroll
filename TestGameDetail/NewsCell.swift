//
//  NewsCell.swift
//  TestGameDetail
//
//  Created by Jason Fan on 2017/5/31.
//  Copyright © 2017年 jason. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    var newsImage: UIImageView?
    var newsTitle: UILabel?
    var newsFrom: UILabel?
    var newsDate: UILabel?
    static let className: String = "NewsCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    func setupSubViews() {
        self.newsImage = UIImageView()
        self.contentView.addSubview(self.newsImage!)
        
        self.newsTitle = UILabel()
        self.newsTitle?.numberOfLines = 0
        self.newsTitle?.font = UIFont.systemFont(ofSize: 13)
        self.newsTitle?.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(self.newsTitle!)
        
        self.newsFrom = UILabel()
        self.newsFrom?.font = UIFont.systemFont(ofSize: 13)
        self.newsFrom?.textColor = UIColor.blue
        self.newsFrom?.textAlignment = .center
        self.newsFrom?.layer.borderWidth = 1.0
        self.newsFrom?.layer.borderColor = UIColor.blue.cgColor
        self.newsFrom?.layer.cornerRadius = 3.0
        self.newsFrom?.layer.masksToBounds = true
        self.contentView.addSubview(self.newsFrom!)
        
        self.newsDate = UILabel()
        self.newsDate?.font = UIFont.systemFont(ofSize: 13)
        self.newsDate?.textAlignment = .right
        self.newsDate?.textColor = UIColor.lightGray
        self.contentView.addSubview(self.newsDate!)
    }
    
    func setupInfo() {
//        let imageUrl = NSURL.init(string: newsModel.newsImageUrl!)
        
        self.newsImage?.image = UIImage.init(named: "pokemenGO")
        self.newsTitle?.text = "《Pokemon Go》獲英國BAFTA頒年度最佳手機遊戲 官方Niantic透露近日將實裝協力機能"
        self.newsFrom?.text = "情报"
        self.newsDate?.text = "2017-03-06 12:51:43"
    }
    
    override func layoutSubviews() {
        let cellW = self.frame.size.width
        let cellH = self.frame.size.height
        let imageW = cellW * 0.4

        self.newsImage?.frame = CGRect(x: 5, y: 5, width: cellW * 0.4, height: cellH - 10)
        self.newsTitle?.frame = CGRect(x: imageW + 10, y: 5, width: cellW - imageW - 10, height: cellH * 0.7)
        self.newsFrom?.frame = CGRect(x: imageW + 10, y: cellH - 20, width: 35, height: 15)
        self.newsDate?.frame = CGRect(x: 0, y: cellH - 20, width: cellW - 10, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame:CGRect{
        
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.size.width -= newFrame.origin.x * 2
            newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
    
    
}
