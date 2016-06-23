//
//  LoginViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/16.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit
import CryptoSwift
import Foundation
import JSAnimatedImagesView
import MSWeakTimer

class LoginViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,JSAnimatedImagesViewDataSource {
    
    @IBAction func Fog(sender: AnyObject) {
        let alertController = UIAlertController.init(title: nil, message: "确认邮件已发送至邮箱", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
        dispatch_async(dispatch_get_main_queue(), {self.presentViewController(alertController, animated: true, completion: nil)})
    }
    
    
    @IBOutlet weak var forgot: UIButton!
    @IBOutlet weak var New: UIButton!
    
    @IBOutlet weak var LogB: UIButton!
    @IBOutlet weak var info: UITableView!
    @IBOutlet weak var back: JSAnimatedImagesView!

    
    
    

    
    //登陆成功后返回 MainTab 界面
    @IBAction func loging(sender: UIButton) {
       
        var username :String
        var password :String
        
        let Ucell =  info.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0)) as! TextInputTableViewCell
        let Pcell =  info.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0)) as! TextInputTableViewCell
        username = Ucell.TextField.text!
        password = Pcell.TextField.text!
        
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if(username != "")
        {
            
            appdelegate.connect(username , password: password)
            {
            //储存自动登录信息
        let AccountInfo = NSUserDefaults.standardUserDefaults()
            AccountInfo.setObject(username, forKey: "account")
            AccountInfo.setObject(password, forKey : "pass")
            
            //转换到MainTab界面
           let MainSB = UIStoryboard.init(name: "Main", bundle: nil)
           let MainVC = MainSB.instantiateViewControllerWithIdentifier("MainTab") as! UITabBarController
            appdelegate.window?.rootViewController = MainVC
            }
        }
        else{print("填入完整信息")}

    }
    
    override func viewDidLoad() {
        back.timePerImage = 10.0
        back.dataSource = self
        
        info.backgroundColor = UIColor.clearColor()
        
        LogB.backgroundColor = UIColor.init(red: 120, green: 120, blue: 240, alpha: 0.4)
        forgot.backgroundColor = UIColor.clearColor()
        New.backgroundColor = UIColor.clearColor()
        
        New.alpha = 0.6
        forgot.alpha = 0.6
       
        
    }
   
    
    // 背景动画数据设置
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        let image : UIImage
        switch index{
        case 0:
            image = UIImage.init(named: "11")!
        default:
            image = UIImage.init(named: "11")!
        }
        
        return image
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 2
    }
    
    
    
    
    // Table输入框数据
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextInputCell") as! TextInputTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.TextField.delegate = self
        
        if(indexPath.row == 0)
        {
        cell.config("", prompt: "Username")
        }
        else
        {
        cell.config("", prompt: "Password")
        }
            return cell
    }
    

    
    
    
    
}
