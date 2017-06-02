//
//  ViewController.swift
//  TestGameDetail
//
//  Created by Qoo App on 2017/5/25.
//  Copyright © 2017年 jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    //MARK: - property
    var headView : UIView?
    var vScrollView : UIScrollView?
    
    var hScrollView : UIScrollView?
    var showTabView : TabView?
    var hiddenTabView : TabView?
    
    var pageOneView : GameBriefView?
    var pageTwoView : PentagonView?
    var pageThreeView : NewsListView?
    
    let screenW : CGFloat = UIScreen.main.bounds.size.width
    let screenH : CGFloat = UIScreen.main.bounds.size.height
    let headH : CGFloat = UIScreen.main.bounds.size.height * 0.3
    let tabH : CGFloat = 30
    let sliderH : CGFloat = 2
    let titleArray = ["详情","评分","相关文章"]
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "游戏详情"
        setupSubViews()
    }
    
    func setupSubViews() {
        
        let vScrollViewRect = CGRect(x: 0, y: 64, width: screenW, height: screenH - 64)
        self.vScrollView = UIScrollView(frame: vScrollViewRect)
        self.vScrollView?.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
        self.vScrollView?.delegate = self
        self.view.addSubview(self.vScrollView!)
        
        self.headView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: headH))
        self.headView?.backgroundColor = UIColor.blue
        self.vScrollView?.addSubview(self.headView!)
        
        
        self.showTabView = TabView(frame: CGRect(x: 0, y: headH, width: screenW, height: tabH))
        self.showTabView?.setTitleArray(titleArray: titleArray)
        self.vScrollView?.addSubview(self.showTabView!)
        
        self.hiddenTabView = TabView(frame: CGRect(x: 0, y: 64, width: screenW, height: tabH))
        self.hiddenTabView?.isHidden = true
        self.hiddenTabView?.setTitleArray(titleArray: titleArray)
        self.view.addSubview(self.hiddenTabView!)
        
        self.hScrollView = UIScrollView(frame: CGRect(x: 0, y: headH + 10 + tabH, width: screenW, height: screenH - headH - 10 - tabH))
        self.hScrollView?.contentSize = CGSize(width: screenW * 3, height: 0)
        self.hScrollView?.delegate = self
        self.hScrollView?.bounces = false
        self.hScrollView?.isPagingEnabled = true
        self.vScrollView?.addSubview(self.hScrollView!)
        
        self.pageOneView = GameBriefView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        self.pageOneView?.clickLinkCallBack = { (url: URL) -> Void in
            let webVC = GameWebViewController()
            webVC.url = url
            self.navigationController?.pushViewController(webVC, animated: true)
        }
        self.pageOneView?.backgroundColor = UIColor.clear
        self.hScrollView?.addSubview(self.pageOneView!)
        
        self.pageTwoView = PentagonView(frame: CGRect(x: screenW, y: 0, width: screenW, height: screenH), radius: 100)
        self.pageTwoView?.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
        self.hScrollView?.addSubview(self.pageTwoView!)
        let TwoLabel = UILabel(frame: CGRect(x: 0, y: screenH - 30, width: screenW, height: 30))
        TwoLabel.text = "page two label"
        TwoLabel.textAlignment = .center
        self.pageTwoView?.addSubview(TwoLabel)
        
        self.pageThreeView = NewsListView(frame: CGRect(x: screenW * 2, y: -10, width: screenW, height: screenH - 64 - 20))
        self.pageThreeView?.listView.isScrollEnabled = false
        self.hScrollView?.addSubview(self.pageThreeView!)
        
        let hScrollY : CGFloat = headH + 10 + tabH
        self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: (self.pageOneView?.frame.size.height)!)
        self.vScrollView?.contentSize = CGSize(width: 0, height: (self.hScrollView?.frame.size.height)! + hScrollY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.hScrollView {
            
            let titleCount = titleArray.count
            let offsetX : CGFloat = scrollView.contentOffset.x
            let moveX : CGFloat = offsetX / CGFloat(titleCount)
            
            UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: UInt(7<<16)), animations: {
                self.showTabView?.sliderView?.frame = CGRect(x: moveX, y: self.tabH - self.sliderH, width: self.screenW / CGFloat(titleCount), height: self.sliderH)
                self.hiddenTabView?.sliderView?.frame = CGRect(x: moveX, y: self.tabH - self.sliderH, width: self.screenW / CGFloat(titleCount), height: self.sliderH)
            }, completion: nil)
            
        } else if scrollView == self.vScrollView {
            if scrollView.contentOffset.y > (headH + tabH / 2) {
                UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: UInt(7<<16)), animations: {
                    self.hiddenTabView?.isHidden = false
                    self.navigationItem.title = "阴阳师"
                }, completion: nil)
            } else {
                UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: UInt(7<<16)), animations: {
                    self.hiddenTabView?.isHidden = true
                    self.navigationItem.title = "游戏详情"
                }, completion: nil)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if scrollView == self.hScrollView {
            let index : Int = Int(scrollView.contentOffset.x / screenW)
            var viewH : CGFloat = 0.0
            let hScrollY : CGFloat = headH + 10 + tabH
            switch index {
            case 0:
                viewH = (self.pageOneView?.frame.size.height)!
                self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: viewH)
                self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
                self.pageOneView?.imageTableView?.isScrollEnabled = true
            case 1:
                viewH = (self.pageTwoView?.frame.size.height)!
                self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: viewH)
                self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
            default:
                viewH = (self.pageThreeView?.listView.contentSize.height)!
                self.pageThreeView?.listView.frame = CGRect(x: 0, y: 0, width: screenW, height: viewH)
                self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: viewH)
                self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
            }
        }
    }


}

