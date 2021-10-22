import UIKit
import SwiftyJSON
import KKCommonLib

open class APIResponse: NSObject {

    public var complete: Bool = false
    
    public var error: KKError?
    
    open func parseFromResponse(_ dict: JSON) {
        
    }
}
