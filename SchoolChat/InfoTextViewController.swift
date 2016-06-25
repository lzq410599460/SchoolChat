//
//  InfoTextViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/24.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit

class InfoTextViewController: UIViewController{
    
        let TextContent = UIView.init()
        let TextField = UITextField.init()
    
        let userID = NIMSDK.sharedSDK().loginManager.currentAccount()
    
        let user = NIMSDK.sharedSDK().userManager.userInfo(NIMSDK.sharedSDK().loginManager.currentAccount())

  
    
    func config (name: String, contant: String) {
        TextField.text = contant
        self.navigationItem.title = name
    }
    
    func TouchDown()
     {
        switch self.navigationItem.title! {
        case "Nickname":
            NIMSDK.sharedSDK().userManager.updateMyUserInfo([NIMUserInfoUpdateTag.Nick.rawValue : TextField.text!],completion: { (error) in ()} )
            self.navigationController?.popToRootViewControllerAnimated(true)
        case "Signature":
            NIMSDK.sharedSDK().userManager.updateMyUserInfo([NIMUserInfoUpdateTag.Sign.rawValue : TextField.text!],completion: { (error) in ()} )
            self.navigationController?.popToRootViewControllerAnimated(true)
        case "Email":
            let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
            if(predicate.evaluateWithObject(TextField.text))
            {
            NIMSDK.sharedSDK().userManager.updateMyUserInfo([NIMUserInfoUpdateTag.Email.rawValue : TextField.text!],completion: { (error) in ()} )
            self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else
            {
                let alertController = UIAlertController.init(title: nil, message: "邮箱格式不正确", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
                dispatch_async(dispatch_get_main_queue(), {self.presentViewController(alertController, animated: true, completion: nil)})
            }
        default:
            print("更新信息出错")
        }
        
    }
   
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "取消"
        self.view.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        let Comp = UIBarButtonItem.init(title: "完成", style:UIBarButtonItemStyle.Plain, target: self, action: #selector(InfoTextViewController.TouchDown) )
    
        self.navigationItem.rightBarButtonItem = Comp
        
        TextContent.addSubview(TextField)
        TextField.translatesAutoresizingMaskIntoConstraints = false
        TextField.backgroundColor = UIColor.clearColor()
        
        NSLayoutConstraint(item: TextField, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 44).active = true
        let RConstraint = NSLayoutConstraint.init(item: TextField, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: TextContent, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: -20)
        let XConstraint = NSLayoutConstraint.init(item: TextField, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: TextContent, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let YConstraint = NSLayoutConstraint.init(item: TextField, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: TextContent, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        TextContent.addConstraints([RConstraint,XConstraint,YConstraint])
        
        
        
        
        
        
        self.view.addSubview(TextContent)
        TextContent.backgroundColor = UIColor.whiteColor()
        TextContent.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint(item: TextContent, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 44).active = true
        let RightConstraint = NSLayoutConstraint.init(item: TextContent, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: self.view, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let CenterXConstraint = NSLayoutConstraint.init(item: TextContent, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let HeightConstraint = NSLayoutConstraint.init(item: TextContent, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 120)
        self.view.addConstraints([RightConstraint,CenterXConstraint,HeightConstraint])
 
    }




}
