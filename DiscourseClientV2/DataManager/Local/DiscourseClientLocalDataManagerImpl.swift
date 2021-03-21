//
//  DiscourseClientLocalDataManagerImpl.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 14/03/2021.
//

import Foundation
import SwiftKeychainWrapper
/// Implementación por defecto
final class DiscourseClientLocalDataManagerImpl: DiscourseClientLocalDataManager {
    
    
    
    func getConfigFromKeyChain(completion: @escaping (Config) -> ()) {
        
        //valores por defecto
        //En una caso mas real se crearían al instalar la App pidendole los datos al usuario
        var username = "osvcha"
        var apikey = "699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a"
        
        let usernameFromKeychain = KeychainWrapper.standard.string(forKey: "username")
        let apikeyFromKeychain = KeychainWrapper.standard.string(forKey: "apikey")
        
        
        if usernameFromKeychain != "" {
            if let usernameFromKeychain = usernameFromKeychain {
                username = usernameFromKeychain
            }
        }
        
        if apikeyFromKeychain != "" {
            if let apikeyFromKeychain = apikeyFromKeychain {
                apikey = apikeyFromKeychain
            }
        }
        
        let config = Config(username: username, apikey: apikey)
        
        completion(config)
        
    }
    
    func saveConfigToKeyChain(username: String, apikey: String) {
        
        KeychainWrapper.standard.set(username, forKey: "username")
        KeychainWrapper.standard.set(apikey, forKey: "apikey")
        
    }
    
    
}
