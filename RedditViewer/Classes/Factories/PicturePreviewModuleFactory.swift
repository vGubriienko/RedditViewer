//
//  PicturePreviewModuleFactory.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol PicturePreviewModuleIO: class {
    var showMessageRequested: ((_ message: String) -> Void)? { get set }
    var onFinishFlow: (() -> Void)? { get set }
}


protocol PicturePreviewModuleFactory: class {
    
    func makePicturePreviewModule(with appRestorationState: AppStateProtocol?, picture: Picture) -> (moduleIO: PicturePreviewModuleIO, presentable: Presentable)
    
}
