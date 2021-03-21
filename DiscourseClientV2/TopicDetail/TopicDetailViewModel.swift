//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicSuccessfullyDeleted()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicDetailFetched()
    func errorFetchingTopicDetail()
    func errorDeletingTopic()
}

class TopicDetailViewModel {
    var labelTopicNameText: String?
    var postCountLabelText: String?
    var numberPostersLabelText: String?
    var dateLabelText: String?
    var cookedLabelText: String?

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        
        
        topicDetailDataManager.fetchTopic(id: topicID) { [weak self] (result) in
                        
            switch result {
            case .success(let response):
                guard let response = response else { return }

                self?.labelTopicNameText = response.title
                self?.postCountLabelText = "\(response.postsCount)"
                self?.numberPostersLabelText = "\(response.details.participants.count)"
                
                //Formateo de la fecha
                let inputStringDate = response.lastPostedAt
                let inputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "es_ES")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateFormat = inputFormat
                guard let date = dateFormatter.date(from: inputStringDate) else { return }
                let outputFormat = "MMM dd"
                dateFormatter.dateFormat = outputFormat
                self?.dateLabelText = dateFormatter.string(from: date)
                
                self?.cookedLabelText = response.postStream.posts.first?.cooked
                
                self?.viewDelegate?.topicDetailFetched()
            case .failure:
                self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }

    func deleteButtonTapped() {
        topicDetailDataManager.deleteTopic(id: topicID) { [weak self] (result) in
            switch result {
            case .success:
                self?.coordinatorDelegate?.topicSuccessfullyDeleted()
            case .failure:
                self?.viewDelegate?.errorDeletingTopic()
            }
        }
    }
}
