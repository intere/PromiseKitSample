//
//  RequestErrors.swift
//  PromiseKitSample
//
//  Created by Internicola, Eric on 3/21/16.
//  Copyright © 2016 iColasoft. All rights reserved.
//

import Foundation

enum RequestErrors: ErrorType {
    case UrlCreationError
    case RequestError
    case UnknownError
    case ResponseNotOk

    func message() -> String {
        switch self {
        case .UrlCreationError:
            return "Could not create a URL"
        case .RequestError:
            return "There was an error with the request"
        case .UnknownError:
            return "An Unknown Error Occurred"
        case .ResponseNotOk:
            return "The server responded with a non-OK response"
        }
    }
}
