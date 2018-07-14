//
//  ApplicationCoordinatorRestorationState.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class ApplicationCoordinatorRestorationState: RestorationState {
    
    static var restorationKey: String { return "ApplicationCoordinator" }
    
    enum RootFlow: String, Codable {
        case topEntries
    }
    
    var rootFlow: RootFlow?
    
}
