//
//  AppCoordinator.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 14/03/2021.
//

import UIKit

/// Coordinator principal de la app. Encapsula todas las interacciones con la Window.
/// Tiene dos hijos, el topic list, y el users list (uno por cada tab)
class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()
    var topicsCoordinator: TopicsCoordinator?
    

    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()

    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()

    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()

    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let tabBarController = UITabBarController()
        
        tabBarController.delegate = self

        let topicsNavigationController = UINavigationController()
        topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager)
        guard let topicsCoordinator = topicsCoordinator else {return}
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()

        
        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController, usersDataManager: dataManager, userDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()
        
        let configNavigationController = UINavigationController()
        let configCoordinator = ConfigCoordinator(presenter: configNavigationController, configDataManager: dataManager)
        addChildCoordinator(configCoordinator)
        configCoordinator.start()

        tabBarController.tabBar.tintColor = .brownGrey
        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController, configNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage(named: "inicioUnselected")
        tabBarController.tabBar.items?.first?.selectedImage = UIImage(named: "inicio")
        tabBarController.tabBar.items?[1].image = UIImage(named: "usuariosUnselected")
        tabBarController.tabBar.items?[1].selectedImage = UIImage(named: "usuarios")
        tabBarController.tabBar.items?[2].image = UIImage(named: "ajustesUnselected")
        tabBarController.tabBar.items?[2].selectedImage = UIImage(named: "ajustes")

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    override func finish() {}
}

extension AppCoordinator: UITabBarControllerDelegate {
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if(viewController as? UINavigationController)?.viewControllers.first is TopicsViewController {
            topicsCoordinator?.didSelectTabBarItem()
        }
        
        if(viewController as? UINavigationController)?.viewControllers.first is UsersViewController {
            print("users pressed")
        }
    }
}
