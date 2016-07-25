//
//  ThreadViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/28.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit
import CKCircleMenuView

class ThreadViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,CKCircleMenuDelegate {

    let ThreadInfo = UITableView.init()
    var circleMenuImageArray = Array<UIImage>()
    var tOptions = Dictionary<String, AnyObject>()
    
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
    
    func TapA(sender: UITapGestureRecognizer)
    {
        let cell = ThreadInfo.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0))
        let tOrigin = sender.locationInView(cell)
        let CKV = CKCircleMenuView(atOrigin: tOrigin, usingOptions: tOptions, withImageArray: self.circleMenuImageArray)
        cell!.addSubview(CKV)
        CKV.delegate = self
        CKV.openMenu()
    }
    
    func TapAI(sender: UITapGestureRecognizer)
    {
        let cell = ThreadInfo.cellForRowAtIndexPath(NSIndexPath.init(forRow: (sender.view?.tag)! , inSection: 1 ))
        let tOrigin = sender.locationInView(cell)
        let CKV = CKCircleMenuView(atOrigin: tOrigin, usingOptions: tOptions, withImageArray: self.circleMenuImageArray)
        cell!.addSubview(CKV)
        CKV.delegate = self
        CKV.openMenu()
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(ThreadInfo)
        
        //ckmenu 按钮图标配置文件
        self.circleMenuImageArray.append(UIImage(named: "bk_media_picture_normal")!)
        self.circleMenuImageArray.append(UIImage(named: "bk_media_shoot_normal")!)
            
            
        //ckmenu 各项自定义参数设定
        tOptions[CIRCLE_MENU_OPENING_DELAY] = 0.1
        tOptions[CIRCLE_MENU_MAX_ANGLE] = 90
        tOptions[CIRCLE_MENU_RADIUS] = 70
        tOptions[CIRCLE_MENU_DIRECTION] = Int(CircleMenuDirectionDown.rawValue)
        tOptions[CIRCLE_MENU_BUTTON_BACKGROUND_NORMAL] = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        tOptions[CIRCLE_MENU_BUTTON_BACKGROUND_ACTIVE] = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        tOptions[CIRCLE_MENU_BUTTON_BORDER] = UIColor.whiteColor()
        tOptions[CIRCLE_MENU_DEPTH] = 100
        tOptions[CIRCLE_MENU_BUTTON_RADIUS] = 25
        tOptions[CIRCLE_MENU_BUTTON_BORDER_WIDTH] = 2.0
        tOptions[CIRCLE_MENU_TAP_MODE] = true
        
        //总列表的代理和数据
        ThreadInfo.delegate = self
        ThreadInfo.dataSource = self
        ThreadInfo.allowsSelection = false
        
        
        
        //总列表的位置摆放（全屏）
        ThreadInfo.translatesAutoresizingMaskIntoConstraints = false
        let RConstraint = NSLayoutConstraint.init(item: ThreadInfo, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: self.view, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let XConstraint = NSLayoutConstraint.init(item: ThreadInfo, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let YConstraint = NSLayoutConstraint.init(item: ThreadInfo, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        let TopConstraint = NSLayoutConstraint.init(item: ThreadInfo, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.view.addConstraints([RConstraint,XConstraint,TopConstraint,YConstraint])
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {return 1}
        else
        {return 10}             //评论条数
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell
        switch (indexPath.section,indexPath.row)
        {
            case(0,0):
                cell = initForumImagecell(UIImage.init(named: "avatar_user")!, name: "OST", sign: "1234567890", Ima: UIImage.init(named: "ms1")!,Ctime: "昨天")
            case(1,0):
                cell = UITableViewCell.init(style: .Default, reuseIdentifier: "comments")
                cell.textLabel?.text = "评论 10"
            default:
                cell = initThreadReplycell(UIImage.init(named: "avatar_user")!, name: "OST", content: "下手的时候看到PASS卡名额还剩10，点了“报名”之后瞬间变0，苍天啊，这也太快了！", Rtime: "10 分钟前",tag: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section,indexPath.row)
        {
        case(0,0):
                return self.view.frame.width/1.33+70
        case(1,0):
                return 50
        default:
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            let font = UIFont.systemFontOfSize(17)
            let attributes = [NSFontAttributeName: font]
            let content = "下手的时候看到PASS卡名额还剩10，点了“报名”之后瞬间变0，苍天啊，这也太快了！"
            let rect = content.boundingRectWithSize(CGSizeMake(self.view.frame.width, 1000), options: option, attributes: attributes, context: nil)
            let TextHeight = rect.height
            return TextHeight + 70
        }
    }
    
    
    
    //带图标题的单元格
    func initForumImagecell(a:UIImage,name:String,sign:String,Ima:UIImage,Ctime:String)-> UITableViewCell
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
        
        let TapAva = UITapGestureRecognizer.init(target: self, action: #selector(ThreadViewController.TapA))
        avatar.userInteractionEnabled = true
        TapAva.delegate = self
        avatar.addGestureRecognizer(TapAva)

  
        
        Timelable.textColor = UIColor.init(white: 0.6, alpha: 1)
        Timelable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: Timelable, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 30).active = true
        NSLayoutConstraint(item: Timelable, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 120).active = true
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
        
 
        
        return cell
    }
    
    
    func initThreadReplycell(a:UIImage,name:String,content:String,Rtime:String,tag:Int) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "ThreadReply")
        let avatar = UIImageView.init(frame: CGRectMake(20, 20, 40, 40))
        let NameLable = UILabel.init(frame: CGRectMake(75, 25, 200, 25))
        let Timelable = UILabel.init()
        let TextCont = UILabel.init()
        
        avatar.image = a
        NameLable.text = name
        TextCont.text = content
        Timelable.text = Rtime
        
        avatar.layer.cornerRadius = 20
        avatar.clipsToBounds = true
        
        NameLable.font = UIFont.boldSystemFontOfSize(17)
        TextCont.font = UIFont.systemFontOfSize(17)
        
        let TapAva = UITapGestureRecognizer.init(target: self, action: #selector(ThreadViewController.TapAI))
        avatar.userInteractionEnabled = true
        TapAva.delegate = self
        avatar.addGestureRecognizer(TapAva)
        avatar.tag = tag
        
        

        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let attributes = [NSFontAttributeName: TextCont.font]
        let rect = content.boundingRectWithSize(CGSizeMake(self.view.frame.width, 1000), options: option, attributes: attributes, context: nil)
        let TextHeight = rect.height
        
        
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
        

        TextCont.numberOfLines = 10
        TextCont.adjustsFontSizeToFitWidth =  false
        
        
        TextCont.translatesAutoresizingMaskIntoConstraints = false
        TextCont.contentMode = UIViewContentMode.ScaleAspectFill
        NSLayoutConstraint.init(item: TextCont, attribute:NSLayoutAttribute.Height , relatedBy: NSLayoutRelation.Equal , toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute , multiplier: 1, constant: TextHeight).active = true
        let IRConstraint = NSLayoutConstraint.init(item: TextCont, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: cell, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: -20)
        let IXConstraint = NSLayoutConstraint.init(item: TextCont, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let IBotConstraint = NSLayoutConstraint.init(item: TextCont, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        cell.addConstraints([IRConstraint,IXConstraint,IBotConstraint])
        
        return cell
    }
    
    
    
}
