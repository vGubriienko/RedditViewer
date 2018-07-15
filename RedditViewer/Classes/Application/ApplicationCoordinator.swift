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
    private var restorationState: AppStateProtocol
    private let appStateService: AppStateService<AppState>
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, appStateService: AppStateService<AppState>) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.appStateService = appStateService
        restorationState = appStateService.state
    }
    
    override func start(with restorationState: AppStateProtocol?) {
        appStateService.restoreState { appState in
            self.restorationState = appState
            let coordinatorState: ApplicationCoordinatorRestorationState? = appState.getState()
            
            switch coordinatorState?.rootFlow ?? .topEntries {
            case .topEntries:
                self.runTopEntriesFlow()
            }
        }
    }
    
    private func runTopEntriesFlow() {
        let coordinator = coordinatorFactory.makeTopEntriesCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start(with: restorationState)
    }
    
    override func saveState() {
        let coordinatorState: ApplicationCoordinatorRestorationState = restorationState.getState() ?? .init()

        coordinatorState.rootFlow = .topEntries
        
        restorationState.setState(coordinatorState)
        
        childCoordinators.forEach { $0.saveState() }
        
        appStateService.saveState(synchronously: true)
    }

}
