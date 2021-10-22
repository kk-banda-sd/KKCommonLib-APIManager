//
//  EndPointType.swift
//  CashFlow
//
//  Created by Kostya Karakay on 11.01.2020.
//  Copyright © 2020 Kostya Karakay. All rights reserved.
//

import Alamofire

public protocol EndPointType {
    
    // MARK: - Vars & Lets
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}

public enum NetworkEnvironment: String, CaseIterable {
    case staging
    case production
}
