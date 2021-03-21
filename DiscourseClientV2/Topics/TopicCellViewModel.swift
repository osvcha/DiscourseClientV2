//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol TopicCellViewModelViewDelegate: class {
    func userTopicImageFetched()
}

class TopicCellViewModel: CellViewModel {
    weak var viewDelegate: TopicCellViewModelViewDelegate?
    let topic: Topic
    let userAvatarUrl: String
    var titleLabelText: String?
    var postCountLabelText: String?
    var numberPostersLabelText: String?
    var dateLabelText: String?
    var userImage: UIImage?
    
    init(topic: Topic, userAvatarUrl: String, dataManager: TopicsDataManager) {
        
        self.topic = topic
        self.userAvatarUrl = userAvatarUrl
        super.init()
        
        titleLabelText = topic.title
        postCountLabelText = String(topic.postsCount)
        numberPostersLabelText = String(topic.posters.count)
        
        //Formateo de la fecha
        let inputStringDate = topic.lastPostedAt
        let inputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = inputFormat
        guard let date = dateFormatter.date(from: inputStringDate) else { return }
        let outputFormat = "MMM dd"
        dateFormatter.dateFormat = outputFormat
        dateLabelText = dateFormatter.string(from: date)
        
        
        dataManager.fetchUserImage(avatarURL: userAvatarUrl) { [weak self] (data) in
            
            self?.userImage = UIImage(data: data)
            self?.viewDelegate?.userTopicImageFetched()
            
        }
        
        
    }
    
}


