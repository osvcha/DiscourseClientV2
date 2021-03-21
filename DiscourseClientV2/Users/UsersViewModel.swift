//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersViewModelCoordinatorDelegate: class {
    func didSelect(username: String)
}

protocol UsersViewModelViewDelegate: class {
    func usersWereFetched()
    func errorFetchingUsers()
    func finishRefreshing()
}

/// ViewModel representando un listado de usuarios
class UsersViewModel {
    weak var coordinatorDelegate: UsersViewModelCoordinatorDelegate?
    weak var viewDelegate: UsersViewModelViewDelegate?
    var userViewModels: [UserCellViewModel] = []
    let usersDataManager: UsersDataManager

    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }

    func viewWasLoaded() {
        
        loadUsers()
        
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        return userViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        coordinatorDelegate?.didSelect(username: userViewModels[indexPath.row].user.username)
    }
    
    func refreshLaunched() {
        loadUsers()
    }
    
    func loadUsers() {
        
        
        usersDataManager.fetchAllUsers { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success(let response):
                guard let response = response else { return }
                self.userViewModels = response.directoryItems.map({ UserCellViewModel(user: $0.user, dataManager: self.usersDataManager) })
                self.viewDelegate?.usersWereFetched()
                self.viewDelegate?.finishRefreshing()
            case .failure:
                self.viewDelegate?.errorFetchingUsers()
                self.viewDelegate?.finishRefreshing()
            }
        }
        
        
        
    }
}
