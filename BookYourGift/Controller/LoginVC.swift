//
//  LoginVC.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit
import CountryPickerView
import Alamofire
class LoginVC: UIViewController,CountryPickerViewDelegate, CountryPickerViewDataSource,UITextFieldDelegate {
   
    

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var loginView: UIView!
    let countryPickerView = CountryPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTF.text = "91"
        loginTF.text = "8076422754"

        
        loginTF.delegate = self
        loginTF.tag = 0
        loginTF.returnKeyType = .next
        
        loginTF.keyboardType = .phonePad
        
        loginView.layer.cornerRadius = 10
        loginBtn.layer.cornerRadius = 10
        
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        codeTF.attributedPlaceholder = NSAttributedString(
            string: "+91",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
        )
        self.hideKeyboardWhenTappedAround()
      
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = loginTF.superview?.viewWithTag(loginTF.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        return false
    }
            func performAction() {
            }
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.codeTF.text! =  (country.phoneCode)
        self.codeBtn.isHidden = true
    }
    @IBAction func loginTappedBtn(_ sender: UIButton) {
        if loginTF.text == "" {
            self.showPopup(title: "Alert", message: "Please enter Phone Number")
        }
        loginAPI()
    }
    @IBAction func countryCodetappedBtn(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
    }
}
extension LoginVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginVC {
    func loginAPI() {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDEwNTU3OTMwMTY5YWQ3MWQ1MmFmYmMiLCJpYXQiOjE2ODEyNzgwMzMsImV4cCI6MTY4Mzg3MDAzM30.fht31HqLVbUwKqrNGFIxAhsgQMA8CtfejNz3HoMrKLc"
        ]
        
        let params = ["country_code": self.codeTF.text!,"mobile_number": self.loginTF.text!, "user_type": "2"]as [String: Any]
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/auth/login", method: .post, parameters:params, encoding: JSONEncoding.default, headers:headers) .validate().responseJSON { (response) in
               
            switch response.result{
                
            case .success(let json):
                let jsonResponse = json as? NSDictionary ?? [:]
                print(jsonResponse)
                let code = jsonResponse.value(forKey: "response_code") as? Int ?? 0
                let message = jsonResponse.value(forKey: "message") as? String ?? ""
                if code == 200 {
                    let data = jsonResponse.value(forKey: "data") as? NSDictionary ?? [:]
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                    vc.countryCode = self.codeTF.text!
                    vc.number = self.loginTF.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                 
                }
                else {
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
