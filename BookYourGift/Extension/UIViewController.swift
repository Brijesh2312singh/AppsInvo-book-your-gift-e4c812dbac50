//
//  UIViewController.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import Foundation
import UIKit
extension UIViewController {
    func showPopup(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }
}
