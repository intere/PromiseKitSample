//
//  DataErrors.swift
//  PromiseKitSample
//
//  Created by Internicola, Eric on 3/21/16.
//  Copyright © 2016 iColasoft. All rights reserved.
//

import UIKit

enum DataErrors: ErrorType {
    case InvalidImageData

    func message() -> String {
        switch self {
        case .InvalidImageData:
            return "Couldn't create an image from the Data"
        }
    }
}
