//
//  PicturePreviewViewController.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


class PicturePreviewViewController: UIViewController, MVVMViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Public Properties
    
    var viewModel: PicturePreviewViewModel!
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        setupButtonShadows()
        viewModel.refreshImage()
    }
    
    // MARK: - Private methods
    
    private func setupButtonShadows() {
        setupShadow(for: saveButton)
        setupShadow(for: closeButton)
    }
    
    private func setupShadow(for view: UIView) {
        view.layer.shadowColor =  UIColor.black.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize.zero
    }
    
    private func bindViewModel() {
        viewModel.image.observe = { [weak self] _, image in
            self?.previewImageView.image = image
            self?.previewImageView.isHidden = (image == nil)
            self?.saveButton.isEnabled = (image != nil)
        }
        
        viewModel.isLoadingImage.observe = { [weak self] _, isLoading in
            isLoading
                ? self?.loadingActivityIndicator.startAnimating()
                : self?.loadingActivityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func tapClose() {
        viewModel.finishFlow()
    }
    
    @IBAction private func tapSave() {
        viewModel.savePicture()
    }
    
}
