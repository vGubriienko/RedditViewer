//
//  TopEntriesModuleFactory.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol TopEntriesModuleFactory: class {
    
    func makeTopEntriesModule(with appRestorationState: AppStateProtocol?) -> (moduleIO: EntriesListModuleIO, presentable: Presentable)
    
}
