//
//  YLCircle.swift
//  YLCircleProgressDemo
//
//  Created by liyulong on 2017/12/5.
//  Copyright © 2017年 杰能软件. All rights reserved.
//

import UIKit

let endPointMargin = 1.0

class YLCircle: UIView {
    
    var  progress:Float?{
        didSet{
            self.progressLayer.strokeEnd = self.progress!.cgFloat
            self.updateEndPoint()
            self.progressLayer.removeAllAnimations()
        }
    }
    
    private var innerCircleEndColor:UIColor = UIColor.brown
    private var innerCircleStartColors:[UIColor] = [RGB(r: 255, g: 151, b: 0, alpha: 1.0).color,
                                                    RGB(r: 255, g: 203, b: 0, alpha: 1.0).color
    ]
    
    /// 剩余路径的颜色
    var circleEndColor:UIColor?{
        willSet{
            innerCircleEndColor = newValue!
        }
    }
    
    /// 划过的圆的边的渐变色
    var circleGradientColors:[UIColor]?{
        willSet{
            innerCircleStartColors = newValue as! [UIColor]
        }
    }
    
   
    
    var lineWidth: Float
  
    var path:UIBezierPath{
        let radius =  self.center.x - CGFloat(self.lineWidth/2.0)
        let path: UIBezierPath = UIBezierPath(arcCenter: self.center,
                                              radius: radius
            , startAngle: CGFloat(-0.5*Double.pi), endAngle: CGFloat(1.5*Double.pi), clockwise: true)
        
        return path
    }
    
    var progressLayer: CAShapeLayer
    
    var endPoint: UIImageView
    
    
     init(frame: CGRect, lineWidth width:Float) {
        self.lineWidth = width
        
        let pLayer = CAShapeLayer()
        progressLayer = pLayer

        
        self.endPoint  = UIImageView()
        endPoint.frame = CGRect(x: 0.cgFloat,
                                y: 0.cgFloat,
                                width: (self.lineWidth - Float(endPointMargin*2)).cgFloat,
                                height: (self.lineWidth - Float(endPointMargin*2)).cgFloat)
        endPoint.isHidden = false
        endPoint.backgroundColor = UIColor.black
        endPoint.image = UIImage(named:"endPoint.png")
        endPoint.layer.masksToBounds = true
        endPoint.layer.cornerRadius = endPoint.frame.size.width/2
        
        
        super.init(frame: frame)
        
        
        pLayer.lineWidth = self.lineWidth.cgFloat
        pLayer.fillColor = UIColor.clear.cgColor
        pLayer.strokeColor = UIColor.black.cgColor
        
        pLayer.lineCap = kCALineCapRound
        pLayer.strokeEnd = 0
        progressLayer.frame = self.frame
        progressLayer.path = path.cgPath
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        buildLayout()
    }
    func buildLayout() -> Void {
   
        let backLayer: CAShapeLayer = CAShapeLayer()
        backLayer.frame = self.bounds
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = innerCircleEndColor.cgColor
        backLayer.lineWidth = CGFloat(self.lineWidth)
        backLayer.path = path.cgPath
        backLayer.strokeEnd = 1
        
        self.layer.addSublayer(backLayer)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame
        
        
        gradientLayer.colors = [RGB(r: 255, g: 151, b: 0, alpha: 1.0).color.cgColor,
        RGB(r: 255, g: 203, b: 0, alpha: 1.0).color.cgColor
        ]
        
        gradientLayer.colors = self.innerCircleStartColors.map({ (color) -> CGColor in
            return color.cgColor
        })
        gradientLayer.startPoint = CGPoint(x: 0, y: 0   )
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.mask = self.progressLayer
        self.layer.addSublayer(gradientLayer)
        
        self.addSubview(self.endPoint)
    }
    
    func updateEndPoint() -> Void {
        
        let angle = Float(Double.pi*2)*self.progress!
        let radius = (self.bounds.size.width.float - self.lineWidth)/2.0
        let index = Double(angle)/(Double.pi/2)
        let needAngle = Float(Double(angle) - Double(Int(index))*(Double.pi/2)) //注意 通过index的取整之后的 总体的差额作为需要的弧度
        var x = Float(0), y = Float(0)
        switch Int(index) {
        case 0:
            x = radius + sin(needAngle)*radius
            y = radius - cos(needAngle)*radius
            break
        case 1:
            x = radius + cosf(needAngle)*radius;
            y = radius + sinf(needAngle)*radius;
            break
        case 2:
            x = radius - sinf(needAngle)*radius;
            y = radius + cosf(needAngle)*radius;
            break
        case 3:
            x = radius - cosf(needAngle)*radius;
            y = radius - sinf(needAngle)*radius;
            break
            
        default:
            break
        }
        var rect = endPoint.frame
        rect.origin.x = CGFloat(x.cgDouble + endPointMargin)
        rect.origin.y = CGFloat(y.cgDouble + endPointMargin)
        self.endPoint.frame = rect
        self.bringSubview(toFront: self.endPoint)
        self.endPoint.isHidden = false
        if self.progress == 0 || self.progress == 1 {
            self.endPoint.isHidden = true
        }
    }
   

}
