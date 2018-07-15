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

    private struct Constants {
        static let restorationFileName = "restoration.state"
    }
    
    var window: UIWindow?
    
    var rootController: UINavigationController {
        return window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        applicationCoordinator.start(with: nil)
        
        return true
    }
    
    private func makeCoordinator() -> Coordinator {
        var restorationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        restorationURL.appendPathComponent(Constants.restorationFileName)
        let restorationService = AppStateService<AppState>(stateFileURL: restorationURL, statePlaceholder: AppState())
        
        return ApplicationCoordinator(router: RouterImp(rootController: self.rootController),
                                      coordinatorFactory: CoordinatorFactoryImp(),
                                      appStateService: restorationService)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        applicationCoordinator.saveState()
    }
    
}

