//
//  DiscourseClientLocalDataManager.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 14/03/2021.
//

import Foundation

/// Protocolo que representa todas las opraciones de acceso a base de datos local de la app
protocol DiscourseClientLocalDataManager {
    func getConfigFromKeyChain(completion: @escaping (Config) -> ())
    func saveConfigToKeyChain(username: String, apikey: String) -> ()
}
