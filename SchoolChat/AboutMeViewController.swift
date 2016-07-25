//
//  AboutMeViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/16.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var info: UITableView!
    

    

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func viewWillAppear(animated: Bool) {
        info.reloadData()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        info.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
     
      
        // Do any additional setup after loading the view.
    }
    
    
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0)
        {return 1}
        else if (section == 1)
        {return 2}
        else if (section == 2)
        {return 3}
        else
        {return 1}
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == 2)
        {return 50}
        else if(section == 3)
        {return 20 }
        else{return 0}
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell
        let user = NIMSDK.sharedSDK().userManager.userInfo(NIMSDK.sharedSDK().loginManager.currentAccount())
        let image : UIImage
        if(indexPath.section == 0 )
        {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Avatar")
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.textLabel?.text = "头像"
            cell.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height + 40)
            
            if(user?.userInfo?.avatarUrl != nil)
                {         image = UIImage.init(CIImage: CIImage.init(contentsOfURL: NSURL.init(string: (user?.userInfo?.avatarUrl)!)! )!)            }
            else
                {            image = UIImage(named: "avatar_user")!            }
            
            let imageV = UIImageView.init(image: image)
            
            
            
            NSLayoutConstraint(item: imageV, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 70).active = true
            NSLayoutConstraint(item: imageV, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 70).active = true
            
            let RightConstraint = NSLayoutConstraint.init(item: imageV, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: cell, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: -40)
            let CenterConstraint = NSLayoutConstraint.init(item: imageV, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
            
            cell.addSubview(imageV)
            imageV.translatesAutoresizingMaskIntoConstraints = false
            cell.addConstraint(RightConstraint)
            cell.addConstraint(CenterConstraint)
            cell.accessoryType = .DisclosureIndicator
        }
            
        else if(indexPath.section == 1 || indexPath.section == 2)
        {
        
        cell = UITableViewCell.init(style: UITableViewCellStyle.Value1, reuseIdentifier: "infotext")
        cell.detailTextLabel?.textColor = UIColor.init(white: 0.5, alpha: 1)
        cell.textLabel?.textColor = UIColor.blackColor()
        
            
            if(indexPath.section == 1)
            {
                if (indexPath.row == 0)
                {
                    cell.textLabel?.text = "Account"
                    cell.detailTextLabel?.text = user?.userId
                }
                else
                {
                cell.textLabel?.text = "Nickname"
                    if( user!.userInfo?.nickName == nil)
                    { cell.detailTextLabel?.text = user?.userId }
                    else
                    {cell.detailTextLabel?.text = user!.userInfo?.nickName}
                }
            }
            else
            {
                if (indexPath.row == 0)
                {
                    cell.textLabel?.text = "Sign"
                    if( user!.userInfo?.sign == nil)
                    { cell.detailTextLabel?.text = ""}
                    else
                    {cell.detailTextLabel?.text = user!.userInfo?.sign}
                }
                else if(indexPath.row == 1)
                {
                    
                   
                        cell.textLabel?.text = "Email"
                        if( user!.userInfo?.email == nil)
                        { cell.detailTextLabel?.text = ""}
                        else
                        {cell.detailTextLabel?.text = user!.userInfo?.email}
                    
                }
                else
                {
                    cell.textLabel?.text = "Gender"
                   
                        if(user!.userInfo?.gender.rawValue == 2 )
                        {cell.detailTextLabel?.text = "女"}
                        else if (user?.userInfo?.gender.rawValue == 1 )
                        {cell.detailTextLabel?.text = "男"}
                        else
                        {cell.detailTextLabel?.text = "未知"}
                }
            }
            
        }
        
        else
        {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Logout")
            cell.textLabel?.text = "退出登录"
            cell.textLabel?.textAlignment = NSTextAlignment.Center
        }
        
        
        switch (indexPath.section ,indexPath.row) {
        case (3,0):
            break
        case (1,0):
            break
        default:
            cell.accessoryType = .DisclosureIndicator}
    return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = NIMSDK.sharedSDK().userManager.userInfo(NIMSDK.sharedSDK().loginManager.currentAccount())
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            let image :UIImage
            if(user?.userInfo?.avatarUrl != nil)
            {         image = UIImage.init(CIImage: CIImage.init(contentsOfURL: NSURL.init(string: (user?.userInfo?.avatarUrl)!)! )!)            }
            else
            {            image = UIImage(named: "avatar_user")!            }
            
            let imageVC = AvatarViewController.init()
            imageVC.config(image)
            self.navigationController?.pushViewController(imageVC, animated: true)
            
        case (1,1):
            let nick : String
            if( user!.userInfo?.nickName == nil)
                { nick = (user?.userId)! }
            else
                {nick = (user!.userInfo?.nickName)!}
            
            let NicknameVC = InfoTextViewController.init()
            NicknameVC.config("Nickname",contant: nick)
            self.navigationController?.pushViewController(NicknameVC, animated: true)
            
        case (2,0):
            let sign : String
            if( user!.userInfo?.sign == nil)
            { sign = "" }
            else
            {sign = (user!.userInfo?.sign)!}
            
            let SignVC = InfoTextViewController.init()
            SignVC.config("Signature",contant: sign)
            self.navigationController?.pushViewController(SignVC, animated: true)
            
        case (2,1):
            let email : String
            if( user!.userInfo?.email == nil)
            { email = "" }
            else
            {email = (user!.userInfo?.email)!}
            
            let EmailVC = InfoTextViewController.init()
            EmailVC.config("Email",contant: email)
            self.navigationController?.pushViewController(EmailVC, animated: true)
        
        case (2,2):
            let GenderVC = GenderViewController.init()
            self.navigationController?.pushViewController(GenderVC, animated: true)
            
        case (3,0):
            //清空用户账户信息
            let CurrentAccount = NSUserDefaults.standardUserDefaults()
            CurrentAccount.setObject("", forKey: "account")
            CurrentAccount.setObject("", forKey: "pass")
            
            //返回登陆界面
            let LoginSB = UIStoryboard.init(name: "Login", bundle: nil)
            let LoginVC = LoginSB.instantiateViewControllerWithIdentifier("log") as! LoginViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = LoginVC
        
        default:
            print("选择信息出错")
        }
 
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0)
        { return 80 }
        else
        { return 44 }
    }
    
    
}
