//
//  EntriesListViewModel.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol EntriesListViewModel: class, MVVMViewModel {
    
    var entries: Observable<[RedditEntry]> { get }
    var isLoadingEntries: Observable<Bool> { get }
    
    func refreshEntries()
    func loadMoreEntries()
    func showPicture(for entryID: EntryID)
    func showEntry(with entryID: EntryID)
    
}
