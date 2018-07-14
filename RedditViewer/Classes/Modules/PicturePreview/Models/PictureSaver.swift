//
//  PictureSaver.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/11/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


enum PictureSaverResult {
    case success
    case failure(error: Error)
}


protocol PictureSaver: class {
    func save(image: UIImage, completion: @escaping (PictureSaverResult) -> Void)
}
