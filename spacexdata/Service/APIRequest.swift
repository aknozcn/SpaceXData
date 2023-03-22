//
//  APIRequest.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

import Moya

enum APIRequest {
    case getPast(page: Int)
    case getUpcoming(page: Int)
    case getLaunch(withId: String)
}

extension APIRequest: TargetType {

    var baseURL: URL {
        guard let url = URL(string: Environment.apiURL) else { fatalError() }
        return url
    }

    var path: String {
        switch self {
        case .getPast, .getUpcoming:
            return "/query"
        case .getLaunch(let id):
            return "/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPast, .getUpcoming:
            return .post
        case .getLaunch:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var getQueryParams: [String: Any] {
        switch self {
        case .getPast:
            return ["upcoming": false]
        case .getUpcoming:
            return ["upcoming": true]
        default:
            return [:]
        }
    }

    var task: Task {
        switch self {
        case .getPast(let page), .getUpcoming(let page):
            let options: [String: Any] = [
                "query": getQueryParams,
                "options": ["limit": 20,
                            "page": page]
            ]
            return .requestParameters(parameters: options, encoding: JSONEncoding.default)
        case .getLaunch:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
