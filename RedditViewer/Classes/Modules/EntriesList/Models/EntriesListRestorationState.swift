//
//  EntriesListRestorationState.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation



class EntriesListRestorationState: RestorationState {
    
    static var restorationKey: String { return "EntriesList" }
    
    var entries: [RedditEntry]?
}
