//
//  CoordinatorFactoryImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


final class CoordinatorFactoryImp: CoordinatorFactory {

    func makeTopEntriesCoordinator(router: Router) -> Coordinator {
        return TopEntriesCoordinator(router: router, coordinatorFactory: CoordinatorFactoryImp(), moduleFactory: ModuleFactoryImp())
    }
    
    func makePicturePreviewCoordinator(router: Router, picture: Picture) -> Coordinator {
        return PictureViewerCoordinator(router: router, moduleFactory: ModuleFactoryImp(), picture: picture)
    }

}
