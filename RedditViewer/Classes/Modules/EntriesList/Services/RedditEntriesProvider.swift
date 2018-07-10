//
//  RedditEntriesProvider.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/9/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol RedditEntriesProviderCursor { }


enum RedditEntriesProviderResult {
    case success(entries: [RedditEntry], cursor: RedditEntriesProviderCursor?)
    case failure(error: Error)
}

protocol RedditEntriesProviderPaging {
    var cursor: RedditEntriesProviderCursor? { get }
    var limit: UInt { get }
}


protocol RedditEntriesProvider {
    
    func provideEntries(with paging: RedditEntriesProviderPaging, completion: @escaping (RedditEntriesProviderResult) -> Void)
    
}
