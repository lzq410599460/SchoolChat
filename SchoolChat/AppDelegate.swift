//
//  AppDelegate.swift
//  SchoolChat
//
//  Created by ZL on 16/6/15.
//  Copyright © 2016年 WoF. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

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
            
        }
        
        

   
        
        
        
    
        // Override point for customization after application launch.
        return true
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

