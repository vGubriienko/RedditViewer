//
//  ApplicationCoordinator.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runTopEntriesFlow()
    }
    
    private func runTopEntriesFlow() {
        let coordinator = coordinatorFactory.makeTopEntriesCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }

}
