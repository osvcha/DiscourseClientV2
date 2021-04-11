//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    static let cellIdentifier = "TopicCell"
    
    //title
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .blackColorOfLabels
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    //user image
    private let photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.clipsToBounds = true
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 32
        return photoImage
    }()
    
    
    
    lazy var topicCountAndDateStackView: TopicCountsAndDateStackView = {
        let topicCountAndDateStackView = TopicCountsAndDateStackView()
        topicCountAndDateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return topicCountAndDateStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            titleLabel.text = viewModel.titleLabelText
            titleLabel.setLineHeight(lineHeight: 22)
            photoImage.image = viewModel.userImage
                        
            topicCountAndDateStackView.postCount = viewModel.postCountLabelText
            topicCountAndDateStackView.numberPosters = viewModel.numberPostersLabelText
            topicCountAndDateStackView.date = viewModel.dateLabelText
            
            
        }
    }
    
    func configureCell() {
        
        //Background
        contentView.backgroundColor = .myWhite
        
        contentView.layoutMargins = .zero
        
        
        contentView.addSubview(photoImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(topicCountAndDateStackView)
        
        NSLayoutConstraint.activate([
            
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            photoImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            photoImage.widthAnchor.constraint(equalToConstant: 64.0),
            photoImage.heightAnchor.constraint(equalToConstant: 64.0),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 91),
            titleLabel.widthAnchor.constraint(equalToConstant: 225),
            
            topicCountAndDateStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 65),
            topicCountAndDateStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 91),
    
        ])
    }
    
    
    
    
}

extension TopicCell: TopicCellViewModelViewDelegate {
    func userTopicImageFetched() {
        photoImage.alpha = 0
        photoImage.image = viewModel?.userImage
        
        UIView.animate(withDuration: 1) {
            [weak self] in
            guard let self = self else {return}
            self.photoImage.alpha = 1.0
        }
        
        setNeedsLayout()

    }
    
   
}
