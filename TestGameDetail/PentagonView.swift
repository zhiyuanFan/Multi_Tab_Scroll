//
//  PentagonView.swift
//  TestGameDetail
//
//  Created by Qoo App on 2017/5/27.
//  Copyright © 2017年 jason. All rights reserved.
//


import UIKit

class PentagonView : UIView {

    let kCos36 : CGFloat = 0.80901699437495
    let kSin36 : CGFloat = 0.58778525229247
    let kCos18 : CGFloat = 0.95105651629515
    let kSin18 : CGFloat = 0.30901699437495
    let defaultScaleArray : Array<CGFloat> = [1,1,1,1,1]
    
    var centerPoint : CGPoint?
    var pRadius : CGFloat?
    var pointArray = Array<CGPoint>()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect , radius: CGFloat) {
        self.init(frame: frame)
        self.centerPoint = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.pRadius = radius
        self.pointArray = createOrderPointArray(radius: self.pRadius!, scaleArray: defaultScaleArray)
    }
    
    override func draw(_ rect: CGRect) {
       
        let context = UIGraphicsGetCurrentContext()
        
        
        drawPentagon(context: context!)
        setupAbilityViews()
        
        drawValueArea(context: context!)
    }
    
    //创建顶点数组,有序(顺时针方向)
    func createOrderPointArray(radius: CGFloat, scaleArray: Array<CGFloat>) -> Array<CGPoint>{
//        self.pointArray.removell()
        var pointArray = Array<CGPoint>()
        
        let centerX = (self.centerPoint?.x)!
        let centerY = (self.centerPoint?.y)!

        //top point
        pointArray.append(CGPoint(x: centerX, y: centerY - radius * scaleArray[0]))
        //top right point
        pointArray.append(CGPoint(x: centerX + radius*kCos18*scaleArray[1], y: centerY - radius*kSin18*scaleArray[1]))
        //down right point
        pointArray.append(CGPoint(x: centerX + radius*kSin36*scaleArray[2], y: centerY + radius*kCos36*scaleArray[2]))
        //down left point
        pointArray.append(CGPoint(x: centerX - radius*kSin36*scaleArray[3], y: centerY + radius*kCos36*scaleArray[3]))
        //top left point
        pointArray.append(CGPoint(x: centerX - radius*kCos18*scaleArray[4], y: centerY - radius*kSin18*scaleArray[4]))
        
        return pointArray
    }
    
    //画五边形
    func drawPentagon(context: CGContext) {
        context.move(to: self.pointArray[0])
        drawLine(context: context, pointArray: self.pointArray, fromCenter: false)
        context.closePath()
        context.setStrokeColor(UIColor.clear.cgColor)
        context.setFillColor(UIColor.white.cgColor)
        context.setLineWidth(1.0)
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        
        drawInnerLine(context: context)
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineWidth(1.0)
        context.drawPath(using: CGPathDrawingMode.stroke)
    }
    
    //画五边形内部线段
    func drawInnerLine(context: CGContext){
        drawLine(context: context, pointArray: self.pointArray, fromCenter: true)
    }
    
    //画评价值区域
    func drawValueArea(context: CGContext) {
        context.saveGState()

        let scaleArray : Array<CGFloat> = [0.5,0.6,0.7,0.8,0.5]
        let valuePointArray = createOrderPointArray(radius: self.pRadius!, scaleArray: scaleArray)
        context.move(to: valuePointArray[0])
        drawLine(context: context, pointArray: valuePointArray, fromCenter: false)
        context.closePath()
        context.setStrokeColor(UIColor.cyan.cgColor)
        let fillColor = UIColor(red: 0, green: 1.0, blue: 1.0, alpha: 0.3)
        context.setFillColor(fillColor.cgColor)
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        
        context.restoreGState()
    }
    
    //连线方法
    func drawLine(context:CGContext, pointArray: Array<CGPoint>, fromCenter: Bool) {
        for point in pointArray {
            if fromCenter {
                context.move(to: self.centerPoint!)
                context.addLine(to: point)
            } else {
                context.addLine(to: point)
            }
        }
        
        
    }
    
    //设置评分项
    func setupAbilityViews() {
        let imageWH : CGFloat = 25
        let fontW : CGFloat = 25
        let distance : CGFloat = 10 + imageWH / 2 + fontW / 2
        let titleArray = ["好看","好玩","想课","故事","好听"]
        let image = UIImage(named: "ability")
        let imageArray = [image,image,image,image,image]
        let tempPointArray = createOrderPointArray(radius: self.pRadius! + 20, scaleArray: defaultScaleArray)
        
        for i in 0..<5 {
            let point = tempPointArray[i]
            let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWH, height: imageWH))
            iconView.center = point
            iconView.image = imageArray[i]
            addSubview(iconView)
            
            let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: fontW, height: imageWH))
            titleLable.font = UIFont.systemFont(ofSize: 15)
            titleLable.text = titleArray[i]
            titleLable.sizeToFit()
            if i < 3 {
                titleLable.center = CGPoint(x: point.x + distance, y: point.y)
            } else {
                titleLable.center = CGPoint(x: point.x - distance, y: point.y)
            }
            addSubview(titleLable)
        }

    }
}
