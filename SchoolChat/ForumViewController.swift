//
//  ForumViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/26.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit
import CKCircleMenuView

class ForumViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,CKCircleMenuDelegate {
    
    let ThreadList = UITableView.init()
    var circleMenuImageArray = Array<UIImage>()
    var tOptions = Dictionary<String, AnyObject>()
    
    //圆形按钮的触发函数
    func circleMenuActivatedButtonWithIndex(anIndex: Int32) {
        if(anIndex == 0)
        {
            let session = NIMSession.init("jcm2006", type: .P2P)           //session ID 要用accid  不是nickname
            let SesVC = SessionViewController.init(session: session)
            SesVC.title = session.sessionId
            self.navigationController?.pushViewController(SesVC, animated: true)
        }
        else
        {
            //加好友
        }
    }
        //点击图像进入帖子详细内容
    func TapI(sender: UITapGestureRecognizer)
    {
        let ThreadVC = ThreadViewController()
        self.navigationController?.pushViewController(ThreadVC, animated: true)
        
    }
            //点击头像触发的ck圆形menu
    func TapA(sender: UITapGestureRecognizer)
    {
        let cell = ThreadList.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: (sender.view?.tag)!))
        let tOrigin = sender.locationInView(cell)
        let CKV = CKCircleMenuView(atOrigin: tOrigin, usingOptions: tOptions, withImageArray: self.circleMenuImageArray)
        cell!.addSubview(CKV)
        CKV.delegate = self
        CKV.openMenu()
    }
    
    
    //ForumViewController 导航栏标题
    func config (title:String)  {
        self.title = title
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .BlackTranslucent
        self.navigationController?.navigationBar.translucent = false
        self.view.addSubview(ThreadList)
        
        //ckmenu 按钮图标配置文件
        self.circleMenuImageArray.append(UIImage(named: "bk_media_picture_normal")!)
        self.circleMenuImageArray.append(UIImage(named: "bk_media_shoot_normal")!)
        
        
        //ckmenu 各项自定义参数设定
        tOptions[CIRCLE_MENU_OPENING_DELAY] = 0.1
        tOptions[CIRCLE_MENU_MAX_ANGLE] = 90
        tOptions[CIRCLE_MENU_RADIUS] = 90
        tOptions[CIRCLE_MENU_DIRECTION] = Int(CircleMenuDirectionDown.rawValue)
        tOptions[CIRCLE_MENU_BUTTON_BACKGROUND_NORMAL] = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        tOptions[CIRCLE_MENU_BUTTON_BACKGROUND_ACTIVE] = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        tOptions[CIRCLE_MENU_BUTTON_BORDER] = UIColor.whiteColor()
        tOptions[CIRCLE_MENU_DEPTH] = 100
        tOptions[CIRCLE_MENU_BUTTON_RADIUS] = 35.0
        tOptions[CIRCLE_MENU_BUTTON_BORDER_WIDTH] = 2.0
        tOptions[CIRCLE_MENU_TAP_MODE] = true
        
        

        //总列表的代理和数据
        ThreadList.delegate = self
        ThreadList.dataSource = self

        
        //标准http请求header
        let request        = NSMutableURLRequest(URL: NSURL(string: "http://52.32.31.214/schoolchat/schoolChatWebService/public/getPost/26")!)
        request.HTTPMethod = "GET"
    
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
        
            //http返回字符串
            //print("responseString = \(responseString!)")
        }
        task.resume()
        


        

        //总列表的位置摆放（全屏）
        ThreadList.translatesAutoresizingMaskIntoConstraints = false
        let RConstraint = NSLayoutConstraint.init(item: ThreadList, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: self.view, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let XConstraint = NSLayoutConstraint.init(item: ThreadList, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let YConstraint = NSLayoutConstraint.init(item: ThreadList, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        let TopConstraint = NSLayoutConstraint.init(item: ThreadList, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.view.addConstraints([RConstraint,XConstraint,TopConstraint,YConstraint])

        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))


    }
    
    
    //列表配置函数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = initForumImagecell(UIImage.init(named: "avatar_user")!, name: "OST", sign: "1234567890", Ima: UIImage.init(named: "ms1")!, Tit: self.title! + "\(indexPath.section)日式寿司大集合",Ctime: "昨天",tag: indexPath.section)
        return cell

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.width/1.33 + 70
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //带图标题的单元格
    func initForumImagecell(a:UIImage,name:String,sign:String,Ima:UIImage,Tit:String,Ctime:String,tag:Int)-> UITableViewCell
    {
        
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Image")
        let avatar = UIImageView.init(frame: CGRectMake(20, 20, 40, 40))
        let NameLable = UILabel.init(frame: CGRectMake(75, 20, 200, 20))
        let SignLable = UILabel.init(frame: CGRectMake(75, 45, 200, 20))
        let ImageCont = UIImageView.init()
        let Title = UITextField.init()
        let Timelable = UILabel.init()
        
        
        cell.selectionStyle = .None
        
        avatar.image = a
        NameLable.text = name
        SignLable.text = sign
        ImageCont.image = Ima
        Title.text = Tit
        Timelable.text = Ctime
        
        avatar.layer.cornerRadius = 20
        avatar.clipsToBounds = true
        
        NameLable.font = UIFont.boldSystemFontOfSize(17)
        SignLable.textColor = UIColor.init(white: 0.6, alpha: 1)
        
        
        cell.addSubview(avatar)
        cell.addSubview(NameLable)
        cell.addSubview(SignLable)
        cell.addSubview(ImageCont)
        cell.addSubview(Title)
        cell.addSubview(Timelable)
        
        let TapAva = UITapGestureRecognizer.init(target: self, action: #selector(ForumViewController.TapA))
        avatar.userInteractionEnabled = true
        TapAva.delegate = self
        avatar.addGestureRecognizer(TapAva)
        avatar.tag = tag
        
        let TapImg = UITapGestureRecognizer.init(target: self, action: #selector(ForumViewController.TapI))
        ImageCont.userInteractionEnabled = true
        TapImg.delegate = self
        ImageCont.addGestureRecognizer(TapImg)
        ImageCont.tag = tag
        
        
        Timelable.textColor = UIColor.init(white: 0.6, alpha: 1)
        Timelable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: Timelable, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 30).active = true
        NSLayoutConstraint(item: Timelable, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 70).active = true
        let TLRConstraint = NSLayoutConstraint.init(item: Timelable, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: cell, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let TLTopConstraint = NSLayoutConstraint.init(item: Timelable, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 20)
        cell.addConstraints([TLRConstraint,TLTopConstraint])
        
        ImageCont.translatesAutoresizingMaskIntoConstraints = false
        ImageCont.contentMode = UIViewContentMode.ScaleAspectFill
        NSLayoutConstraint.init(item: ImageCont, attribute:NSLayoutAttribute.Width , relatedBy: NSLayoutRelation.Equal , toItem: ImageCont, attribute: NSLayoutAttribute.Height , multiplier: 1.33, constant: 0).active = true
        let IRConstraint = NSLayoutConstraint.init(item: ImageCont, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: cell, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let IXConstraint = NSLayoutConstraint.init(item: ImageCont, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let IBotConstraint = NSLayoutConstraint.init(item: ImageCont, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        cell.addConstraints([IRConstraint,IXConstraint,IBotConstraint])
        
        Title.translatesAutoresizingMaskIntoConstraints = false
        Title.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        Title.textColor = UIColor.whiteColor()
        Title.textAlignment = NSTextAlignment.Center
        NSLayoutConstraint(item: Title, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 44).active = true
        let TRConstraint = NSLayoutConstraint.init(item: Title, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: cell, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let TXConstraint = NSLayoutConstraint.init(item: Title, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let TBotConstraint = NSLayoutConstraint.init(item: Title, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        cell.addConstraints([TRConstraint,TXConstraint,TBotConstraint])
        
        return cell
    }
    
    
    
    
    


}
