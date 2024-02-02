//
//  AppliedCouponsVC.swift
//  BookYourGift
//
//  Created by Apple on 02/08/23.
//

import UIKit

class AppliedCouponsVC: UIViewController {

    @IBOutlet weak var appliedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        appliedView.layer.cornerRadius = 10

      
    }
    

    @IBAction func okkBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
