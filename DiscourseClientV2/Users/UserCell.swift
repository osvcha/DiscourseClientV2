//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {

    static let cellIdentifier = "UserCell"
    
    private let photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.clipsToBounds = true
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 40
        return photoImage
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        nameLabel.textColor = .blackColorOfLabels
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureCell()


    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.viewDelegate = self
            nameLabel.text = viewModel.nameLabelText
            photoImage.image = viewModel.userImage
        }
    }
    
    func configureCell() {
        
        //Background
        contentView.backgroundColor = .white
        
        //Vistas
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImage)
        
        //Constraints
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photoImage.widthAnchor.constraint(equalToConstant: 80.0),
            photoImage.heightAnchor.constraint(equalToConstant: 80.0),
            nameLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 9),
            nameLabel.centerXAnchor.constraint(equalTo: photoImage.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 94.0),

        ])
        
        
        
    }
}

extension UserCell: UserCellViewModelViewDelegate {
    func userImageFetched() {
        
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

