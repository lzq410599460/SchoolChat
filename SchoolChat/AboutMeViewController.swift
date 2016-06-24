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
    

    //退出按钮
    
    /*@IBAction func signout(sender: AnyObject) {
        
        //清空用户账户信息
        let CurrentAccount = NSUserDefaults.standardUserDefaults()
        CurrentAccount.setObject("", forKey: "account")
        CurrentAccount.setObject("", forKey: "pass")
        
        
        //返回登陆界面
        let LoginSB = UIStoryboard.init(name: "Login", bundle: nil)
        let LoginVC = LoginSB.instantiateViewControllerWithIdentifier("log") as! LoginViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = LoginVC
        
        
    }*/
    
    
    //@IBOutlet weak var MyTabView: UITableView!
    

    

 
    
    
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
                    cell.detailTextLabel?.text = ""
                }
                else if(indexPath.row == 1)
                {
                    cell.textLabel?.text = "Email"
                    cell.detailTextLabel?.text = ""
                }
                else
                {
                    cell.textLabel?.text = "Gender"
                    cell.detailTextLabel?.text = ""
                
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
        
        if(indexPath.section == 1 && indexPath.row == 1)
            {
            let NicknameVC = UIViewController.init()
            let textField = UITextField.init(frame: CGRectMake(0, 0, 200, 40))
            let textView = UIView.init(frame: CGRectMake(0, 0, 200, 40))
            textField.text = user?.userInfo?.nickName
            NicknameVC.view.addSubview(textView)
                
                self.navigationController?.pushViewController(NicknameVC, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0)
        { return 80 }
        else
        { return 44 }
    }
    
    
}
