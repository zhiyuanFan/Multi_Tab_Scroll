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
//    var titleArray : Array<String>?
    var sliderView : UIView?
    let sliderH : CGFloat = 2.0
    
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
        
        print("self.frame : \(self.frame)")
        
        let titleW : CGFloat = screenW / CGFloat(titleArray.count)
        let titleH : CGFloat = self.frame.size.height - sliderH
        let titleCount : Int = titleArray.count
        for i in 0..<titleCount {
            let rect : CGRect = CGRect(x: CGFloat(i) * titleW, y: 0, width: titleW, height: titleH)
            let titleLabel : UILabel = UILabel(frame: rect)
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[i]
            self.addSubview(titleLabel)
        }
        
        self.sliderView = UIView(frame: CGRect(x: 0, y: selfH - sliderH, width: screenW / CGFloat(titleCount), height: sliderH))
        self.sliderView?.backgroundColor = UIColor.red
        self.addSubview(self.sliderView!)
    }
    
    
}
