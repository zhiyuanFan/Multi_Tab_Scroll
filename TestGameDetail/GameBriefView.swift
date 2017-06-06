//
//  GameBriefView.swift
//  TestGameDetail
//
//  Created by Jason Fan on 2017/6/1.
//  Copyright © 2017年 jason. All rights reserved.
//

import UIKit
import Kingfisher
import DTCoreText
import SnapKit


class GameBriefView: UIView,
UITableViewDelegate,
UITableViewDataSource,
DTAttributedTextContentViewDelegate
{
    var imageTableView: UITableView?
    var titleLabel: UILabel?
    var abilityView: PentagonView?
    var briefLabel: DTAttributedLabel?
    var clickLinkCallBack: ((URL)->Void)?

    let imageUrlArray = [
//        "https://d2jcw5q7j4vmo4.cloudfront.net/G5nHPFpBoG16_j3kMeS0ja6WosDgvXojrvxLxUe3Cr2tcQZxkmwBjZiaUSkI1YQn96Ml=h310",
//        "https://d2jcw5q7j4vmo4.cloudfront.net/z8JvumCCNE2ASr6RHIesmG4vTmWllZvLEd8Zn1W4dy1KIF6y7sMC_AK6ObDPChxtoU4=h310",
        "https://d2jcw5q7j4vmo4.cloudfront.net/2nTHkuiXeIpFK8ZPdb9aQbqQbER21c4Co8NCZVKhtbR_bY_rbJqi5aHKH7fKLvPxnOMW=h310",
        "https://d2jcw5q7j4vmo4.cloudfront.net/-FsKS0G17z5mCs65h6sSWPWZL-bLLjSeBLnXAadmoNmrs1bUotrbSB2Sf-IWJVilT90=h310",
        "https://d2jcw5q7j4vmo4.cloudfront.net/UJsqbNSI3dFLNeVw0qGYdDNz3uvzrKOw9r0DHQ0KZigwrKfFyiLSFjSTkI_DBdYz2yt-=h310",
        "https://d2jcw5q7j4vmo4.cloudfront.net/0IwcQSjYc_ZWEkt4uoaNjz3-zSmWolDJQHOP8e60uziUObuYbAHrauqci1vw01ctNIA=h310"]
    
    var imageWidthArray = [CGFloat]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        initImageWidthArray(imageArray: imageUrlArray)
    }
    
    func initImageWidthArray(imageArray: Array<String>) {
        let queue = DispatchQueue(label: "imageWidthArray")
        queue.async {
            for imageUrl in imageArray {
                let url = URL(string: imageUrl)
                if url != nil {
                    let imageData = (try? Data(contentsOf: url!))
                    if imageData != nil {
                        let image = UIImage(data: imageData!)
                        self.imageWidthArray.append((image?.size.width)!)
                    }
                }
            }
            DispatchQueue.main.async {
                self.imageTableView?.reloadData()
            }
        }
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
        self.imageTableView?.showsVerticalScrollIndicator = false
        self.imageTableView?.showsHorizontalScrollIndicator = false
        self.imageTableView?.transform = CGAffineTransform(rotationAngle: -.pi/2)
        self.addSubview(self.imageTableView!)
        
        self.titleLabel = UILabel(frame: CGRect(x: 10, y: imageH + 20, width: selfW, height: 30))
        self.titleLabel?.text = "简介"
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(self.titleLabel!)
        
        let htmlStr = "<p><b>重要：&nbsp;<a href=\"https://www.ispokemongoavailableyet.com/\">點擊查看最新可以遊玩的國家地區</a>（非官方）；本遊戲需Android 4.4或以上系統才可安裝。</b><br></p><p><br></p><p>「Pokémon GO」是Pokémon誕生二十週年的紀念作，由「Ingress」的開發商Niantic Labs提供的地理位置服務技術，使得玩家可以在現實的世界中，體驗到抓捕、交換、和用神奇寶貝戰鬥的樂趣。</p>"
        let data: Data? = htmlStr.data(using: String.Encoding.utf8)
        let attrString = NSAttributedString(htmlData: data,options: createCoreTextOptions(), documentAttributes: nil)
        
        let moreData : Data? = "<a href=\"https://loadMore.com/\">...更多</a>".data(using: String.Encoding.utf8)
        let truncationStr = NSAttributedString(htmlData: moreData, options: createCoreTextOptions(), documentAttributes: nil)

        
        self.briefLabel = DTAttributedLabel()
        self.briefLabel?.numberOfLines = 5
        self.briefLabel?.backgroundColor = UIColor.clear
        self.briefLabel?.attributedString = attrString
        self.briefLabel?.delegate = self
        self.briefLabel?.truncationString = truncationStr
        self.briefLabel?.lineBreakMode = .byWordWrapping
        self.addSubview(self.briefLabel!)
        
        self.abilityView = PentagonView(frame: CGRect(x: 0, y: 0, width: selfW, height: 300), radius: 100)
        self.abilityView?.backgroundColor = UIColor.clear
        self.addSubview(self.abilityView!)
        
        setupUI()
        
    }
    
    func setupUI() {
        let selfW = self.frame.size.width
        
        self.briefLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(10)
            make.left.equalTo(10)
            make.width.equalTo(selfW - 20)
            make.height.equalTo(200)
        })
        
        self.abilityView?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.briefLabel?.snp.bottom)!).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(selfW)
            make.height.equalTo(300)
        })
    }
    
    //MARK: - DTAttributedTextContentViewDelegate
    func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!, viewFor string: NSAttributedString!, frame: CGRect) -> UIView! {
        var attributes: [AnyHashable: Any] = string.attributes(at: 0, effectiveRange: nil)
        let URL: URL? = (attributes[DTLinkAttribute] as? URL)
        let identifier: String? = (attributes[DTGUIDAttribute] as? String)
        let button = DTLinkButton(frame: frame)
        button.url = URL
        button.minimumHitSize = CGSize(width: CGFloat(25), height: CGFloat(25))
        // adjusts it's bounds so that button is always large enough
        button.guid = identifier
        button.addTarget(self, action: #selector(self.linkPushed(button:)), for: .touchUpInside)
        
        return button
    }
    
    func linkPushed(button: DTLinkButton) {
        if  button.url == nil {
            self.briefLabel?.numberOfLines = 0
            return
        }
        
        if clickLinkCallBack != nil{
            clickLinkCallBack!(button.url)
        }
    }
    
    func createCoreTextOptions() -> Dictionary<String, Any> {
        let options = [
                       DTDefaultLinkColor: UIColor(red: 117.0/255.0, green: 191.0/255.0, blue: 198.0/255.0, alpha: 1),
                       DTLinkHighlightColorAttribute: UIColor.red,
                       DTLinkAttribute : UIFont.systemFont(ofSize: 13),
                       DTDefaultFontSize: 15] as [String : Any]
        
        return options
    }
    

    
    
    //MARK: - table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageUrlArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : GameImageCell = self.imageTableView?.dequeueReusableCell(withIdentifier: GameImageCell.className) as! GameImageCell
        cell.setImage(urlString: imageUrlArray[indexPath.row])
        cell.contentView.transform = CGAffineTransform(rotationAngle: .pi/2)
        return cell
    }
    
    
    //MARK: - table view delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.imageWidthArray.count == self.imageUrlArray.count {
            return self.imageWidthArray[indexPath.row]
        }
        return tableView.frame.size.width/3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click \(indexPath.row)")
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
        self.gameImageView?.isUserInteractionEnabled = true
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
    
    override var frame:CGRect{
        
        didSet {
            var newFrame = frame
            newFrame.size.height -= 5
            super.frame = newFrame
        }
    }
    
}
