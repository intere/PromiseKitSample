//
//  JsonErrors.swift
//  PromiseKitSample
//
//  Created by Internicola, Eric on 3/21/16.
//  Copyright © 2016 iColasoft. All rights reserved.
//

import UIKit

enum JsonErrors: ErrorType {
    case DeserializationError
    case UnknownError

    func message() -> String {
        switch self {
        case .DeserializationError:
            return "There was a problem deserializing the JSON"
        case .UnknownError:
            return "An Unknown Error occured trying to deserialize the JSON"
        }
    }
}
