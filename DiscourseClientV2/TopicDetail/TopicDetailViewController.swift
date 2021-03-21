//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class TopicDetailViewController: UIViewController {

    

    lazy var topicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .blackColorOfLabels
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    lazy var topicCountAndDateStackView: TopicCountsAndDateStackView = {
        let topicCountAndDateStackView = TopicCountsAndDateStackView()
        topicCountAndDateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return topicCountAndDateStackView
    }()
    
    lazy var cookedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .blackColorOfLabels
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    
    
    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        
        configureTheView()

    }
    
    func configureTheView() {
        
        view.backgroundColor = .white
        
        
        view.addSubview(topicTitleLabel)
        view.addSubview(topicCountAndDateStackView)
        view.addSubview(cookedLabel)
        
        

        NSLayoutConstraint.activate([
            
            topicTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            topicTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topicTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            topicCountAndDateStackView.topAnchor.constraint(equalTo: topicTitleLabel.bottomAnchor, constant: 19),
            topicCountAndDateStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            cookedLabel.topAnchor.constraint(equalTo: topicCountAndDateStackView.bottomAnchor, constant: 16),
            cookedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cookedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        //Navigation Item
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .tangerine
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }

    @objc func deleteButtonTapped() {
        viewModel.deleteButtonTapped()
    }

    fileprivate func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func showErrorDeletingTopic() {
        let alertMessage: String = NSLocalizedString("Error deleting topic\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI() {
        
        topicTitleLabel.text = viewModel.labelTopicNameText
        
        topicCountAndDateStackView.postCount = viewModel.postCountLabelText
        topicCountAndDateStackView.numberPosters = viewModel.numberPostersLabelText
        topicCountAndDateStackView.date = viewModel.dateLabelText
        
        cookedLabel.text = viewModel.cookedLabelText?.stripHTML()
        cookedLabel.setLineHeight(lineHeight: 30)
        
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func topicDetailFetched() {
        updateUI()
    }

    func errorFetchingTopicDetail() {
        showErrorFetchingTopicDetailAlert()
    }

    func errorDeletingTopic() {
        showErrorDeletingTopic()
    }
}
