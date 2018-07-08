//
//  TopEntriesCoordinator.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class TopEntriesCoordinator: BaseCoordinator {
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    private let moduleFactory: TopEntriesModuleFactory
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, moduleFactory: TopEntriesModuleFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }
    
    override func start() {
        let module = moduleFactory.makeTopEntriesModule()
        
        module.moduleIO.onSelectPicture = { [weak self] picture in
            self?.runPictureViewerFlow(picture: picture)
        }
        
        router.push(module.presentable, animated: false)
    }
    
    private func runPictureViewerFlow(picture: Picture) {
        let coordinator = coordinatorFactory.makePicturePreviewCoordinator(router: router, picture: picture)
        addDependency(coordinator)
        coordinator.start()
    }
    
}
