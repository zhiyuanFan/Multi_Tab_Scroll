//
//  GameHeaderView.swift
//  TestGameDetail
//
//  Created by Jason Fan on 2017/6/7.
//  Copyright © 2017年 jason. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class GameHeaderView: UIView {
    
    var gameIconView: UIImageView?
    var gameNameLabel: UILabel?
    var appNameLabel: UILabel?
    var gameCompanyBtn: UIButton?
    var btnContainer: UIView?
    var chatBtn: UIButton?
    var shareBtn: UIButton?
    var guideBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    func setupSubViews() {
        let iconUrl = URL(string: "https://d2jcw5q7j4vmo4.cloudfront.net/wPfLmWBJwsPdBhsFXc8X4QZOOvePWjoOBLFXXCwyegjRwYOuabmG5cynthlW0HDgy9s=w300")
        
        
        self.gameIconView = UIImageView()
        self.gameIconView?.kf.setImage(with: iconUrl)
        self.addSubview(self.gameIconView!)
        
        self.gameNameLabel = UILabel()
        self.gameNameLabel?.numberOfLines = 0
        self.gameNameLabel?.font = UIFont.systemFont(ofSize: 18)
        self.gameNameLabel?.lineBreakMode = .byWordWrapping
        self.gameNameLabel?.text = "精靈寶可夢GO/ 神奇寶貝GO/ 寵物小精靈GO/ 口袋妖怪GO"
        self.addSubview(self.gameNameLabel!)
        
        self.appNameLabel = UILabel()
        self.appNameLabel?.font = UIFont.systemFont(ofSize: 13)
        self.appNameLabel?.text = "Pokémon GO"
        self.addSubview(self.appNameLabel!)
        
        self.gameCompanyBtn = UIButton(type: .custom)
        self.gameCompanyBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        let attrString = NSAttributedString(string: "Niantic, Inc.", attributes: [ NSForegroundColorAttributeName : UIColor(red: 117.0/255.0, green: 191.0/255.0, blue: 198.0/255.0, alpha: 1), NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue])
        self.gameCompanyBtn?.setAttributedTitle(attrString, for: .normal)
        self.addSubview(self.gameCompanyBtn!)
        
        self.btnContainer = UIView()
        self.addSubview(self.btnContainer!)
        
        self.chatBtn = UIButton(type: .custom)
        self.chatBtn?.layer.cornerRadius = 5
        self.chatBtn?.layer.masksToBounds = true
        self.chatBtn?.setTitle("聊 天", for: .normal)
        self.chatBtn?.setTitleColor(UIColor.white, for: .normal)
        self.chatBtn?.backgroundColor = UIColor(red: 117.0/255.0, green: 191.0/255.0, blue: 198.0/255.0, alpha: 1)
        self.btnContainer?.addSubview(self.chatBtn!)
        
        self.shareBtn = UIButton(type: .custom)
//        self.shareBtn?.backgroundColor = UIColor.red
        self.shareBtn?.layer.cornerRadius = 5
        self.shareBtn?.layer.masksToBounds = true
        self.shareBtn?.setImage(UIImage(named: "share"), for: .normal)
        self.btnContainer?.addSubview(self.shareBtn!)
        
        self.guideBtn = UIButton(type: .custom)
//        self.guideBtn?.backgroundColor = UIColor.yellow
        self.guideBtn?.layer.cornerRadius = 5
        self.guideBtn?.layer.masksToBounds = true
        self.guideBtn?.setImage(UIImage(named: "guide"), for: .normal)
        self.btnContainer?.addSubview(self.guideBtn!)
        
        
        setupUI()
    }
    
    func setupUI() {
        self.gameIconView?.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 80, height: 80))
        })
        
        self.gameNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.gameIconView?.snp.top)!)
            make.left.equalTo((self.gameIconView?.snp.right)!).offset(20)
            make.right.equalTo(-20)
        })
        
        self.appNameLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.gameNameLabel?.snp.bottom)!)
            make.left.equalTo((self.gameIconView?.snp.right)!).offset(20)
        })
        
        self.gameCompanyBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.appNameLabel?.snp.bottom)!)
            make.left.equalTo((self.gameIconView?.snp.right)!).offset(20)
        })
        
        let btnContainerW: CGFloat = 200
        let btnContainerH: CGFloat = 30
        let btnMargin: CGFloat = 15
        let shareBtnW: CGFloat = btnContainerW/4 - btnMargin
        self.btnContainer?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.gameIconView?.snp.bottom)!).offset(40)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: btnContainerW, height: btnContainerH))
        })
        
        self.chatBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: btnContainerW/2, height: btnContainerH))
        })
        
        self.shareBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.left.equalTo((self.chatBtn?.snp.right)!).offset(btnMargin)
            make.size.equalTo(CGSize(width: shareBtnW, height: btnContainerH))
        })
        
        self.guideBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.left.equalTo((self.shareBtn?.snp.right)!).offset(btnMargin)
            make.size.equalTo(CGSize(width: shareBtnW, height: btnContainerH))
        })
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
