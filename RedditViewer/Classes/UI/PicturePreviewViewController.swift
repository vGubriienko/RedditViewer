//
//  PicturePreviewViewController.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


class PicturePreviewViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var previewImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    
    @IBAction private func tapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tapSave() {
        
    }
    
}
