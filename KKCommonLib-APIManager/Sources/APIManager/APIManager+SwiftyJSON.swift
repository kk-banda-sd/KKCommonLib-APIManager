import Foundation

import Alamofire
import SwiftyJSON

public final class SwiftyJSONResponseSerializer: ResponseSerializer {
    public let options: JSONSerialization.ReadingOptions

    public let emptyResponseCodes: Set<Int>

    public let emptyRequestMethods: Set<HTTPMethod>

    public typealias SerializedObject = JSON

    public init(options: JSONSerialization.ReadingOptions = .allowFragments,
                emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes,
                emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods) {
        self.options = options
        self.emptyResponseCodes = emptyResponseCodes
        self.emptyRequestMethods = emptyRequestMethods
    }

    public func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> SerializedObject {
        guard error == nil else { throw error! }

        if let response = response, emptyResponseCodes.contains(response.statusCode) { return JSON.null }

        guard let validData = data, validData.count > 0 else {
            throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
        }

        do {
            let json = try JSONSerialization.jsonObject(with: validData, options: options)
            return JSON(json)
        } catch {
            throw AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))
        }
    }
}

extension DataRequest {
    @discardableResult
    public func responseSwiftyJSON(queue: DispatchQueue? = nil,
                                   options: JSONSerialization.ReadingOptions = .allowFragments,
                                   completionHandler: @escaping (AFDataResponse<SwiftyJSONResponseSerializer.SerializedObject>) -> Void) -> Self {
        let serializer = SwiftyJSONResponseSerializer(options: options)
        if let q = queue {
            return response(queue: q,
                            responseSerializer: serializer,
                            completionHandler: completionHandler)

        } else {
            return response(responseSerializer: serializer,
                            completionHandler: completionHandler)
        }
    }
}
