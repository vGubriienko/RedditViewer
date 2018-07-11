//
//  PictureViewerCoordinator.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


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

        //TODO: refactor to avoid using VC directly
        let presentedVC = module.presentable
        module.moduleIO.showMessageRequested = { message in
            let alertVC = UIAlertController(title: "Picture preview", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            presentedVC.toPresent()?.present(alertVC, animated: true, completion: nil)
        }
    }

}
