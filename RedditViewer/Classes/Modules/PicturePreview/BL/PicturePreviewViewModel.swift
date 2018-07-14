//
//  PicturePreviewViewModel.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


protocol PicturePreviewViewModel: class, MVVMViewModel {
    
    var image: Observable<UIImage?> { get }
    var isLoadingImage: Observable<Bool> { get }
    
    func refreshImage()
    func savePicture()
    func finishFlow()
    
}
