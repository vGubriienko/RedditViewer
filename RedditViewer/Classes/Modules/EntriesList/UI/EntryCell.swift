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
        let thumb: UIImage?
    }

    // MARK: - Outlets
    
    @IBOutlet private weak var thumbButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    
    // MARK: - Public Properties
    
    var model: Model? {
        didSet {
            configureWithModel(model)
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configureWithModel(nil)
    }

    // MARK: - Private properties
    
    private func configureWithModel(_ model: Model?) {
        if let model = model {
            titleLabel.text = "posted by \(model.author) at \(model.postDate)" //TODO: set proper string
            descriptionLabel.text = model.description
            thumbButton.setImage(model.thumb ?? #imageLiteral(resourceName: "no-image-small"), for: .normal)
            
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
            thumbButton.setImage(#imageLiteral(resourceName: "no-image-small"), for: .normal)
            commentsCountLabel.text = nil
        }
    }
    
}
