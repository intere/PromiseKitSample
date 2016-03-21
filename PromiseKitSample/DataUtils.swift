//
//  DataUtils.swift
//  PromiseKitSample
//
//  Created by Internicola, Eric on 3/21/16.
//  Copyright © 2016 iColasoft. All rights reserved.
//

import Foundation
import PromiseKit

class DataUtils {

    class func deserializeJsonData(data: NSData) -> Promise<AnyObject> {
        return Promise { fulfill, reject in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    fulfill(json)
                    return
                } catch let error as NSError {
                    print("Couldn't deserialize JSON: \(error.localizedDescription)")
                    reject(JsonErrors.DeserializationError)
                    return
                }
                reject(JsonErrors.DeserializationError)
            }
        }
    }
}
