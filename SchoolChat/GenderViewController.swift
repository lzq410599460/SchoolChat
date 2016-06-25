//
//  GenderViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/25.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit

class GenderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let gender = UITableView.init()
    let User = NIMSDK.sharedSDK().userManager.userInfo(NIMSDK.sharedSDK().loginManager.currentAccount())
    var UGender = 0
    
    func TouchDown ()
    {
        NIMSDK.sharedSDK().userManager.updateMyUserInfo([NIMUserInfoUpdateTag.Gender.rawValue :  "\(NIMUserGender.Female)" ],completion: { (error) in ()} )
        self.navigationController?.popToRootViewControllerAnimated(true)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(gender)
        self.navigationController?.navigationBar.topItem?.title = "取消"
        self.view.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        let Comp = UIBarButtonItem.init(title: "完成", style:UIBarButtonItemStyle.Plain, target: self, action: #selector(GenderViewController.TouchDown) )
        self.navigationItem.rightBarButtonItem = Comp
        
        gender.dataSource = self
        gender.delegate = self
        gender.backgroundColor = UIColor.clearColor()
        
        gender.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: gender, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 200).active = true
        let RConstraint = NSLayoutConstraint.init(item: gender, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: self.view, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let XConstraint = NSLayoutConstraint.init(item: gender, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let TopConstraint = NSLayoutConstraint.init(item: gender, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 50)
        self.view.addConstraints([RConstraint,XConstraint,TopConstraint])
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Gender")
        if(indexPath.row == 0)
            {   cell.textLabel?.text = "男"
                if(User?.userInfo?.gender == NIMUserGender.Male)
                {cell.accessoryType = .Checkmark}
        }
        else
            {   cell.textLabel?.text = "女"
                if(User?.userInfo?.gender == NIMUserGender.Male)
                {cell.accessoryType = .Checkmark}
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        gender.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        gender.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1-indexPath.row, inSection: 0))?.accessoryType = UITableViewCellAccessoryType.None
        UGender = indexPath.row + 1

        
    }
}
