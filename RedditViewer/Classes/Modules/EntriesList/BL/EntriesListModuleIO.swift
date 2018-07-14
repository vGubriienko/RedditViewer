//
//  EntriesModuleIO.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol EntriesListModuleIO: class {
    var onSelectPicture: ((_ picture: Picture) -> Void)? { get set }
    
    func saveState()
}
