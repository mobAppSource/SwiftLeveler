//
//  ViewController.swift
//  SwiftLeveler
//
//  Created by Master on 6/18/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {

    var iModel: UIImageView!
    var sld_vertical: UISlider!
    var sld_horizontal: UISlider!
    var txt_vertical: UILabel!
    var txt_horizontal: UILabel!
    
    var manager = MotionKit()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.init_views()
        //Action for coremotion
        self.manager.getAttitudeFromDeviceMotion(0.2) { (attitude) in
            if let motion = attitude as CMAttitude?{
//                self.view.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(motion.yaw), 0, 0, 1)
                let vert = Float(String(format: "%.0f", motion.pitch * 180 / M_PI))
                let hori = Float(String(format: "%.0f", motion.roll * 180 / M_PI))
                self.sld_vertical.value = vert!
                self.txt_vertical.text = String(format: "%.2fº", motion.pitch * 180 / M_PI)
                self.sld_horizontal.value = hori!
                self.txt_horizontal.text = String(format: "%.2fº", motion.roll * 180 / M_PI)
            }
        }
    }
    func init_views()
    {
        let wView = self.view.frame.size.width
        let hView = self.view.frame.size.height
        self.iModel = UIImageView(frame: CGRect(x: wView/2-70, y: hView/2-90, width: 140, height: 180))
        self.iModel.image = UIImage(named: "11.png")
        self.iModel.contentMode = .ScaleAspectFit
        self.view.addSubview(self.iModel)
        //Vertical slider
        self.sld_vertical = UISlider(frame: CGRect(x: 20, y: 20, width: hView - 40, height: 30))
        self.sld_vertical.userInteractionEnabled = false
        self.sld_vertical.continuous = true
        self.sld_vertical.minimumValue = -90
        self.sld_vertical.maximumValue = 90
        self.sld_vertical.center = CGPoint(x: 21, y: hView/2)
        self.sld_vertical.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        self.view.addSubview(self.sld_vertical)
        //Vertical value text
        self.txt_vertical = UILabel(frame: CGRect(x: 25, y: hView/2+15, width: 70, height: 30))
        self.txt_vertical.text = String(self.sld_vertical.value)
        self.txt_vertical.textAlignment = .Center
        self.view.addSubview(self.txt_vertical)
        //horizontal Slider
        self.sld_horizontal = UISlider(frame: CGRect(x: 20, y: hView - 38, width: wView - 40, height: 30))
        self.sld_horizontal.userInteractionEnabled = false
        self.sld_horizontal.minimumValue = -90
        self.sld_horizontal.maximumValue = 90
        self.sld_horizontal.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.sld_horizontal)
        //horizontal value text
        self.txt_horizontal = UILabel(frame: CGRect(x: wView/2 - 20, y: hView - 50, width: 70, height: -30))
        self.txt_horizontal.text = String(self.sld_horizontal.value)
        self.txt_horizontal.textAlignment = .Center
        self.view.addSubview(self.txt_horizontal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

