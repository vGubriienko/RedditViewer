//
//  Coordinator.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol Coordinator: class {
    func start(with restorationState: AppStateProtocol?)
    func saveState()
}
