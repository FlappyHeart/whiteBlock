//
//  AppDelegate.swift
//  gamedemo3
//
//  Created by Alfred on 14-7-22.
//  Copyright (c) 2014年 HackSpace. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
    //        if (self.window == nil) {
    //            var keyWindow = UIWindow.init(frame: UIScreen.main.bounds)
    //            keyWindow.makeKeyAndVisible()
    //            self.window = keyWindow;
    //            self.window.rootViewController = self.window?.rootViewController
    //        }
            // Override point for customization after application launch.
    //        MIXView.initWithID("d1d22e88fa277487")
    //        WXApi.registerApp("wxa4bd639487cad529", withDescription: "1.0")
    //        MobClick.start(withAppkey: "54b279ccfd98c5cc4a0005d0")
    //
    //        MobClick.event("launch_game")
    //
    //        GameCenterManager.shared().setupManager()
    //        GameCenterManager.shared().delegate = self
//        print(WDSDK.sdkVersion())
//            WDSDK.initWithAppId("I25LAKOEWYdz9oqd")
            
            return true
        }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
//    func onResp(resp: BaseResp!) {
//        if resp.isKindOfClass(SendMessageToWXResp){
//            if resp.errCode == 0{
//                var alert = UIAlertView(title: "", message: "分享成功", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
//            }
//        }
//    }
//
//
//    private func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
//        return WXApi.handleOpen(url as URL, delegate: self)
//    }
//
//    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
//        return WXApi.handleOpen(url as URL, delegate: self)
//    }
//
//    func gameCenterManager(_ manager: GameCenterManager!, authenticateUser gameCenterLoginController: UIViewController!) {
//
//    }


}

