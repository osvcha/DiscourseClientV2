//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 28/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol UserCellViewModelViewDelegate: class {
    func userImageFetched()
}

class UserCellViewModel {
    weak var viewDelegate: UserCellViewModelViewDelegate?
    let user: User
    let nameLabelText: String?
    var userImage: UIImage?
    
    init(user: User, dataManager: UsersDataManager) {
        self.user = user

        nameLabelText = user.name ?? "¡Sin Nombre!"
        
        dataManager.fetchUserImage(avatarURL: user.avatarTemplate) { [weak self] (data) in
            
            self?.userImage = UIImage(data: data)
            self?.viewDelegate?.userImageFetched()
        }
        

    }
}

