//
//  APIResponse.swift
//  BaseProject
//
//  Created by CherryPie Studio on 04.07.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit
import SwiftyJSON
import KKCommonLib

class APIResponse: NSObject {

    var complete: Bool = false
    
    var error: SMError?
    
    func parseFromResponse(_ dict: JSON) {
        print("dict = \(dict)")
        if let errorCode = dict["statusCode"].int, let errorMessage = dict["message"].string {
            self.error = SMError(message: errorMessage, code: errorCode)
            if errorCode == 111 {
                NotificationCenter.default.post(name: kNotificationLogout, object: nil)
            }
        } else if var errorMessage = dict["error"].string {
            let messages = dict["message"].arrayValue
            if messages.notEmpty {
                for item in messages {
                    guard let string = item.string else { continue }
                    errorMessage.append("\n\(string)")
                }
            }
            self.error = SMError(message: errorMessage)
        }
    }
}
