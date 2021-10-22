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
    
    var error: KKError?
    
    func parseFromResponse(_ dict: JSON) {
        
    }
}
