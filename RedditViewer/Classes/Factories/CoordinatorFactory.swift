//
//  CoordinatorFactory.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol PictureViewerCoordinatorIO: class {
    var onFinishFlow: (() -> Void)? { get set }
}


protocol CoordinatorFactory {
    
    func makeTopEntriesCoordinator(router: Router) -> Coordinator
    func makePicturePreviewCoordinator(router: Router, picture: Picture) -> Coordinator & PictureViewerCoordinatorIO

}
