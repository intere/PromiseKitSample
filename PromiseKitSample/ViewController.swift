//
//  ViewController.swift
//  PromiseKitSample
//
//  Created by Internicola, Eric on 3/21/16.
//  Copyright © 2016 iColasoft. All rights reserved.
//

import UIKit
import PromiseKit
import Toast

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageViewHeight: NSLayoutConstraint!
    @IBOutlet var imageViewWidth: NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

// MARK: - IBActions

extension ViewController {

    @IBAction func clickedLoadUsers(sender: UIButton) {
        firstly {
            ServerQueryProvider.instance.loadUsers()
        }.then { (data: NSData) in
            DataUtils.deserializeJsonData(data)
        }.then { (result: AnyObject) in
            ToastUtils.showToast("Loaded JSON: \(result)")
        }.error { (error) in
            if let error = error as? RequestErrors {
                ToastUtils.showToast("Error loading users: \(error.message())")
            } else if let error = error as? JsonErrors {
                ToastUtils.showToast("Error loading users: \(error.message())")
            } else {
                ToastUtils.showToast("Some sort of unknown error type occurred: \(error)")
            }
        }
    }

    @IBAction func clickedLoadFailing(sender: UIButton) {
        firstly {
            ServerQueryProvider.instance.loadFailureUrl()
        }.then { (data: NSData) in
            DataUtils.deserializeJsonData(data)
        }.then { (result: AnyObject) in
            ToastUtils.showToast("Loaded JSON: \(result)")
        }.error { (error) in
            if let error = error as? RequestErrors {
                ToastUtils.showToast("Error loading users: \(error.message())")
            } else if let error = error as? JsonErrors {
                ToastUtils.showToast("Error loading users: \(error.message())")
            } else {
                ToastUtils.showToast("Some sort of unknown error type occurred: \(error)")
            }
        }
    }

    @IBAction func clickedLoadImage(sender: UIButton) {
        firstly {
            ServerQueryProvider.instance.loadImageUrl()
        }.then { (image: UIImage) -> Void in
            self.displayImage(image)
        }.error { (error) in
            if let error = error as? RequestErrors {
                ToastUtils.showToast("Error loading image: \(error.message())")
            } else if let error = error as? JsonErrors {
                ToastUtils.showToast("Error loading image: \(error.message())")
            } else if let error = error as? DataErrors {
                ToastUtils.showToast("Error loading image: \(error.message())")
            } else {
                ToastUtils.showToast("Some sort of unknown error type occurred: \(error)")
            }
        }
    }

}

// MARK: - Helper Methods

extension ViewController {
    func displayImage(image: UIImage) {
        self.imageView.image = image

        if image.size.width <= view.frame.width {
            self.imageViewWidth.constant = image.size.width
            self.imageViewHeight.constant = image.size.height
        } else {
            let multiplier = view.frame.width / image.size.width
            self.imageViewWidth.constant = view.frame.width
            self.imageViewHeight.constant = image.size.height * multiplier
        }
    }
}
