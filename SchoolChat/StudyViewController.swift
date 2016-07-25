//
//  StudyViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/26.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let ClassInfo = UITableView.init()
    var Class = [80039,70793]
    var Seats = [-1,-1]
    
    func Ref ()
    {
        var i = 0
        while i<Class.count {
            i += 1
            SeatsCheck(i)
        }
    
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .BlackTranslucent
        self.navigationController?.navigationBar.translucent = false
        self.title = "Study"
        self.view.addSubview(ClassInfo)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .Plain, target: self, action: #selector(StudyViewController.Ref))
        
        ClassInfo.delegate = self
        ClassInfo.dataSource = self
        
        ClassInfo.translatesAutoresizingMaskIntoConstraints = false
        let RConstraint = NSLayoutConstraint.init(item: ClassInfo, attribute:NSLayoutAttribute.Trailing , relatedBy: NSLayoutRelation.Equal , toItem: self.view, attribute: NSLayoutAttribute.Trailing , multiplier: 1, constant: 0)
        let XConstraint = NSLayoutConstraint.init(item: ClassInfo, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let YConstraint = NSLayoutConstraint.init(item: ClassInfo, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        let TopConstraint = NSLayoutConstraint.init(item: ClassInfo, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.view.addConstraints([RConstraint,XConstraint,TopConstraint,YConstraint])
        
        Ref()
        

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Class.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style:.Value1, reuseIdentifier: "Class")
        cell.textLabel?.text = "\(Class[indexPath.row])"
        cell.detailTextLabel?.text = "\(Seats[indexPath.row])"
        
        
        return cell
    }
    
    //输入课号返回剩余座位
    func SeatsCheck (CourseNumber : Int)
    {
        
        //标准http请求header
        let request = NSMutableURLRequest(URL: NSURL(string: "https://webapp4.asu.edu/catalog/classlist?k=\(CourseNumber)&t=2167&e=all&hon=F")!)
        
        request.HTTPMethod = "GET"
        request.setValue("application/x-www-form-urlencoded;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("JSESSIONID=javaprod19~69FFA145AF2EC4F751A996796F5D7CDB.catalog19;onlineCampusSelection=C; __cfduid=de2e9529d1f8e26bddcf45cce0a13e9161467288177", forHTTPHeaderField: "Cookie")
        request.HTTPShouldHandleCookies = true
        
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
            
            //http返回字符串
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            
            
            
            //计算座位字符串
            
            let start = "<td style=\"text-align:right;padding:0px;width:22px; border:none\">"
            let startR = responseString!.rangeOfString(start)
            
            let end = "<td style=\"text-align:center;padding-left:3px;padding-right:3px; padding-top: 0px;border:none\">of</td>"
            let endR = responseString!.rangeOfString(end)
            
            let result = responseString!.substringWithRange(NSMakeRange(startR.location + 65 , endR.location-startR.location-81 ))
            self.Seats[CourseNumber] = Int(result)!
            self.ClassInfo.reloadData()
            
        }
        
        task.resume()
     
    }
    
    
    
    
    
    
    
}



