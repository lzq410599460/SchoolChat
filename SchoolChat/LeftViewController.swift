//
//  LeftViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/26.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit
import Foundation

class LeftViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.frame = CGRectMake(20, (self.view.frame.size.height - 54 * 5) / 2.0, self.view.frame.size.width, 54 * 5)
        tableView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth]
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.opaque = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
    }()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
}

extension LeftViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let titles: [String] = ["二手/Trading","购物／Shopping", "居家/Housing", "学习/Studing", "会话/Chatting"]
        
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 21)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text  = titles[indexPath.row]
        cell.selectionStyle = .None

        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let ForumVC = ForumViewController.init()
        let TopicVC = TopicViewController.init()
        switch indexPath.row {
        case 0:
            
            ForumVC.config("Trading")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: ForumVC)
            sideMenuViewController?.hideMenuViewController()
            break
        case 1:
            ForumVC.config("Shopping")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: ForumVC)
            sideMenuViewController?.hideMenuViewController()
            break
        case 2:
            TopicVC.config("Housing")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: TopicVC)
            sideMenuViewController?.hideMenuViewController()
            break
        case 3:
            let StudyVC = StudyViewController()
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: StudyVC)
            sideMenuViewController?.hideMenuViewController()
            break
        case 4:
            let MainSB = UIStoryboard.init(name: "Main", bundle: nil)
            let MainVC = MainSB.instantiateViewControllerWithIdentifier("MainTab") as! UITabBarController
            sideMenuViewController?.contentViewController = MainVC
            sideMenuViewController?.hideMenuViewController()
            break
            
        default:
            break
        }
        
        
    }
    
    

    
}