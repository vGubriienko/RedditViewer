//
//  DeviceLibraryPictureSaver.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/11/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit
import Photos


class DeviceLibraryPictureSaver: PictureSaver {
    
    enum Error: Swift.Error, LocalizedError {
        case photoLibraryAccessRestricted
        
        var errorDescription: String? {
            switch self {
            case .photoLibraryAccessRestricted:
                return "Access to Photo Library is Restricted. Please check your Settings."
            }
        }
    }
    
    func save(image: UIImage, completion: @escaping (PictureSaverResult) -> Void) {
        let auth = PHPhotoLibrary.authorizationStatus()
        
        switch auth {
        case .denied, .restricted:
            completion(.failure(error: Error.photoLibraryAccessRestricted))
        case .authorized:
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }) { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        completion(.success)
                    } else if let error = error {
                        completion(.failure(error: error))
                    }
                }
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { authStatus in
                if authStatus == .authorized {
                    self.save(image: image, completion: completion)
                }
            }
        }
    }

}
