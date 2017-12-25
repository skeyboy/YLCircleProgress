//
//  YLCircleProgress.swift
//  YLCircleProgressDemo
//
//  Created by liyulong on 2017/12/5.
//  Copyright © 2017年 杰能软件. All rights reserved.
//

import UIKit

class YLCircleProgress: UIView {
    var progress: Float?  = 0{
        didSet {
            self.buildUI()
            self.circle?.progress = self.progress!
        }
    }
    var circle: YLCircle?
    var percentLabel: UILabel?

  private  func buildUI() -> Void {

        let lineWidth = 0.1 * self.bounds.size.width
        if self.percentLabel == nil {
            self.percentLabel = UILabel(frame: self.bounds)
            self.percentLabel?.textColor = UIColor.red
            self.percentLabel?.textAlignment = .center
            percentLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            self.percentLabel?.text = "0%"
            self.addSubview(self.percentLabel!)

            self.circle = YLCircle(frame: self.bounds, lineWidth: Float(lineWidth))
            self.addSubview(self.circle!)
        }
        let percent: String = String(format: "%.2f%", self.progress! * 100)
        self.percentLabel?.text = "\(percent)%"
    }

     override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }

    convenience init(radius r: Float) {

        self.init(frame: CGRect(x: 0, y: 0, width: (2.0 * r).cgFloat, height: (2 * r).cgFloat))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
