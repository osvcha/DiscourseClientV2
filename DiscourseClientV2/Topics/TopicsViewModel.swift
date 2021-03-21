//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
    func finishRefreshing()
    func topicsTableScrollToTop()
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var cellViewModels: [CellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    fileprivate func fetchTopicsAndReloadUI() {
        topicsDataManager.fetchAllTopics { [weak self] (result) in
            
            guard let self = self else {return}
            switch result {
            case .success(let response):
                guard let response = response else { return }
                
                let users = response.users
                
                //listado de topics no pineados
                let topics = response.topicList.topics.filter({$0.pinned == false})

                self.cellViewModels = topics.map { (value) in
                    let lastPosterUser = users.filter({$0.username.localizedCaseInsensitiveContains(value.lastPosterUsername)})
                    return TopicCellViewModel(topic: value, userAvatarUrl: lastPosterUser.first?.avatarTemplate ?? "", dataManager: self.topicsDataManager)
                }
                
                //topic pineado para la celda de welcome
                if let welcomeTopic = response.topicList.topics.filter({$0.pinned == true}).first {
                    self.cellViewModels.insert(TopicWelcomeCellViewModel(topic: welcomeTopic), at: 0)
                }
                
                
                self.viewDelegate?.topicsFetched()
                self.viewDelegate?.finishRefreshing()
                
            case .failure:
                self.viewDelegate?.errorFetchingTopics()
                self.viewDelegate?.finishRefreshing()
            }
        }
        
    }

    func viewWasLoaded() {
        fetchTopicsAndReloadUI()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return cellViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> CellViewModel? {
        guard indexPath.row < cellViewModels.count else { return nil }
        return cellViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < cellViewModels.count else { return }
        if let topicCellViewModel = cellViewModels[indexPath.row] as? TopicCellViewModel {
            coordinatorDelegate?.didSelect(topic: topicCellViewModel.topic)
        }
        
    }
    
    func refreshLaunched() {
        fetchTopicsAndReloadUI()
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func newTopicWasCreated() {
        fetchTopicsAndReloadUI()
    }

    func topicWasDeleted() {
        fetchTopicsAndReloadUI()
    }
    
    func scrollToTop() {
        self.viewDelegate?.topicsTableScrollToTop()
    }
    
    
}
