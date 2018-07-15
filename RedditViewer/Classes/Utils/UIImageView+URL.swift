//
//  UIImageView+URL.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/14/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


// TODO: add observing of `image` to avoid race condition
// TODO: add some cache

extension UIImageView {
    
    func setImage(from url: URL, placeholder: UIImage? = nil) {
        image = placeholder
        
        cancelDownloadingImage()
        
        ImageDownloader.shared.downloadImage(from: url, for: self) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
            case .failure:
                break // Do nothing for now in error case
            }
        }
    }
    
    func cancelDownloadingImage() {
        ImageDownloader.shared.cancelDownloading(for: self)
    }
    
}


private protocol WeakElement: class, Hashable { }
extension UIImageView: WeakElement { }

fileprivate class ImageDownloader {
    
    enum Result {
        case success(image: UIImage)
        case failure
    }
    
    struct DownloadElement<Element: WeakElement>: Equatable, Hashable {
        weak var object: Element?
        
        var hashValue: Int { return object?.hashValue ?? 0 }
        
        static func == (lhs: ImageDownloader.DownloadElement<Element>, rhs: ImageDownloader.DownloadElement<Element>) -> Bool {
            return lhs.object == rhs.object
        }
    }
    
    static let shared = ImageDownloader()
    
    var downloads = [DownloadElement<UIImageView>: URLSessionTask]()
    
    func downloadImage(from url: URL, for imageView: UIImageView, completion: @escaping (Result) -> Void) {
        let downloadElement = DownloadElement(object: imageView)
        
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60.0)
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            var completionResult = Result.failure

            if error == nil, let data = data, let image = UIImage(data: data, scale: UIScreen.main.scale) {
                completionResult = .success(image: image)
            }

            DispatchQueue.main.async {
                self?.downloads.removeValue(forKey: downloadElement)
                completion(completionResult)
            }
        }
        
        task.resume()
        
        cancelDownloading(for: downloadElement)
        downloads[downloadElement] = task
    }
    
    func cancelDownloading(for imageView: UIImageView) {
        cancelDownloading(for: DownloadElement(object: imageView))
    }
    
    func cancelDownloading(for downloadingElement: DownloadElement<UIImageView>) {
        let task = downloads[downloadingElement]
        task?.cancel()
        downloads.removeValue(forKey: downloadingElement)
    }
    
}
