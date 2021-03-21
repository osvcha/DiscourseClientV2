//
//  UserImageService.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 18/03/2021.
//

import Foundation

protocol UserImageService: class {
    func fetchUserImage(avatarURL: String, completion: @escaping (Data) -> Void)
}
