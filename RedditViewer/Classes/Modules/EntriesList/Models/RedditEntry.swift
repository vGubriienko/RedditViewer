//
//  RedditEntry.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/9/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


protocol RedditEntry {
    var ID: EntryID { get }
    var author: String { get }
    var postDate: Date { get }
    var title: String { get }
    var commentsCount: UInt { get }
    var thumbURL: URL? { get }
    var pictureURL: URL? { get }
}
