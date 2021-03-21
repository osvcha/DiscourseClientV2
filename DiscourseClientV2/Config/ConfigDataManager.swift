//
//  ConfigDataManager.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 21/03/2021.
//

import Foundation

protocol ConfigDataManager {
    
    func getConfigFromKeyChain(completion: @escaping (Config) -> ())
    func saveConfigToKeyChain(username: String, apikey: String) -> ()
    
}
