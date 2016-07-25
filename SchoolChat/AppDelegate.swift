//
//  AppDelegate.swift
//  SchoolChat
//
//  Created by ZL on 16/6/15.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,SSASideMenuDelegate {

    var window: UIWindow?
    
    

        //手动登陆函数 
    func connect (account: String, password: String, completion : ()-> Void)
    {
        
    NIMSDK.sharedSDK().loginManager.login(account, token: password)
        {
            (error :NSError?) in
            if (error == nil) {print("手动登录成功，信息自动保存")
                completion()
            }
            else {print("登录失败,重新输入")}
            }
    
    }
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        NIMKit.sharedKit().provider = DataProvider()
        
        NIMSDK.sharedSDK().registerWithAppID("0f5a5ed59a0fa44ec27c07edf2b1a2da", cerName: "Test")
        
        let UserInfo = NSUserDefaults.standardUserDefaults()
        if( UserInfo.stringForKey("account") == nil || UserInfo.stringForKey("account")! == "" ){
            let LoginSB = UIStoryboard.init(name: "Login" ,bundle: nil)
            let LoginVC = LoginSB.instantiateViewControllerWithIdentifier("log") as! LoginViewController
            self.window?.rootViewController = LoginVC
        }
        else{
            NIMSDK.sharedSDK().loginManager.autoLogin(UserInfo.stringForKey("account")!, token: UserInfo.stringForKey("pass")!)
            print("自动登录成功 : \(NIMSDK.sharedSDK().loginManager.currentAccount())")
  
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            
            let ForumVC = ForumViewController.init()
            ForumVC.config("Trading")
            let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: ForumVC), leftMenuViewController: LeftViewController())
            sideMenu.backgroundImage = UIImage(named: "55")
            sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
            sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
            sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.blackColor(), opacity: 0.6, radius: 6.0))
            sideMenu.delegate = self
            
            
            
            window?.rootViewController = sideMenu

            
        }
        
        

   
        
        
        
    
        // Override point for customization after application launch.
        return true
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        print("fetch start")
        //标准http请求header
        let request = NSMutableURLRequest(URL: NSURL(string: "https://webapp4.asu.edu/catalog/classlist?k=70793&t=2167&e=all&hon=F")!)
        
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
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            let not = UILocalNotification.init()
            let now = NSDate()
            
            not.fireDate = now
            not.alertBody = "CSE310 还有" + result + "个座位啦！"
            not.soundName = UILocalNotificationDefaultSoundName
            
            UIApplication.sharedApplication().scheduleLocalNotification(not)
            completionHandler(UIBackgroundFetchResult.NewData)
            print("fetch end")
            
        }
        
        task.resume()
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    


}

