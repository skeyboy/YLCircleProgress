//
//  ViewController.swift
//  YLCircleProgressDemo
//
//  Created by liyulong on 2017/12/5.
//  Copyright © 2017年 杰能软件. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var circle:YLCircleProgress?
    @IBAction func change(_ sender: Any) {
        let slider = sender as! UISlider
        circle?.progress = slider.value
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     let rect =   CGRect(x: 200,
               y: 200,
               width:200,
               height: 200)

        circle = YLCircleProgress(frame: rect)
        circle?.progress = 0.01
        self.view.addSubview(circle!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

