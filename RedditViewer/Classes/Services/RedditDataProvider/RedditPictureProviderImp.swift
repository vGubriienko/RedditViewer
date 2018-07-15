//
//  RedditPictureProviderImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/11/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


extension RedditDataProvider: RedditPictureProvider {
    
    enum PictureProviderError: Swift.Error {
        case noData
        case dataIsNotAnImage
    }
    
    func providePicture(_ picture: Picture, completion: @escaping (RedditPictureProviderResult) -> Void) {
        let request = URLRequest(url: picture.pictureURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 30.0)
        
        downloadData(with: request) { result in
            var completionResult: RedditPictureProviderResult
            
            switch result {
            case .success(let data):
                if let data = data {
                    if let image = UIImage(data: data, scale: UIScreen.main.scale) {
                        completionResult = .success(picture: image)
                    } else {
                        completionResult = .failure(error: PictureProviderError.dataIsNotAnImage)
                    }
                } else {
                    completionResult = .failure(error: PictureProviderError.noData)
                }
            case .failure(let error):
                completionResult = .failure(error: error)
            }
            
            DispatchQueue.main.async {
                completion(completionResult)
            }
        }
    }
}
