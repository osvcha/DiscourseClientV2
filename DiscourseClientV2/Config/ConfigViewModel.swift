//
//  ConfigViewModel.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 21/03/2021.
//

import Foundation

protocol ConfigViewDelegate: class {
    func configDataFetched()
}

class ConfigViewModel {
    
    weak var viewDelegate: ConfigViewDelegate?
    let configDataManager: ConfigDataManager
    
    var usernameLabelText: String?
    var apikeyLabelText: String?
    
    init(configDataManager: ConfigDataManager) {
        self.configDataManager = configDataManager
    }
    
    func viewWasLoaded() {
        fetchConfigFromKeyChain()
    }
    
    func fetchConfigFromKeyChain() {
        
        configDataManager.getConfigFromKeyChain { [weak self] (result) in
            
            self?.usernameLabelText = result.username
            self?.apikeyLabelText = result.apikey
            
            self?.viewDelegate?.configDataFetched()
            
        }
    }
    
    func submitButtonTapped(username: String, apikey: String) {
        
        if(username != "" && apikey != "") {
            configDataManager.saveConfigToKeyChain(username: username, apikey: apikey)
        }
        
    }
    
}
