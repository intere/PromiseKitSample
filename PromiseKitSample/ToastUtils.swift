//
//  ToastUtils.swift
//  PromiseKitSample
//
//  Created by Internicola, Eric on 3/21/16.
//  Copyright © 2016 iColasoft. All rights reserved.
//

import UIKit
import Toast

class ToastUtils {

    /**
     Show a toast message in the key window.
     - Parameter text: The body of the toast
     - Parameter title: The toast title.
     - Parameter icon: The icon to show
     */
    class func showToast(text: String, title: String? = nil, icon: String? = nil) {
        if let keyWindow = UIApplication.sharedApplication().keyWindow {
            dispatch_async(dispatch_get_main_queue()) {
                let toastStyle = CSToastStyle(defaultStyle: ())
                keyWindow.makeToast(text, duration: 5, position: "center", title: title ?? "", image: UIImage(named: icon ?? ""), style: toastStyle, completion: nil)
            }
        }
    }

}
