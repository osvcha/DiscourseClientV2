//
//  TopicWelcomeCell.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 18/03/2021.
//

import UIKit

class TopicWelcomeCell: UITableViewCell {
    
    static let cellIdentifier = "TopicWelcomeCell"
    
    private let cellContent: UIView = {
        let cellContent = UIView()
        cellContent.translatesAutoresizingMaskIntoConstraints = false
        cellContent.backgroundColor = .tangerine
        cellContent.layer.cornerRadius = 10
        return cellContent
    }()
    
    //title
    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        headerLabel.textColor = .blackColorOfLabels
        return headerLabel
    }()
    
    //title
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .blackColorOfLabels
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let pinnedImage: UIImageView = {
        let pinnedImage = UIImageView()
        pinnedImage.translatesAutoresizingMaskIntoConstraints = false
        pinnedImage.clipsToBounds = true
        pinnedImage.contentMode = .scaleAspectFit
        pinnedImage.image = UIImage(named: "oin")
        return pinnedImage
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: TopicWelcomeCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            headerLabel.text = viewModel.headerLabelText
            titleLabel.text = viewModel.titleLabelText
            
        }
    }
    
    func configureCell() {
        
        //Background
        contentView.backgroundColor = .blackColorOfLabels
        
        contentView.addSubview(cellContent)
        contentView.addSubview(headerLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(pinnedImage)
        
        NSLayoutConstraint.activate([
            
            cellContent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            cellContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -23),
            cellContent.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            cellContent.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            headerLabel.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 9),
            headerLabel.leftAnchor.constraint(equalTo: cellContent.leftAnchor, constant: 18),
            headerLabel.rightAnchor.constraint(equalTo: cellContent.rightAnchor, constant: -46),
            
            titleLabel.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 43),
            titleLabel.leftAnchor.constraint(equalTo: cellContent.leftAnchor, constant: 18),
            titleLabel.rightAnchor.constraint(equalTo: cellContent.rightAnchor, constant: -73),
            
            pinnedImage.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 10),
            pinnedImage.rightAnchor.constraint(equalTo: cellContent.rightAnchor, constant: -7),
            pinnedImage.widthAnchor.constraint(equalToConstant: 30),
            
        ])
        
    }
}
