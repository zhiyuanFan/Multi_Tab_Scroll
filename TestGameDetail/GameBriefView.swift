//
//  GameBriefView.swift
//  TestGameDetail
//
//  Created by Jason Fan on 2017/6/1.
//  Copyright © 2017年 jason. All rights reserved.
//

import UIKit
import Kingfisher


class GameBriefView: UIView,TTTAttributedLabelDelegate,UITableViewDelegate,UITableViewDataSource {
    var imageTableView: UITableView?
    var briefLabel: TTTAttributedLabel?
    var testLabel: UILabel?
    var clickLinkCallBack: ((URL)->Void)?
    let imageArray = [
    "https://d2jcw5q7j4vmo4.cloudfront.net/dq_t7Is81-gkHYxKfAQ7PuLQBR-Qrte-7S1DsKFZnhaZATpibMSiw3aCrJzYik1x3IV5=h310",
    "https://d2jcw5q7j4vmo4.cloudfront.net/S97uuMKpsZXzQ70_lf-535aUHwN3pw98veYbHR0CduoNCD7nt9QuBqTPXrk916mNwnJ1=h310",
    "https://d2jcw5q7j4vmo4.cloudfront.net/UJsqbNSI3dFLNeVw0qGYdDNz3uvzrKOw9r0DHQ0KZigwrKfFyiLSFjSTkI_DBdYz2yt-=h310",
    "https://d2jcw5q7j4vmo4.cloudfront.net/22ySaopy8gQQelxKpUMUP56i9kAhnoONR4RmjEZ1AyvWqbO-ae_kO8Hi1zIqBfqNjFk=h310",
    "https://d2jcw5q7j4vmo4.cloudfront.net/J8kUfrUigeTuBZYHVp5XRKlxmOaOl5g1oXT6EFdVon8xYPoUvkW1N_e05O7-hnqk7UQ=h310"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        let selfW = self.frame.size.width
        let imageH : CGFloat = 200
        
        self.imageTableView = UITableView(frame: CGRect(x: 0, y: 0, width: imageH, height: selfW), style: .plain)
        self.imageTableView?.center = CGPoint(x: selfW / 2, y: imageH / 2)
        self.imageTableView?.register(GameImageCell.self, forCellReuseIdentifier: GameImageCell.className)
        self.imageTableView?.delegate = self
        self.imageTableView?.dataSource = self
        self.imageTableView?.bounces = false
//        self.imageTableView?.isScrollEnabled = false
        self.imageTableView?.showsVerticalScrollIndicator = false
        self.imageTableView?.showsHorizontalScrollIndicator = false
        self.imageTableView?.transform = CGAffineTransform(rotationAngle: -.pi/2)
        self.addSubview(self.imageTableView!)
        
//        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: selfW, height: imageH))
//        scrollView.contentSize = CGSize(width: 2*selfW, height: 0)
//        scrollView.backgroundColor = UIColor.red
//        scrollView.bounces = false
//        self.addSubview(scrollView)
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: imageH + 20, width: selfW, height: 30))
        titleLabel.text = "简介"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(titleLabel)
        
        let htmlStr = "<p><b>重要：&nbsp;<a href=\"https://www.ispokemongoavailableyet.com/\">點擊查看最新可以遊玩的國家地區</a>（非官方）；本遊戲需Android 4.4或以上系統才可安裝。</b><br></p><p><br></p><p>「Pokémon GO」是Pokémon誕生二十週年的紀念作，由「Ingress」的開發商Niantic Labs提供的地理位置服務技術，使得玩家可以在現實的世界中，體驗到抓捕、交換、和用神奇寶貝戰鬥的樂趣。</p>"
        self.briefLabel = TTTAttributedLabel(frame: CGRect(x: 10, y: imageH + 50, width: selfW - 20, height: 100))
        do {
            let attrStr = try NSAttributedString(data: htmlStr.data(using: String.Encoding.unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            self.briefLabel?.setText(attrStr)
        } catch let error as NSError{
            print("\(error)")
        }
        self.briefLabel?.enabledTextCheckingTypes = NSTextCheckingAllSystemTypes
        self.briefLabel?.delegate = self
//        self.briefLabel?.activeLinkAttributes = [nsat]
        self.briefLabel?.textAlignment = .center
        self.briefLabel?.numberOfLines = 0
        self.briefLabel?.font = UIFont.systemFont(ofSize: 15)
        self.briefLabel?.lineBreakMode = .byWordWrapping
        self.briefLabel?.sizeToFit()
        self.addSubview(self.briefLabel!)
    }
    
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if clickLinkCallBack != nil{
            clickLinkCallBack!(url)
        }
    }
    
    
    //MARK: - table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : GameImageCell = self.imageTableView?.dequeueReusableCell(withIdentifier: GameImageCell.className) as! GameImageCell
        cell.setImage(urlString: imageArray[indexPath.row])
        cell.contentView.transform = CGAffineTransform(rotationAngle: .pi/2)
        return cell
    }
    
    
    //MARK: - table view delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.width / 3
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxOffset : CGFloat = CGFloat(imageArray.count - 3) * (self.imageTableView?.frame.size.width)! / 3
        if scrollView.contentOffset.y > maxOffset - 2 {
            scrollView.isScrollEnabled = false
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class GameImageCell : UITableViewCell {
    var gameImageView : UIImageView?
    static let className : String = "GameImageCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        self.gameImageView = UIImageView()
        self.contentView.addSubview(self.gameImageView!)
    }
    
    func setImage(urlString: String) {
        let url = URL(string: urlString)
        self.gameImageView?.kf.setImage(with: url)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gameImageView?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.height, height: self.bounds.size.width)
    }
    
    
    
}
