//
//  PictureViewerCoordinator.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class PictureViewerCoordinator: BaseCoordinator {
    
    private let router: Router
    private let moduleFactory: PicturePreviewModuleFactory
    private let picture: Picture
    
    init(router: Router, moduleFactory: PicturePreviewModuleFactory, picture: Picture) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.picture = picture
    }
    
    override func start() {
        let module = moduleFactory.makePicturePreviewModule(picture: picture)
        router.present(module.presentable)
    }
    
}
