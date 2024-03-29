import Alamofire

open class APIManager {
    
    // MARK: - Vars & Lets
    public let session: Session
    static public var networkEnviroment: NetworkEnvironment = .production
    private static var configurator: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 600
        configuration.timeoutIntervalForResource = 600
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        return configuration
    }
    
    // MARK: - Accessors
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(session: Session(configuration: configurator))
        
        return apiManager
    }()
    
    public class func shared() -> APIManager {
        return self.sharedApiManager
    }
    
    // MARK: - Initialization
    private init(session: Session) {
        self.session = session
    }
}

// MARK: - Request
public extension APIManager {
    @discardableResult
    func makeRequest<T: APIResponse>(type: EndPointType, params: Parameters? = nil, responseClass: T, handler: @escaping (T) -> Void) -> APIRequest {
        return self.session.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).responseSwiftyJSON(queue: .main, completionHandler: { (response) in
            let serverResponse = responseClass
            if let statusCode = response.response?.statusCode {
                if statusCode == 200 || statusCode == 201 {
                    serverResponse.complete = true
                }
            }
            switch response.result {
            case .success(let JSON):
                serverResponse.complete = true
                serverResponse.parseFromResponse(JSON)
            case .failure(let error):
                if (!serverResponse.complete) {
                    serverResponse.complete = false
                    serverResponse.error = error.kkError
                }
            }
            handler(serverResponse)
        }).apiRequest
    }
}
