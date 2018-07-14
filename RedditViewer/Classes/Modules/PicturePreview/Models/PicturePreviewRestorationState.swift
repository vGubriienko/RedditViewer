//
//  PicturePreviewRestorationState.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class PicturePreviewRestorationState: RestorationState {
    
    static var restorationKey: String { return "PicturePreview" }
    
    var picture: Picture?
    
}
