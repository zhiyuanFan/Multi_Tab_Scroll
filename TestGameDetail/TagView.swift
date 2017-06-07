//
//  TagView.swift
//  TestGameDetail
//
//  Created by Jason Fan on 2017/6/7.
//  Copyright © 2017年 jason. All rights reserved.
//

import UIKit

class TagView: UIView {
    
    var titleLabel: UILabel?
    let tagArray = ["精灵宝可梦","冒险"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        self.titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.size.width, height: 30))
        self.titleLabel?.text = "标签"
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(self.titleLabel!)

        addTagButton()
    }
    
    func addTagButton() {
        let baseTag = 100
        let tagBtnH = tagArray[0].size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13)]).height + 10
        var currentX: CGFloat = 10
        var currentY: CGFloat = 30
        var lineNum: Int = 0
        let tagMarginW: CGFloat = 10
        let tagMarginH: CGFloat = 10
        
        for i in 0..<tagArray.count {
            
            let tagName: String = tagArray[i]
            let tagBtnW = tagName.size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13)]).width + 10
            
            let tagButton = UIButton(type: .custom)
            tagButton.tag = baseTag + i
            tagButton.setTitle(tagArray[i], for: .normal)
            tagButton.setTitleColor(UIColor(red: 242.0/255.0, green: 168.0/255.0, blue: 56.0/255.0, alpha: 1.0), for: .normal)
            tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            tagButton.layer.cornerRadius = 5
            tagButton.layer.borderColor = UIColor(red: 242.0/255.0, green: 168.0/255.0, blue: 56.0/255.0, alpha: 1.0).cgColor
            tagButton.layer.borderWidth = 1.0
            tagButton.layer.masksToBounds = true
            
            if currentX + tagMarginW + tagBtnW > self.frame.size.width {
                lineNum += 1;
                currentX = 10;
                currentY += tagMarginH + tagBtnH;
            }
            
            let tagBtnX = currentX;
            let tagBtnY = currentY;
            currentX = tagBtnX + tagBtnW;
            
            tagButton.frame = CGRect(x: tagBtnX, y: tagBtnY, width: tagBtnW, height: tagBtnH)
            
            //下一个btn先加一下marginW
            currentX += tagMarginW
            
            self.addSubview(tagButton)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
