//
//  RedditEntriesProviderPagingImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/9/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


struct RedditEntriesProviderPagingImp: RedditEntriesProviderPaging {
    var cursor: RedditEntriesProviderCursor?
    var limit: UInt
}
