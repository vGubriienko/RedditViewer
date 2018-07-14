//
//  EntryCell.swift
//  RedditViewer
//
//  Created by Viktor Gubriienko on 7/8/18.
//  Copyright © 2018 Viktor Gubriienko. All rights reserved.
//

import UIKit


class EntryCell: UITableViewCell {
    
    struct Model {
        let ID: String
        let author: String
        let postDate: Date
        let description: String
        let commentsCount: UInt
        let thumbURL: URL?
    }

    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    @IBOutlet private weak var thumbImageView: UIImageView!
    
    // MARK: - Public Properties
    
    var onTapThumb: ((_ model: Model?) -> Void)?
    
    var model: Model? {
        didSet {
            configureWithModel(model)
        }
    }

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupThumbTapRecognizer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configureWithModel(nil)
    }

    // MARK: - Private properties
    
    private func setupThumbTapRecognizer() {
        let tapThumbGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapThumb))
        thumbImageView.addGestureRecognizer(tapThumbGestureRecognizer)
    }
    
    private func configureWithModel(_ model: Model?) {
        if let model = model {
            titleLabel.text = "posted by \(model.author)\(String.timeAgo(from: model.postDate))"
            descriptionLabel.text = model.description
            if let thumbURL = model.thumbURL {
                thumbImageView.setImage(from: thumbURL, placeholder: #imageLiteral(resourceName: "no-image-small"))
                thumbImageView.isHidden = false
            } else {
                thumbImageView.cancelDownloadingImage()
                thumbImageView.image = nil
                thumbImageView.isHidden = true
            }
            
            
            switch model.commentsCount {
            case 0:
                commentsCountLabel.text = "no comments"
            case 1:
                commentsCountLabel.text = "1 comment"
            default:
                commentsCountLabel.text = "\(model.commentsCount) comments"
            }
        } else {
            titleLabel.text = nil
            descriptionLabel.text = nil
            commentsCountLabel.text = nil
            thumbImageView.cancelDownloadingImage()
            thumbImageView.image = nil
            thumbImageView.isHidden = true
        }
    }
    
    // MARK: - Actions
    
    @objc private func tapThumb(_ sender: UITapGestureRecognizer) {
        onTapThumb?(model)
    }
    
}
