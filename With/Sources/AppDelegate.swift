//
//  AppDelegate.swift
//  With
//
//  Created by 남수김 on 2019/12/23.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions,completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        let tabbar = UITabBarController()
        let mainVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home")
        let chatVC = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "ChatList")
        let mypageVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MyPage")
        //        let myPageVC = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "Chat")
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        chatVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        mypageVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        
        let controllerArray = [mainVC, chatVC, mypageVC]
        
        tabbar.viewControllers = controllerArray.map { UINavigationController.init(rootViewController: $0)}
        controllerArray.map { $0.navigationController?.isNavigationBarHidden = true }
//        window?.rootViewController = tabbar
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().isAutoInitEnabled = true
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if let messageID = userInfo[gcmMessageIDKey] {
//          print("Message ID: \(messageID)")
//        }

        // Print full message.
//        print(userInfo)
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("\(#function)")
  }
}
extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    print("Firebase registration token: \(fcmToken)")
    let dataDict:[String: String] = ["token": fcmToken]
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
  }
}
