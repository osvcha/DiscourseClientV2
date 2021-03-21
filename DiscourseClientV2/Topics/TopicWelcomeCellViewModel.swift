//
//  TopicWelcomeCellViewModel.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 18/03/2021.
//

import UIKit


class TopicWelcomeCellViewModel: CellViewModel {
    
    let topic: Topic
    var headerLabelText: String?
    var titleLabelText: String?
    
    init(topic: Topic) {
        
        self.topic = topic
        super.init()
        
        headerLabelText = "Bienvenido e eh.ho"
        titleLabelText = topic.title
        
        
    }
}
