//
//  RedditEntry.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/9/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


struct RedditEntry: Codable {
    let ID: EntryID
    let author: String
    let postDate: Date
    let title: String
    let commentsCount: UInt
    let thumbURL: URL?
    let pictureURL: URL?
    let entryURL: URL
}
