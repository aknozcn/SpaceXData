//
//  APIManager.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

import Moya

protocol APIManaging {
    func fetchPastLaunches(page: Int, completion: @escaping (Result<LaunchV4Response, Error>) -> ())
    func fetchUpcomingLaunches(page: Int, completion: @escaping (Result<LaunchV4Response, Error>) -> ())
    func fetchLaunch(id: String, completion: @escaping (Result<LaunchV4Doc, Error>) -> ())
}

class APIManager: APIManaging {
    
    private var provider = MoyaProvider<APIRequest>(plugins: [NetworkLoggerPlugin()])
    
    func fetchPastLaunches(page: Int, completion: @escaping (Result<LaunchV4Response, Error>) -> ()) {
        request(target: .getPast(page: page), completion: completion)
    }
    
    func fetchUpcomingLaunches(page: Int, completion: @escaping (Result<LaunchV4Response, Error>) -> ()) {
        request(target: .getUpcoming(page: page), completion: completion)
    }
    
    func fetchLaunch(id: String, completion: @escaping (Result<LaunchV4Doc, Error>) -> ()) {
        request(target: .getLaunch(withId: id), completion: completion)
     }

    private func request<T: Decodable>(target: APIRequest, completion: @escaping(Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
