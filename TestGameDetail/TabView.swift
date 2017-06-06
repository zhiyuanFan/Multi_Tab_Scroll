//
//  TabView.swift
//  TestGameDetail
//
//  Created by Qoo App on 2017/5/25.
//  Copyright © 2017年 jason. All rights reserved.
//

import Foundation
import UIKit

class TabView: UIView {

    var sliderView: UIView?
    let sliderH: CGFloat = 2.0
    var detailButton: UIButton?
    var newsButton: UIButton?
    var tabClickBlock: ((String)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTitleArray(titleArray: Array<String>) {
        guard titleArray.count > 0 else {
            return
        }
        
        let screenW : CGFloat = UIScreen.main.bounds.size.width
        let selfH : CGFloat = self.frame.size.height
        
        let titleW : CGFloat = screenW / CGFloat(titleArray.count)
        let titleH : CGFloat = self.frame.size.height - sliderH
        let titleCount : Int = titleArray.count
        
        let normalColor = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1)
        let selectedColor = UIColor(red: 117.0/255.0, green: 191.0/255.0, blue: 198.0/255.0, alpha: 1)
        
        self.detailButton = UIButton(frame: CGRect(x: 0, y: 0, width: titleW, height: titleH))
        self.detailButton?.titleLabel?.textAlignment = .center
        self.detailButton?.setTitle(titleArray[0], for: .normal)
        self.detailButton?.setTitleColor(normalColor, for: .normal)
        self.detailButton?.setTitleColor(selectedColor, for: .selected)
        self.detailButton?.isSelected = true
        self.detailButton?.tag = 101
        self.detailButton?.addTarget(self, action: #selector(self.tabButtonOnClick(button:)), for: .touchUpInside)
        self.addSubview(self.detailButton!)

        self.newsButton = UIButton(frame: CGRect(x: titleW, y: 0, width: titleW, height: titleH))
        self.newsButton?.titleLabel?.textAlignment = .center
        self.newsButton?.setTitle(titleArray[1], for: .normal)
        self.newsButton?.setTitleColor(normalColor, for: .normal)
        self.newsButton?.setTitleColor(selectedColor, for: .selected)
        self.newsButton?.tag = 102
        self.newsButton?.addTarget(self, action: #selector(self.tabButtonOnClick(button:)), for: .touchUpInside)
        self.addSubview(self.newsButton!)
        
        self.sliderView = UIView(frame: CGRect(x: 0, y: selfH - sliderH, width: screenW / CGFloat(titleCount), height: sliderH))
        self.sliderView?.backgroundColor = selectedColor
        self.addSubview(self.sliderView!)
    }
    
    func tabButtonOnClick(button: UIButton)  {
        
        self.detailButton?.isSelected = button.tag == 101 ? true : false
        self.newsButton?.isSelected = button.tag == 101 ? false : true
        
        if tabClickBlock != nil {
            let tabName = button.tag == 101 ? "Detail" : "News"
            tabClickBlock!(tabName)
        }
    }
    
    
}
