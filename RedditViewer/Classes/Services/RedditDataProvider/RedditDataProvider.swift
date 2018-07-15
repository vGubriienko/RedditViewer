//
//  RedditDataProvider.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/9/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import Foundation


class RedditDataProvider {
    
    enum Error: Swift.Error {
        case httpStatusError(statusCode: Int)
    }
    
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
            } else if let response = response as? HTTPURLResponse, response.statusCode >= 400 {
                completion(.failure(error: Error.httpStatusError(statusCode: response.statusCode)))
            } else {
                completion(.success(data: data))
            }
        }.resume()
    }
    
}
