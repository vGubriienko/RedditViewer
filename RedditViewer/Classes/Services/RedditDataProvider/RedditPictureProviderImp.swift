//
//  RedditPictureProviderImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/11/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


extension RedditDataProvider: RedditPictureProvider {
    
    enum Error: Swift.Error {
        case noData
        case dataIsNotAnImage
    }
    
    func providePicture(_ picture: Picture, completion: @escaping (RedditPictureProviderResult) -> Void) {
        let request = URLRequest(url: picture.pictureURL)
        
        downloadData(with: request) { result in
            var completionResult: RedditPictureProviderResult
            
            switch result {
            case .success(let data):
                if let data = data {
                    if let image = UIImage(data: data) { // TODO: Check scale
                        completionResult = .success(picture: image)
                    } else {
                        completionResult = .failure(error: Error.dataIsNotAnImage)
                    }
                } else {
                    completionResult = .failure(error: Error.noData)
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
