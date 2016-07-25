//
//  FriendsListViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/20.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit

class FriendsListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var MyFriendArray : NSArray = []
    let FriendsList = UITableView.init()
    

    
    override func viewDidLoad() {
        MyFriendArray = NIMSDK.sharedSDK().userManager.myFriends()!
        super.viewDidLoad()
        self.view.addSubview(FriendsList)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        FriendsList.delegate = self
        FriendsList.dataSource = self
        
        FriendsList.translatesAutoresizingMaskIntoConstraints = false
        let RConstraint = NSLayoutConstraint.init(item: FriendsList, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: self.view, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let XConstraint = NSLayoutConstraint.init(item: FriendsList, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let YConstraint = NSLayoutConstraint.init(item: FriendsList, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        let TopConstraint = NSLayoutConstraint.init(item: FriendsList, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.view.addConstraints([RConstraint,XConstraint,TopConstraint,YConstraint])
        
        
        // Do any additional setup after loading the view.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section  == 0)
        {return 1}
        else
        {return MyFriendArray.count}
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "contact")
        if(indexPath.section == 0)
        {cell.textLabel?.text = "新的朋友"}
        else
        {cell.textLabel?.text = MyFriendArray[indexPath.row].userId
            if(MyFriendArray[indexPath.row].avatarUrl != nil)
            {       cell.imageView?.image   = UIImage.init(CIImage: CIImage.init(contentsOfURL: NSURL.init(string: (MyFriendArray[indexPath.row].avatarUrl)!!)! )!)            }
            else
            {       cell.imageView?.image  = UIImage(named: "avatar_user")!            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let session = NIMSession.init(MyFriendArray[indexPath.row].userId, type: .P2P)
        let SesVC = SessionViewController.init(session: session)
        SesVC.title = session.sessionId
        self.navigationController?.pushViewController(SesVC, animated: true)
        
    }
}
