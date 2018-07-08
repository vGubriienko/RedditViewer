//
//  AppDelegate.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootController: UINavigationController {
        return window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        applicationCoordinator.start()
        
        return true
    }
    
    private func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(router: RouterImp(rootController: self.rootController), coordinatorFactory: CoordinatorFactoryImp())
    }

}

