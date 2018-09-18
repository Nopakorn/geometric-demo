//
//  AppDelegate.swift
//  geometric-demo
//
//  Created by Nopakorn Ganjanasinit on 13/9/2561 BE.
//  Copyright © 2561 Nopakorn Ganjanasinit. All rights reserved.
//

import UIKit
import KontaktSDK
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var beaconManager = KTKBeaconManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        beaconManager.delegate = self
        Kontakt.setAPIKey("FHRSgwLIAilDHYGrIEBACHauZmMjYtyC")
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.alert, .sound]) { (granted, error) in }
        
        return true
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

extension AppDelegate: KTKBeaconManagerDelegate {
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        guard region is KTKBeaconRegion else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Exist region"
        content.body = "YES u just exist a region"
        content.sound = .default()
        
        let request = UNNotificationRequest(identifier: "otrtbeacon", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

