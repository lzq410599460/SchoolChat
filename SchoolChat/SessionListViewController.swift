//
//  SessionListViewController.swift
//  SchoolChat
//
//  Created by ZL on 16/6/18.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit

class SessionListViewController: NIMSessionListViewController{
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reload()

       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func onSelectedRecent(recent: NIMRecentSession!, atIndexPath indexPath: NSIndexPath!) {

        let SesVC = SessionViewController.init(session: recent.session)
        SesVC.title = recent.session?.sessionId
        self.navigationController?.pushViewController(SesVC, animated: true)
        
    }


}
