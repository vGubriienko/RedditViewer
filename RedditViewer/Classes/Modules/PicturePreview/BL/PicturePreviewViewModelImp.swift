//
//  PicturePreviewViewModelImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


class PicturePreviewViewModelImp: PicturePreviewViewModel, PicturePreviewModuleIO {
    
    // MARK: - Public Properties
    
    let image = Observable<UIImage?>(nil)
    let isLoadingImage = Observable(false)
    
    var showMessageRequested: ((_ message: String) -> Void)?
    
    // MARK: - Private Properties
    
    private let picture: Picture
    private let pictureProvider: RedditPictureProvider
    private let pictureSaver: PictureSaver
    
    // MARK: - Lifecycle
    
    init(picture: Picture, pictureProvider: RedditPictureProvider, pictureSaver: PictureSaver) {
        self.picture = picture
        self.pictureProvider = pictureProvider
        self.pictureSaver = pictureSaver
    }
    
    // MARK: - Public Methods
    
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
    
    func savePicture() {
        guard let image = image.value else {
            fatalError("Image must exists when trying to save")
        }
        
        pictureSaver.save(image: image) { [weak self] result in
            switch result {
            case .success:
                self?.showMessageRequested?("Picture successfully saved.")
            case .failure(let error):
                self?.showMessageRequested?(error.localizedDescription)
            }
        }
    }
    
}
