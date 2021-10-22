import Alamofire

public struct APIRequest {
    public let id: String = UUID().uuidString
    public var request: DataRequest? = nil
    
    public func cancel() {
        request?.cancel()
    }
}

// MARK: - Equatable
extension APIRequest: Equatable {
    static public func == (lhs: APIRequest, rhs: APIRequest) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - APIRequest
extension DataRequest {
    public var apiRequest: APIRequest {
        return APIRequest(request: self)
    }
}
