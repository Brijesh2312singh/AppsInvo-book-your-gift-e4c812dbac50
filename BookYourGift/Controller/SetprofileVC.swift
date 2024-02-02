//
//  SetprofileVC.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit

class SetprofileVC: UIViewController {
    
    @IBOutlet weak var setImageView: UIImageView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var eTF: UITextField!
    @IBOutlet weak var lTF: UITextField!
    @IBOutlet weak var fTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var lastnameView: UIView!
    @IBOutlet weak var firstnameView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstnameView.layer.cornerRadius = 10
        lastnameView.layer.cornerRadius = 10
        emailView.layer.cornerRadius = 10
        submitBtn.layer.cornerRadius = 10
        
        
    }
    
    @IBAction func cameraTappedBtn(_ sender: UIButton) {
    }
    
    
    @IBAction func submitTappedBtn(_ sender: UIButton) {
        
        if fTF.text == "" {
            self.showPopup(title: "Alert", message: "Please enter First Name")
        } else if lTF.text == "" {
            self.showPopup(title: "Alert", message: "Please enter Last Name")
            
        }else if eTF.text == "" {
            self.showPopup(title: "Alert", message: "Please enter Email")
        }
    }
}
