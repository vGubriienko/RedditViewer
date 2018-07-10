//
//  PicturePreviewViewModelImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


class PicturePreviewViewModelImp: PicturePreviewViewModel, PicturePreviewModuleIO {
    
    let image = Observable<UIImage?>(nil)
    let isLoadingImage = Observable(false)
    
    private let picture: Picture
    private let pictureProvider: RedditPictureProvider
    
    init(picture: Picture, pictureProvider: RedditPictureProvider) {
        self.picture = picture
        self.pictureProvider = pictureProvider
    }
    
    func refreshImage() {
        guard isLoadingImage.value == false else { return }
        
        isLoadingImage.value = true
        pictureProvider.providePicture(picture) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let picture):
                self.image.value = picture
            case .failure(let error):
                // TODO: handle error
                print("Loading image error: \(error)")
            }
            
            self.isLoadingImage.value = false
        }
    }
    
}
