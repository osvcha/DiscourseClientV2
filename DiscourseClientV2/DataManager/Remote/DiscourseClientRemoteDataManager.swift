//
//  DiscourseClientRemoteDataManager.swift
//  DiscourseClientV2
//
//  Created by Osvaldo Chaparro on 14/03/2021.
//

import Foundation

/// Protocolo que contiene todas las llamadas remotas de la app
protocol DiscourseClientRemoteDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ())
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ())
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ())
    func fetchUserImage(avatarURL: String, completion: @escaping (Data) -> ())
    func updateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ())
}
