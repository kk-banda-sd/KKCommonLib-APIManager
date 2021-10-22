//
//  APIManager.swift
//  CashFlow
//
//  Created by Kostya Karakay on 11.01.2020.
//  Copyright © 2020 Kostya Karakay. All rights reserved.
//

import Alamofire
import Alamofire_SwiftyJSON

open class APIManager {
    
    // MARK: - Vars & Lets
    private let sessionManager: SessionManager
    static var networkEnviroment: NetworkEnvironment = UserData.networkEnvironment
    
    // MARK: - Vars & Lets
    private static var configurator: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return configuration
    }
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: SessionManager(configuration: configurator))
        
        return apiManager
    }()
    
    // MARK: - Accessors
    public class func shared() -> APIManager {
        return self.sharedApiManager
    }
    
    // MARK: - Initialization
    private init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
}

// MARK: - Requests
public extension APIManager {
    @discardableResult
    func request<T: APIResponse>(type: EndPointType, params: Parameters? = nil, responseClass: T, handler: @escaping (T) -> Void) -> APIRequest {
        return self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).responseSwiftyJSON(queue: .main, completionHandler: { (response) in
                                        let serverResponse = responseClass
                                        if let statusCode = response.response?.statusCode, statusCode == 200 || statusCode == 201 {
                                            serverResponse.complete = true
                                        }
                                        if let JSON = response.result.value {
                                            if serverResponse.complete == false {
                                                serverResponse.complete = !response.result.isFailure
                                            }
                                            serverResponse.parseFromResponse(JSON)
                                        } else if let error = response.error, serverResponse.complete == false {
                                            serverResponse.error = error.kkError
                                            serverResponse.complete = !response.result.isFailure
                                        }
                                        handler(serverResponse)
                                    }).apiRequest
    }
}
