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
    var briefLabel: DTAttributedLabel?
    var tagView: TagView?
    var abilityView: PentagonView?
    
    
    //只为测试高度所用
    var briefHeightLabel: UILabel?
    //点击更多,更改scrollview的frame和contentsize
    var clickMoreCallBack: ((Void)->Void)?
    //点击链接跳转
    var clickLinkCallBack: ((URL)->Void)?

    let imageUrlArray = [
        "https://d2jcw5q7j4vmo4.cloudfront.net/dq_t7Is81-gkHYxKfAQ7PuLQBR-Qrte-7S1DsKFZnhaZATpibMSiw3aCrJzYik1x3IV5=h310",
        "https://d2jcw5q7j4vmo4.cloudfront.net/S97uuMKpsZXzQ70_lf-535aUHwN3pw98veYbHR0CduoNCD7nt9QuBqTPXrk916mNwnJ1=h310",
        "https://d2jcw5q7j4vmo4.cloudfront.net/UJsqbNSI3dFLNeVw0qGYdDNz3uvzrKOw9r0DHQ0KZigwrKfFyiLSFjSTkI_DBdYz2yt-=h310",
        "https://d2jcw5q7j4vmo4.cloudfront.net/22ySaopy8gQQelxKpUMUP56i9kAhnoONR4RmjEZ1AyvWqbO-ae_kO8Hi1zIqBfqNjFk=h310",
        "https://d2jcw5q7j4vmo4.cloudfront.net/J8kUfrUigeTuBZYHVp5XRKlxmOaOl5g1oXT6EFdVon8xYPoUvkW1N_e05O7-hnqk7UQ=h310"]
    
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
        
        let moreData : Data? = "<a href=\"https://loadmoreonclick/\">...更多  </a>".data(using: String.Encoding.utf8)
        let truncationStr = NSAttributedString(htmlData: moreData, options: createCoreTextOptions(), documentAttributes: nil)

        
        self.briefHeightLabel = UILabel()
        self.briefHeightLabel?.attributedText = attrString
        self.briefHeightLabel?.numberOfLines = 0
        self.briefHeightLabel?.lineBreakMode = .byWordWrapping
        self.briefHeightLabel?.isHidden = true
        self.addSubview(self.briefHeightLabel!)
        
        self.briefLabel = DTAttributedLabel(frame: CGRect(x: 10, y: imageH + 50, width: selfW - 20, height: 150))
        self.briefLabel?.numberOfLines = 5
        self.briefLabel?.backgroundColor = UIColor.clear
        self.briefLabel?.attributedString = attrString
        self.briefLabel?.delegate = self
        self.briefLabel?.truncationString = truncationStr
        self.briefLabel?.lineBreakMode = .byWordWrapping
        self.addSubview(self.briefLabel!)
        
        self.tagView = TagView(frame: CGRect(x: 10, y: imageH + 210, width: selfW, height: 80))
        self.addSubview(self.tagView!)
        
        self.abilityView = PentagonView(frame: CGRect(x: 0, y: imageH + 300, width: selfW, height: 340), radius: 100)
        self.abilityView?.backgroundColor = UIColor.clear
        self.addSubview(self.abilityView!)
        print("1--max y : \(self.abilityView?.frame ?? CGRect.zero)")
        
        setupUI()
    }
    
    func setupUI() {
        let selfW = self.frame.size.width
        
        self.tagView?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.briefLabel?.snp.bottom)!).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(selfW)
            make.height.equalTo(80)
        })
        
        self.abilityView?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.tagView?.snp.bottom)!).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(selfW)
            make.height.equalTo(340)
        })
        print("2--max y : \(self.abilityView?.frame ?? CGRect.zero)")
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
        //点击更多,更改约束
        if button.url == nil {
            updateLabelConstraints()
            return
        }
        //点击正常的URL 进行跳转
        if clickLinkCallBack != nil{
            clickLinkCallBack!(button.url)
        }
    }
    
    func updateLabelConstraints() {
        let selfW = self.frame.size.width
        let labelHeight = getLableHeight(label: self.briefHeightLabel!)
        self.briefLabel?.numberOfLines = 0
        self.briefLabel?.snp.updateConstraints({ (make) in
            make.top.equalTo((self.titleLabel?.snp.bottom)!).offset(10)
            make.left.equalTo(10)
            make.width.equalTo(selfW - 20)
            make.height.equalTo(labelHeight)
        })
        
        self.setNeedsUpdateConstraints()
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: UInt(7<<16)), animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        if clickMoreCallBack != nil {
            clickMoreCallBack!()
        }
    }
    
    func createCoreTextOptions() -> Dictionary<String, Any> {
        let options = [
                       DTUseiOS6Attributes: true,
                       DTDefaultLinkDecoration: false,
                       DTDefaultLinkColor: UIColor(red: 117.0/255.0, green: 191.0/255.0, blue: 198.0/255.0, alpha: 1),
                       DTLinkHighlightColorAttribute: UIColor.red,
                       DTLinkAttribute : UIFont.systemFont(ofSize: 13),
                       DTDefaultFontSize: 15] as [String : Any]
        
        return options
    }
    
    //MARK: - customer func
    func getLableHeight(label: UILabel) -> CGFloat {
        let constraint = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        var size = CGSize.zero
        let context = NSStringDrawingContext()
        let boundingBox: CGSize = label.attributedText!.boundingRect(with: constraint, options: .usesLineFragmentOrigin, context: context).size
        size = CGSize(width: CGFloat(ceil(boundingBox.width)), height: CGFloat(ceil(boundingBox.height)))
        return size.height
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
