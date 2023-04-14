//
//  AppDelegate.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 2/21/23.
//

import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("🚨 If you see this, copy this message and search/add the memory code to the app delegate")

        SDImageCache.shared.config.maxDiskAge = 3600 * 24 * 7
        SDImageCache.shared.config.maxMemoryCost = 1024 * 1024 * 4 * 20
        SDImageCache.shared.config.shouldCacheImagesInMemory = false
        SDImageCache.shared.config.shouldUseWeakMemoryCache = false
        SDImageCache.shared.config.diskCacheReadingOptions = .mappedIfSafe

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

