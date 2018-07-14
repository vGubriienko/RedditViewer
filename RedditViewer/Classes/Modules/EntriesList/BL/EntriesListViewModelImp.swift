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
    
    let entries = Observable([RedditEntry]())
    let isLoadingEntries = Observable(false)
    
    // MARK: - Private Properties
    
    private let entriesProvider: RedditEntriesProvider
    private var entriesCursor: RedditEntriesProviderCursor?
    private let appRestorationState: AppStateProtocol?
    
    // MARK: - Lifecycle
    
    init(with appRestorationState: AppStateProtocol?, entriesProvider: RedditEntriesProvider) {
        self.entriesProvider = entriesProvider
        self.appRestorationState = appRestorationState
        
        let state: EntriesListRestorationState? = appRestorationState?.getState()
        
        state?.entries.flatMap { self.entries.value = $0 }
    }
    
    // MARK: - EntriesListViewModel
    
    func refreshEntries() {
        entriesCursor = nil
        entries.value.removeAll()

        loadMoreEntries()
    }
    
    func loadMoreEntries() {
        guard isLoadingEntries.value == false else { return }
        
        isLoadingEntries.value = true
        let paging = RedditEntriesProviderPagingImp(cursor: entriesCursor, limit: 50)
        
        entriesProvider.provideEntries(with: paging) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let entries, let cursor):
                self.entriesCursor = cursor
                self.entries.value.append(contentsOf: entries)
            case .failure(let error):
                print(error)
            }
            
            self.isLoadingEntries.value = false
        }
    }

    func showPicture(for entryID: EntryID) {
        guard let pictureURL = entries.value.first(where: { $0.ID == entryID })?.pictureURL else { return }
        
        onSelectPicture?(Picture(pictureURL: pictureURL))
    }
    
    func saveState() {
        let moduleState: EntriesListRestorationState = appRestorationState?.getState() ?? EntriesListRestorationState()
        
        moduleState.entries = entries.value
        
        appRestorationState?.setState(moduleState)
    }
}
