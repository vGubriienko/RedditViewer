//
//  PicturePreviewViewModelImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class PicturePreviewViewModelImp: PicturePreviewViewModel, PicturePreviewModuleIO {
    
    private let picture: Picture
    
    init(picture: Picture) {
        self.picture = picture
    }
    
}
