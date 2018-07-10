//
//  RedditDecodable.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/9/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


struct RedditTopEntriesServerModel: Decodable {
    let kind: String
    let data: RedditEntriesDataServerModel
}


struct RedditEntriesDataServerModel: Decodable {
    let children: [RedditEntryServerModel]
    let after: String?
}


struct RedditEntryServerModel: Decodable {
    let kind: String
    let data: RedditEntryDataServerModel
}


struct RedditEntryDataServerModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case thumbnail
        case author
        case title
        case id
        case preview
        
        case cratedAt = "created_utc"
        case commentsCount = "num_comments"
    }
    
    let thumbnail: URL?
    let author: String
    let title: String
    let cratedAt: TimeInterval
    let commentsCount: UInt
    let id: String
    let preview: RedditEntryPreviewServerModel?
}


struct RedditEntryPreviewServerModel: Decodable {
    let images: [RedditPreviewImageServerModel]
}


struct RedditPreviewImageServerModel: Decodable {
    let source: RedditPreviewImageSourceServerModel
}


struct RedditPreviewImageSourceServerModel: Decodable {
    let url: URL
}
