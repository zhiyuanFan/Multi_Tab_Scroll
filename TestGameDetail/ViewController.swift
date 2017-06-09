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
    var headView : GameHeaderView?
    var vScrollView : UIScrollView?
    
    var hScrollView : UIScrollView?
    var showTabView : TabView?
    var hiddenTabView : TabView?
    
    var pageOneView : GameBriefView?
    var pageThreeView : NewsListView?
    
    let screenW : CGFloat = UIScreen.main.bounds.size.width
    let screenH : CGFloat = UIScreen.main.bounds.size.height
    let headH : CGFloat = UIScreen.main.bounds.size.height * 0.3
    let tabH : CGFloat = 30
    let sliderH : CGFloat = 2
    let titleArray = ["详情","相关文章"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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
        self.vScrollView?.showsVerticalScrollIndicator = false
        self.view.addSubview(self.vScrollView!)
        
        self.headView = GameHeaderView(frame: CGRect(x: 0, y: 0, width: screenW, height: headH))
        self.headView?.backgroundColor = UIColor.white
        self.vScrollView?.addSubview(self.headView!)
        
        self.showTabView = TabView(frame: CGRect(x: 0, y: headH, width: screenW, height: tabH))
        self.showTabView?.setTitleArray(titleArray: titleArray)
        self.showTabView?.tabClickBlock = { (tabName) in
            self.tabButtonCallBack(tabName: tabName)
        }
        self.vScrollView?.addSubview(self.showTabView!)
        
        self.hiddenTabView = TabView(frame: CGRect(x: 0, y: 64, width: screenW, height: tabH))
        self.hiddenTabView?.isHidden = true
        self.hiddenTabView?.tabClickBlock = { (tabName) in
            self.tabButtonCallBack(tabName: tabName)
        }
        self.hiddenTabView?.setTitleArray(titleArray: titleArray)
        self.view.addSubview(self.hiddenTabView!)
        
        self.hScrollView = UIScrollView(frame: CGRect(x: 0, y: headH + 10 + tabH, width: screenW, height: screenH - headH - 10 - tabH))
        self.hScrollView?.contentSize = CGSize(width: screenW * 2, height: 0)
        self.hScrollView?.delegate = self
        self.hScrollView?.bounces = false
        self.hScrollView?.showsHorizontalScrollIndicator = false
        self.hScrollView?.isPagingEnabled = true
        self.vScrollView?.addSubview(self.hScrollView!)
        
        self.pageOneView = GameBriefView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH * 2))
        self.pageOneView?.clickLinkCallBack = { (url: URL) -> Void in
            let webVC = GameWebViewController()
            webVC.url = url
            self.navigationController?.pushViewController(webVC, animated: true)
        }
        self.pageOneView?.clickMoreCallBack = {
            let viewH = self.getPageOneHeight()
            let hScrollY : CGFloat = self.headH + 10 + self.tabH
            self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: self.screenW, height: viewH)
            self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
            self.view.setNeedsUpdateConstraints()
            UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: UInt(7<<16)), animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        self.pageThreeView = NewsListView(frame: CGRect(x: screenW, y: -10, width: screenW, height: screenH - 64 - 20))
        self.pageThreeView?.listView.isScrollEnabled = false
        self.hScrollView?.addSubview(self.pageThreeView!)
        
        let hScrollY : CGFloat = headH + 10 + tabH
        self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: getPageOneHeight())
        self.vScrollView?.contentSize = CGSize(width: 0, height: (self.hScrollView?.frame.size.height)! + hScrollY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - page one height
    func getPageOneHeight() -> CGFloat {
        self.pageOneView?.backgroundColor = UIColor.clear
        self.hScrollView?.addSubview(self.pageOneView!)
        let maxY : CGFloat = (self.pageOneView?.abilityView?.frame.maxY)!
        return maxY
    }
    
    //MARK: - TAB Button 点击回调方法
    func tabButtonCallBack(tabName: String) {
        if tabName == "Detail" {
            self.hScrollView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        } else {
            self.hScrollView?.setContentOffset(CGPoint(x: screenW, y: 0), animated: true)
        }
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
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == self.hScrollView {
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.hScrollView {
            let index : Int = Int(scrollView.contentOffset.x / screenW)
            var viewH : CGFloat = 0.0
            let hScrollY : CGFloat = headH + 10 + tabH
            switch index {
            case 0:
                viewH = getPageOneHeight()
                self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: viewH)
                self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
                self.pageOneView?.imageTableView?.isScrollEnabled = true
                self.showTabView?.detailButton?.isSelected = true
                self.hiddenTabView?.detailButton?.isSelected = true
                self.showTabView?.newsButton?.isSelected = false
                self.hiddenTabView?.newsButton?.isSelected = false
            default:
                viewH = (self.pageThreeView?.listView.contentSize.height)!
                if viewH < screenH {
                    viewH = screenH
                }
                self.pageThreeView?.listView.frame = CGRect(x: 0, y: 0, width: screenW, height: viewH)
                self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: viewH)
                self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
                self.showTabView?.detailButton?.isSelected = false
                self.hiddenTabView?.detailButton?.isSelected = false
                self.showTabView?.newsButton?.isSelected = true
                self.hiddenTabView?.newsButton?.isSelected = true
            }
        }
    }


}

