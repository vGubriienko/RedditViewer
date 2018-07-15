//
//  TopEntriesCoordinator.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


class TopEntriesCoordinator: BaseCoordinator {
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    private let moduleFactory: TopEntriesModuleFactory
    private var appState: AppStateProtocol?
    private weak var viewModel: EntriesListModuleIO?
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, moduleFactory: TopEntriesModuleFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.moduleFactory = moduleFactory
    }

    override func start(with restorationState: AppStateProtocol?) {
        appState = restorationState
        let module = moduleFactory.makeTopEntriesModule(with: restorationState)
        viewModel = module.moduleIO
        
        module.moduleIO.onSelectPicture = { [weak self] picture in
            self?.runPictureViewerFlow(picture: picture)
        }
        
        module.moduleIO.onShowEntryRequested = { entryLink in
            UIApplication.shared.open(entryLink, options: [:], completionHandler: nil)
        }
        
        router.push(module.presentable, animated: false)
        
        if let picturePreviewState: PicturePreviewRestorationState = restorationState?.getState(),
            let picture = picturePreviewState.picture
        {
            runPictureViewerFlow(picture: picture)
        }
    }
    
    private func runPictureViewerFlow(picture: Picture) {
        let coordinator = coordinatorFactory.makePicturePreviewCoordinator(router: router, picture: picture)
        addDependency(coordinator)
        
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        
        coordinator.start(with: appState)
    }
    
    override func saveState() {
        viewModel?.saveState()
        childCoordinators.forEach { $0.saveState() }
    }
    
}
