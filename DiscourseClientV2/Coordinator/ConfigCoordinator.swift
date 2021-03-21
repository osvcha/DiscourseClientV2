//
//  ConfigCoordinator.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 21/03/2021.
//

import UIKit

class ConfigCoordinator: Coordinator {
    let presenter: UINavigationController
    let configDataManager: ConfigDataManager
    var configViewModel: ConfigViewModel?
    
    init(presenter: UINavigationController, configDataManager: ConfigDataManager) {
        self.presenter = presenter
        self.configDataManager = configDataManager
    }
    
    override func start() {
        let configViewModel = ConfigViewModel(configDataManager: configDataManager)
        let configViewController = ConfigViewController(viewModel: configViewModel)
        configViewController.title = NSLocalizedString("Config", comment: "")
        configViewModel.viewDelegate = configViewController
        self.configViewModel = configViewModel
        presenter.pushViewController(configViewController, animated: false)
    }
    
    override func finish() {}
    
}
