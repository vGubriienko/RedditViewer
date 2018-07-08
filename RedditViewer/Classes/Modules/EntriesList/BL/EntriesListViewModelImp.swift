//
//  EntriesListViewModelImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation



class EntriesListViewModelImp: EntriesListViewModel, EntriesListModuleIO {
    
    // MARK: - EntriesModuleIO
    
    var onSelectPicture: ((Picture) -> Void)?
    
    // MARK: - EntriesListViewModel
    
    struct PictureMock: Picture {}
    
    func showPicture(for entryID: EntryID) {
        // TODO: find/create picture object
        onSelectPicture?(PictureMock())
    }
    
}
