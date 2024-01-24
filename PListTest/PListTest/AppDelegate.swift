//
//  AppDelegate.swift
//  PListTest
//
//  Created by Naw Su Su Nyein on 7/5/20.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var fireBaseConfigFile = Bundle.main.path(forResource: "GoogleService-Info-QA", ofType: "plist")!
            #if STAGING
               fireBaseConfigFile = Bundle.main.path(forResource: "GoogleService-Info-Dev", ofType: "plist")!
            #elseif DEV
                fireBaseConfigFile = Bundle.main.path(forResource: "GoogleService-Info-Dev", ofType: "plist")!
            #elseif PRODUCTION
                fireBaseConfigFile = Bundle.main.path(forResource: "GoogleService-Info-Dev", ofType: "plist")!
           #endif

        guard let firOptions = FirebaseOptions(contentsOfFile: fireBaseConfigFile) else {
               assert(false, "Failed to load Firebase config file")
               
           }
//
//           FIRApp.configure(with: firOptions)
        FirebaseApp.configure(options: firOptions)
        //FirebaseApp.configure()
        return true
    }

}

