//
//  RedditPictureProvider.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/11/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


enum RedditPictureProviderResult {
    case success(picture: UIImage)
    case failure(error: Error)
}


protocol RedditPictureProvider {
    func providePicture(_ picture: Picture, completion: @escaping (RedditPictureProviderResult) -> Void)
}
