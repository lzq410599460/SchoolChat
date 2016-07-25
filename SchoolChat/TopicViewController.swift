//
//  TopicViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/7/18.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit
import CKCircleMenuView

class TopicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,CKCircleMenuDelegate {
    
    let ThreadList = UITableView.init()
    var circleMenuImageArray = Array<UIImage>()
    var tOptions = Dictionary<String, AnyObject>()
    var section = 0
    
    struct Topic {
        var Tid = 0
        var Title = ""
        var user = ""
        var time = 0.0
        var AvatarUrl = ""
    }
    
    var TopicList = [Topic]()
    
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
        let request        = NSMutableURLRequest(URL: NSURL(string: "http://52.32.31.214/schoolchat/schoolChatWebService/public/getSubjects/47/0/10")!)
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
            
            //let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let JSarray = try! NSJSONSerialization.JSONObjectWithData(data!,options: NSJSONReadingOptions.MutableContainers) as! NSArray
            
            for t in JSarray
            {
                
                let id = t.objectForKey("tid") as! String
                let title = t.objectForKey("subject") as! String
                let name = t.objectForKey("author") as! String
                let time = t.objectForKey("dateline") as! String
                let url = t.objectForKey("url") as! String
                
                //print("ID :\(id),Title :\(title),Name :\(name),Time :\(time),URL :\(url) \n")
                let topic  = Topic.init(Tid: Int(id)! , Title: title, user: name, time: Double(time)!, AvatarUrl: url)
                self.TopicList.append(topic)
                print(self.TopicList.count)
                
            }
            
            self.ThreadList.reloadData()
            
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
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopicList.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = initTopiccell(TopicList[indexPath.row])
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //带图标题的单元格
    func initTopiccell(topic : Topic)-> UITableViewCell
    {
        
        let Aurl = NSURL.init(string: topic.AvatarUrl)
        
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "ThreadReply")
        let avatar = UIImageView.init(frame: CGRectMake(20, 20, 40, 40))
        let NameLable = UILabel.init(frame: CGRectMake(75, 25, 200, 25))
        let Timelable = UILabel.init()
        let TextCont = UILabel.init()
        
        var TID = topic.Tid
        
        avatar.image =  UIImage(named: "avatar_user")
        
    
       
        NameLable.text = topic.user
        TextCont.text = topic.Title
        let time = NSDate.init(timeIntervalSince1970: topic.time)
        //let zone = NSTimeZone.systemTimeZone()
        //let diff = NSTimeInterval.ini
        Timelable.text = "\(time)"
        
        avatar.layer.cornerRadius = 20
        avatar.clipsToBounds = true
        
        NameLable.font = UIFont.boldSystemFontOfSize(17)
        TextCont.font = UIFont.systemFontOfSize(17)
        
        let TapAva = UITapGestureRecognizer.init(target: self, action: #selector(TopicViewController.TapA))
        avatar.userInteractionEnabled = true
        TapAva.delegate = self
        avatar.addGestureRecognizer(TapAva)
        
        
        
        
        
        
        cell.addSubview(avatar)
        cell.addSubview(NameLable)
        cell.addSubview(Timelable)
        cell.addSubview(TextCont)
        
        Timelable.textColor = UIColor.init(white: 0.6, alpha: 1)
        Timelable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: Timelable, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 30).active = true
        NSLayoutConstraint(item: Timelable, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 120).active = true
        let TLRConstraint = NSLayoutConstraint.init(item: Timelable, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: cell, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let TLTopConstraint = NSLayoutConstraint.init(item: Timelable, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 20)
        cell.addConstraints([TLRConstraint,TLTopConstraint])
        
        
        TextCont.numberOfLines = 2
        TextCont.lineBreakMode = .ByWordWrapping
        TextCont.font = UIFont.boldSystemFontOfSize(20)
        
        TextCont.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: TextCont, attribute:NSLayoutAttribute.Height , relatedBy: NSLayoutRelation.Equal , toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute , multiplier: 1, constant: 100).active = true
        let IRConstraint = NSLayoutConstraint.init(item: TextCont, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: cell, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: -20)
        let IXConstraint = NSLayoutConstraint.init(item: TextCont, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let IBotConstraint = NSLayoutConstraint.init(item: TextCont, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        cell.addConstraints([IRConstraint,IXConstraint,IBotConstraint])
        
        return cell

    }
    
    
    
    
    
    
    
}
