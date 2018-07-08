//
//  Presentable.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


protocol Presentable {
    func toPresent() -> UIViewController?
}


extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
}
