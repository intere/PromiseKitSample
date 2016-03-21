//
//  ServerQueryProvider.swift
//  PromiseKitSample
//
//  Created by Internicola, Eric on 3/21/16.
//  Copyright © 2016 iColasoft. All rights reserved.
//

import UIKit
import PromiseKit

class ServerQueryProvider {
    static let instance = ServerQueryProvider()

    let usersUrlString = "http://jsonplaceholder.typicode.com/users"
    let failureUrlString = "http://jsonplaceholder.typicode.com/fake"
    let imageUrlString = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"

    /**
     Loads the users URL (which responds with a 200).
     - Returns: A Promise object (which should succeed).
     */
    func loadUsers() -> Promise<NSData> {
        return loadUrl(usersUrlString)
    }

    /**
     Loads the failure URL (which responds with a 404).
     - Returns: A Promise object (which should fail).
     */
    func loadFailureUrl() -> Promise<NSData> {
        return loadUrl(failureUrlString)
    }

    /**
    Loads the image URL.
     - Returns: A Promise object (which should succeed).
    */
    func loadImageUrl() -> Promise<UIImage> {
        return Promise<UIImage> { fulfill, reject in
            return loadUrl(imageUrlString).then { (data) -> (Void) in
                if let image = UIImage(data: data) {
                    fulfill(image)
                } else {
                    reject(DataErrors.InvalidImageData)
                }
            }.error { (errorType) -> Void in
                reject(errorType)
            }
        }
    }
}

// MARK: - Helper Methods

extension ServerQueryProvider {

    /**
    Promise-based API that attempts to load the provided urlString.
     - Parameter urlString: The URL that you want to load.
     - Returns: A promise which will either succeed (then) or fail (.
    */
    func loadUrl(urlString: String) -> Promise<NSData> {
        return Promise { fulfill, reject in
            if let url = NSURL(string: urlString) {
                let session = NSURLSession.sharedSession()
                session.dataTaskWithURL(url) { (data, response, error) in
                    if let error = error {
                        print("Error fetching URL: \(url.absoluteString): \(error.localizedDescription)")
                        reject(RequestErrors.RequestError)
                    } else if let data = data, response = response as? NSHTTPURLResponse {
                        if response.statusCode == 200 {
                            fulfill(data)
                        } else {
                            reject(RequestErrors.ResponseNotOk)
                        }
                    } else {
                        reject(RequestErrors.UnknownError)
                    }
                }.resume()
            } else {
                reject(RequestErrors.UrlCreationError)
            }
        }
    }
}

