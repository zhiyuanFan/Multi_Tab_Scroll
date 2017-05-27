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
    
    var pageOneView : UIView?
    var pageTwoView : PentagonView?
    var pageThreeView : UIView?
    
    let screenW : CGFloat = UIScreen.main.bounds.size.width
    let screenH : CGFloat = UIScreen.main.bounds.size.height
    let headH : CGFloat = UIScreen.main.bounds.size.height * 0.3
    let tabH : CGFloat = 30
    let sliderH : CGFloat = 2
    let titleArray = ["详情","评分","相关推荐"]
    
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
        self.vScrollView?.backgroundColor = UIColor.lightGray
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
        self.hScrollView?.contentSize = CGSize(width: screenW * 4, height: 0)
        self.hScrollView?.delegate = self
        self.hScrollView?.isPagingEnabled = true
        self.vScrollView?.addSubview(self.hScrollView!)
        
        self.pageOneView = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH * 2))
        self.pageOneView?.backgroundColor = UIColor.cyan
        self.hScrollView?.addSubview(self.pageOneView!)
        let oneLabel = UILabel(frame: CGRect(x: 0, y: screenH * 2 - 30, width: screenW, height: 30))
        oneLabel.text = "page one label"
        oneLabel.textAlignment = .center
        self.pageOneView?.addSubview(oneLabel)
        
        self.pageTwoView = PentagonView(frame: CGRect(x: screenW, y: 0, width: screenW, height: screenH), radius: 100)
        self.pageTwoView?.backgroundColor = UIColor.white
        self.hScrollView?.addSubview(self.pageTwoView!)
        let TwoLabel = UILabel(frame: CGRect(x: 0, y: screenH - 30, width: screenW, height: 30))
        TwoLabel.text = "page two label"
        TwoLabel.textAlignment = .center
        self.pageTwoView?.addSubview(TwoLabel)
        
        self.pageThreeView = UIView(frame: CGRect(x: screenW * 2, y: 0, width: screenW, height: screenH * 1.5))
        self.pageThreeView?.backgroundColor = UIColor.yellow
        self.hScrollView?.addSubview(self.pageThreeView!)
        let threeLabel = UILabel(frame: CGRect(x: 0, y: screenH * 1.5 - 30, width: screenW, height: 30))
        threeLabel.text = "page three label"
        threeLabel.textAlignment = .center
        self.pageThreeView?.addSubview(threeLabel)
        
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
        } else {
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
            print("index : \(index)")
            var viewH : CGFloat = 0.0
            let hScrollY : CGFloat = headH + 10 + tabH
            switch index {
            case 0:
                viewH = (self.pageOneView?.frame.size.height)!
                self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: viewH)
                self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
            case 1:
                viewH = (self.pageTwoView?.frame.size.height)!
                self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: viewH)
                self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
            default:
                viewH = (self.pageThreeView?.frame.size.height)!
                self.hScrollView?.frame = CGRect(x: 0, y: hScrollY, width: screenW, height: viewH)
                self.vScrollView?.contentSize = CGSize(width: 0, height: hScrollY + viewH)
            }
        }
    }


}

