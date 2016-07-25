//
//  RegisterViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/17.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit
import JSAnimatedImagesView
import MSWeakTimer
import Foundation

class RegisterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,JSAnimatedImagesViewDataSource {
    
    @IBAction func Fog(sender: AnyObject) {
        let alertController = UIAlertController.init(title: nil, message: "确认邮件已发送至邮箱", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
        dispatch_async(dispatch_get_main_queue(), {self.presentViewController(alertController, animated: true, completion: nil)})
    }
 
    
    @IBOutlet weak var BACK: JSAnimatedImagesView!
    @IBOutlet weak var Reg: UIButton!
 
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var Forgot: UIButton!
    @IBOutlet weak var info: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BACK.dataSource = self
        BACK.timePerImage = 10.0
        
        info.backgroundColor = UIColor.clearColor()
        Forgot.backgroundColor = UIColor.clearColor()
        Login.backgroundColor = UIColor.clearColor()
        Reg.backgroundColor = UIColor.init(red: 80, green: 200, blue: 80, alpha: 0.6)
        
        Forgot.alpha = 0.6
        Login.alpha = 0.6
        
        
    }
    
    
    
    
    
    
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 2
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        let image : UIImage
        
        switch index{
        case 0:
            image = UIImage.init(named: "55")!
        default:
            image = UIImage.init(named: "55-1")!
        }
        
        return image
    }
    
    
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Text") as! TextInputTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.TextField.delegate = self
        
        if(indexPath.row == 0)
        {
            cell.config("", prompt: "Username")
        }
        else if (indexPath.row == 1)
        {
            cell.config("", prompt: "Nickname")
        }
        else
        {
            cell.config("", prompt: "Password")
        }
        return cell
    }

   
  
    // 注册点击事件
    @IBAction func Regi(sender: AnyObject) {
        //1970标准时间戳
        let timeString = "\(NSDate().timeIntervalSince1970*1000)"
        
        //准备更新的信息
        let username = (info.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0)) as! TextInputTableViewCell).TextField.text!
        let Name     = (info.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0)) as! TextInputTableViewCell).TextField.text!
        let passward = (info.cellForRowAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0)) as! TextInputTableViewCell).TextField.text!
        let user     = "accid=\(username)&token=\(passward)&name=\(Name)"
        
        //标准http请求header
        let request        = NSMutableURLRequest(URL: NSURL(string: "https://api.netease.im/nimserver/user/create.action")!)
        request.HTTPMethod = "POST"
        
        request.addValue("0f5a5ed59a0fa44ec27c07edf2b1a2da", forHTTPHeaderField: "AppKey")
        request.addValue("182736458493", forHTTPHeaderField: "nonce")
        request.addValue(timeString, forHTTPHeaderField:"CurTime" )
        request.addValue(calc("c501c23f8d1a",num: "182736458493",cur: timeString), forHTTPHeaderField: "CheckSum" )
        request.addValue("application/x-www-form-urlencoded;charset = utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        
        //发送请求
        request.HTTPBody = user.dataUsingEncoding(NSUTF8StringEncoding)
        
        //消息返回
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else
            {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200
            {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            //用户名被使用
            if(responseString!.containsString("already register"))
            {
                let alertController = UIAlertController.init(title: nil, message: "用户名已被使用", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction.init(title: "知道了，我去换一个", style: UIAlertActionStyle.Default, handler: nil))
                dispatch_async(dispatch_get_main_queue(), {self.presentViewController(alertController, animated: true, completion: nil)})
            }
            
            //http返回字符串
            print("responseString = \(responseString!)")
        }
        task.resume()
        
    }
     
     
    
    //哈西 sha1加密算法
    func calc (appsecret:String,num:String,cur:String) -> String
    {
        
        let result = appsecret+num+cur
        return result.sha1()
    }
    
    
    
    

    


}
