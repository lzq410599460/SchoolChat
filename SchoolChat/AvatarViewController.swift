//
//  AvatarViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/25.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit

class AvatarViewController: UIViewController {
    
    let imageV = UIImageView.init()
    
    func config(I: UIImage) {
        imageV.image = I
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.view.addSubview(imageV)
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: imageV, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: imageV, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0).active = true
        let RConstraint = NSLayoutConstraint.init(item: imageV, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: self.view, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let XConstraint = NSLayoutConstraint.init(item: imageV, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let YConstraint = NSLayoutConstraint.init(item: imageV, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        self.view.addConstraints([RConstraint,XConstraint,YConstraint])
        
        
    }

    
    
}
