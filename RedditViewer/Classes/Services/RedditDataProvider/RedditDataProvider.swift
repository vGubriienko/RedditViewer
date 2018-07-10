//
//  RedditDataProvider.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/9/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class RedditDataProvider {
    
    enum DownloadResult {
        case success(data: Data?)
        case failure(error: Swift.Error)
    }
    
    struct Constants {
        static let defaultBaseURL = URL(string: "https://www.reddit.com/")!
        static let topPath = "top.json"
    }
    
    var baseURL = Constants.defaultBaseURL
    
    private let session: URLSession
    
    init(session: URLSession? = nil) {
        if let session = session {
            self.session = session
        } else {
            let configuration = URLSessionConfiguration.default
            self.session = URLSession(configuration: configuration)
        }
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    func downloadData(with request: URLRequest, completion: @escaping (DownloadResult) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error: error))
            } else {
                completion(.success(data: data))
            }
        }.resume()
    }
    
}



