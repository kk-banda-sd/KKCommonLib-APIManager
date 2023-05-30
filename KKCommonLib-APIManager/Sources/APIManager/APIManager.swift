import Alamofire

open class APIManager {
    
    // MARK: - Vars & Lets
    public let session: Session
    static public var networkEnviroment: NetworkEnvironment = .production
    
    // MARK: - Vars & Lets
    private static var configurator: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        return configuration
    }
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(session: Session(configuration: configurator))
        
        return apiManager
    }()
    
    // MARK: - Accessors
    public class func shared() -> APIManager {
        return self.sharedApiManager
    }
    
    // MARK: - Initialization
    private init(session: Session) {
        self.session = session
    }
}

// MARK: - Requests
public extension APIManager {
    @discardableResult
    func request<T: APIResponse>(type: EndPointType, params: Parameters? = nil, responseClass: T, handler: @escaping (T) -> Void) -> APIRequest {
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
