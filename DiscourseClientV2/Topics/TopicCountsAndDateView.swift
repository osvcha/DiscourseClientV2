//
//  TopicCountsAndDateView.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 19/03/2021.
//

import UIKit

class TopicCountsAndDateStackView: UIStackView {

    var postCount: String? {
        get { return postCountLabel.text }
        set { postCountLabel.text = newValue }
    }
    
    var numberPosters: String? {
        get { return numberPostersLabel.text }
        set { numberPostersLabel.text = newValue }
    }
    
    var date: String? {
        get { return dateLabel.text }
        set { dateLabel.text = newValue }
    }
    
    
    //post count: image + label + stackview
    private let postCountImage: UIImageView = {
        let postCountImage = UIImageView()
        postCountImage.translatesAutoresizingMaskIntoConstraints = false
        postCountImage.clipsToBounds = true
        postCountImage.contentMode = .scaleAspectFill
        postCountImage.image = UIImage(named: "icoSmallAnswers")
        return postCountImage
    }()
        
    private let postCountLabel: UILabel = {
        let postCountLabel = UILabel()
        postCountLabel.translatesAutoresizingMaskIntoConstraints = false
        postCountLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        postCountLabel.textColor = .greyColorOfLabels
        return postCountLabel
    }()
    
    lazy var postCountStackView: UIStackView = {
        let postCountStackView = UIStackView(arrangedSubviews: [postCountImage, postCountLabel])
        postCountStackView.translatesAutoresizingMaskIntoConstraints = false
        postCountStackView.axis = .horizontal
        postCountStackView.alignment = .center
        postCountStackView.distribution = .fill
        postCountStackView.spacing = 4
        return postCountStackView
    }()
    
    //number poster: image + label + stackview
    private let numberPostersImage: UIImageView = {
        let numberPostersImage = UIImageView()
        numberPostersImage.translatesAutoresizingMaskIntoConstraints = false
        numberPostersImage.clipsToBounds = true
        numberPostersImage.contentMode = .scaleAspectFill
        numberPostersImage.image = UIImage(named: "icoViewsSmall")
        return numberPostersImage
    }()
    
    private let numberPostersLabel: UILabel = {
        let numberPostersLabel = UILabel()
        numberPostersLabel.translatesAutoresizingMaskIntoConstraints = false
        numberPostersLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        numberPostersLabel.textColor = .greyColorOfLabels
        return numberPostersLabel
    }()
    
    lazy var numberPostersStackView: UIStackView = {
        let numberPostersStackView = UIStackView(arrangedSubviews: [numberPostersImage, numberPostersLabel])
        numberPostersStackView.translatesAutoresizingMaskIntoConstraints = false
        numberPostersStackView.axis = .horizontal
        numberPostersStackView.alignment = .center
        numberPostersStackView.distribution = .fill
        numberPostersStackView.spacing = 4
        return numberPostersStackView
    }()
    
    //date: image + label + stackview
    private let dateImage: UIImageView = {
        let dateImage = UIImageView()
        dateImage.translatesAutoresizingMaskIntoConstraints = false
        dateImage.clipsToBounds = true
        dateImage.contentMode = .scaleAspectFill
        dateImage.image = UIImage(named: "icoSmallCalendar")
        return dateImage
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        dateLabel.textColor = .greyColorOfLabels
        return dateLabel
    }()
    
    lazy var dateStackView: UIStackView = {
        let dateStackView = UIStackView(arrangedSubviews: [dateImage, dateLabel])
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.axis = .horizontal
        dateStackView.alignment = .center
        dateStackView.distribution = .fill
        dateStackView.spacing = 4
        return dateStackView
    }()
    
    
    
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fill
        self.spacing = 8
        
        self.addArrangedSubview(postCountStackView)
        self.addArrangedSubview(numberPostersStackView)
        self.addArrangedSubview(dateStackView)
        
    }
    
    
    

}
