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

open class APIResponse: NSObject {

    public var complete: Bool = false
    
    public var error: KKError?
    
    open func parseFromResponse(_ dict: JSON) {
        
    }
}
