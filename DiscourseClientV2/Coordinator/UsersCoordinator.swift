//
//  UsersCoordinator.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 14/03/2021.
//

import UIKit

class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDataManager: UserDataManager

    init(presenter: UINavigationController, usersDataManager: UsersDataManager, userDataManager: UserDataManager) {
        self.userDataManager = userDataManager
        self.usersDataManager = usersDataManager
        self.presenter = presenter
    }

    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        usersViewController.title = NSLocalizedString("Users", comment: "")
        presenter.pushViewController(usersViewController, animated: false)
    }

    override func finish() {}
}

extension UsersCoordinator: UsersViewModelCoordinatorDelegate {
    func didSelect(username: String) {
        let userViewModel = UserViewModel(username: username, userDataManager: userDataManager)
        let userViewController = UserViewController(viewModel: userViewModel)
        userViewModel.viewDelegate = userViewController
        userViewController.title = NSLocalizedString(username, comment: "")
        presenter.pushViewController(userViewController, animated: true)
    }
}
