//
//  RestorationState.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol RestorationState: class, Codable {
    static var restorationKey: String { get }
}
