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
        print(self.recentSessions.count)
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
