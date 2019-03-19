//
//  PhotoCell.swift
//  ImageSearch
//
//  Created by Marian Shkurda on 3/19/19.
//  Copyright © 2019 Marian Shkurda. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    static let ID = NSStringFromClass(PhotoCell.self)
    private let height: CGFloat = 150.0
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let keywordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var keyword = "" {
        didSet{
            keywordLabel.text = keyword
        }
    }
    
    var photoData: Data? {
        didSet {
            if let photo = photoData, let image = UIImage(data: photo) {
                photoImageView.image = image
            } else {
                photoImageView.image = nil
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(photoImageView)
        addSubview(keywordLabel)
        
        let photoImageViewLeadingAnchor = photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let photoImageViewTopAnchor = photoImageView.topAnchor.constraint(equalTo: self.topAnchor)
        let photoImageViewTrailingAnchor = photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let photoImageViewHeight = photoImageView.heightAnchor.constraint(equalToConstant: height)
        
        NSLayoutConstraint.activate([photoImageViewTopAnchor, photoImageViewLeadingAnchor,
                                     photoImageViewTrailingAnchor, photoImageViewHeight])
        
        let keywordLabelLeadingAnchor = keywordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let keywordLabelTopAnchor = keywordLabel.topAnchor.constraint(equalTo: self.photoImageView.bottomAnchor)
        let keywordLabelTrailingAnchor = keywordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let keywordLabelBottomAnchor = keywordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        NSLayoutConstraint.activate([keywordLabelTopAnchor, keywordLabelTrailingAnchor,
                                     keywordLabelBottomAnchor, keywordLabelLeadingAnchor])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
