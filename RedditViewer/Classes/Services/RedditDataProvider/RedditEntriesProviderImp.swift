//
//  RedditEntriesProviderImp.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/10/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


extension RedditDataProvider: RedditEntriesProvider {
    
    private struct Cursor: RedditEntriesProviderCursor {
        let fullname: String?
    }
    
    func provideEntries(with paging: RedditEntriesProviderPaging, completion: @escaping (RedditEntriesProviderResult) -> Void) {
        
        var queryItems = [URLQueryItem]()
        
        var urlComponents = URLComponents(string: Constants.topPath)!
        
        (paging.cursor as? Cursor)?.fullname.flatMap { queryItems.append(URLQueryItem(name: "after", value: $0)) }
        queryItems.append(URLQueryItem(name: "limit", value: String(paging.limit)))
        urlComponents.queryItems = queryItems
        
        let url = urlComponents.url(relativeTo: baseURL)!
        let request = URLRequest(url: url)
        downloadData(with: request) { [weak self] result in
            guard let `self` = self else { return }
            
            let completionResult: RedditEntriesProviderResult
            
            switch result {
            case .success(let data):
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(RedditTopEntriesServerModel.self, from: data)
                        let parsedResult = self.parse(decodable: decoded)
                        let cursor = Cursor(fullname: decoded.data.after)
                        completionResult = .success(entries: parsedResult, cursor: cursor)
                    } catch let error {
                        completionResult = .failure(error: error)
                    }
                } else {
                    completionResult = .success(entries: [], cursor: nil)
                }
            case .failure(let error):
                completionResult = .failure(error: error)
            }
            
            DispatchQueue.main.async {
                completion(completionResult)
            }
        }
    }
    
    private func parse(decodable: RedditTopEntriesServerModel) -> [RedditEntry] {
        return decodable.data.children.map {
            RedditEntry(ID: $0.data.id,
                        author: $0.data.author,
                        postDate: Date(timeIntervalSince1970: $0.data.cratedAt),
                        title: $0.data.title,
                        commentsCount: $0.data.commentsCount,
                        thumbURL: ($0.data.thumbnail?.host != nil) ? $0.data.thumbnail : nil,
                        pictureURL: $0.data.preview?.images.first?.source.url,
                        entryURL: $0.data.url)
        }
    }
    
}
