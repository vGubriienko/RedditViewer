//
//  EntriesListViewModelImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation



class EntriesListViewModelImp: EntriesListViewModel, EntriesListModuleIO {
    
    private struct PictureWrapper: Picture {
        let pictureURL: URL
    }
    
    // MARK: - EntriesModuleIO
    
    var onSelectPicture: ((Picture) -> Void)?
    
    // MARK: - EntriesListViewModel
    
    let entries = Observable([RedditEntry]())
    let isLoadingEntries = Observable(false)
    
    // MARK: - Private Properties
    
    private let entriesProvider: RedditEntriesProvider
    private var entriesCursor: RedditEntriesProviderCursor?
    
    // MARK: - Lifecycle
    
    init(entriesProvider: RedditEntriesProvider) {
        self.entriesProvider = entriesProvider
    }
    
    // MARK: - EntriesListViewModel
    
    func refreshEntries() {
        entriesCursor = nil
        entries.value.removeAll()
        // TODO: update UI
        
        loadMoreEntries()
    }
    
    func loadMoreEntries() {
        guard isLoadingEntries.value == false else { return }
        
        // TODO: show spinner
        isLoadingEntries.value = true
        let paging = RedditEntriesProviderPagingImp(cursor: entriesCursor, limit: 50)
        
        entriesProvider.provideEntries(with: paging) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let entries, let cursor):
                self.entriesCursor = cursor
                self.entries.value.append(contentsOf: entries)
            // TODO: update table
            case .failure(let error):
                print(error)
                // TODO: show error
            }
            
            self.isLoadingEntries.value = false
            // TODO: hide spinner
        }
    }

    func showPicture(for entryID: EntryID) {
        guard let pictureURL = entries.value.first(where: { $0.ID == entryID })?.pictureURL else { return }
        
        onSelectPicture?(PictureWrapper(pictureURL: pictureURL))
    }
    
}
