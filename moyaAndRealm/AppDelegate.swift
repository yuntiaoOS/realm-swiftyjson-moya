//
//  AppDelegate.swift
//  moyaAndRealm
//
//  Created by jcgf on 2018/5/31.
//  Copyright © 2018年 jcgf. All rights reserved.
//
import UIKit
import Moya
import SwiftyJSON
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
       
    //data.json 本地数据存储
//        openJsonfiel()
        //网络请求数据存储
        autoLogin()
        return true
    }
    
    //自动登录
    func autoLogin() {
 
        
        //使用Moya请求登录
        apiProvider.request(.loadWebPage(pageUrl: "")){
            
            result in
            switch result {
            case let.success(response):
                //根据服务器返回的代码进行处理
               
               
                let resultData = ZZWResponseBase.addNewItemInRealm(JSON(response.data))

                
            case .failure(_): break

            }
        }
        
        
        
    }
    
    func openJsonfiel() {
        //1 data.json文件路径
        
        let path = Bundle.main.path(forResource: "data", ofType: "json")
        
        //2 data.json文件内容
        
        let jsonData = NSData(contentsOfFile: path!)
        
        
        
        do {
            let jsonD =  try JSON(data: jsonData! as Data)
            _ = ZZWResponseBase.addNewItemInRealm(jsonD)
            
        } catch  {
            
        }
        
        
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

