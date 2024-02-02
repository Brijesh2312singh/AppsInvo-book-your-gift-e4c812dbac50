//
//  OtpVC.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit
import Alamofire

class OtpVC: UIViewController {

    @IBOutlet weak var otpTF1: UITextField!
    @IBOutlet weak var otpTF2: UITextField!
    @IBOutlet weak var otpTF3: UITextField!
    @IBOutlet weak var otpTF4: UITextField!
    @IBOutlet weak var otpTF5: UITextField!
    @IBOutlet weak var otpTF6: UITextField!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View3: UIView!
    @IBOutlet weak var View4: UIView!
    @IBOutlet weak var View5: UIView!
    @IBOutlet weak var View6: UIView!
    
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    var modelVariable = ModelClass()
    
    var countryCode = ""
    var number = ""
    
    var otpTimer:Timer?
    var remainingTime = 34
    override func viewDidLoad() {
        super.viewDidLoad()
        initialTimerSetUp()
        otpTF1.keyboardType = .phonePad
        otpTF1.textAlignment = .center
        otpTF1.text = modelVariable.otp1Var
        otpTF1.delegate = self
        otpTF1.tag = 100
        View1.layer.cornerRadius = 12
        View2.layer.cornerRadius = 12
        View3.layer.cornerRadius = 12
        View4.layer.cornerRadius = 12
        View5.layer.cornerRadius = 12
        View6.layer.cornerRadius = 12
        
        otpTF2.keyboardType = .phonePad
        otpTF2.textAlignment = .center
        otpTF2.text = modelVariable.otp1Var
        otpTF2.delegate = self
        otpTF2.tag = 100
        
        otpTF3.keyboardType = .phonePad
        otpTF3.textAlignment = .center
        otpTF3.text = modelVariable.otp1Var
        otpTF3.delegate = self
        otpTF3.tag = 100
        
        otpTF4.keyboardType = .phonePad
        otpTF4.textAlignment = .center
        otpTF4.text = modelVariable.otp1Var
        otpTF4.delegate = self
        otpTF4.tag = 100
        
        otpTF5.keyboardType = .phonePad
        otpTF5.textAlignment = .center
        otpTF5.text = modelVariable.otp1Var
        otpTF5.delegate = self
        otpTF5.tag = 100
        
        otpTF6.keyboardType = .phonePad
        otpTF6.textAlignment = .center
        otpTF6.text = modelVariable.otp1Var
        otpTF6.delegate = self
        otpTF6.tag = 100
        
        verifyBtn.layer.cornerRadius = 10
        
        self.hideKeyboardWhenTappedAround()


       
    }
    func initialTimerSetUp() {
        self.timerLbl.text = String(format: "00:%@", remainingTime < 10 ? String(format: "0%d", remainingTime) : String(format: "%d", remainingTime))
        otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    @objc func runTimedCode() {
        remainingTime = remainingTime - 1
        self.timerLbl.text = String(format: "00:%@", remainingTime < 10 ? String(format: "0%d", remainingTime) : String(format: "%d", remainingTime))
        if remainingTime == 0 {// compare
            self.otpTimer?.invalidate()
            self.otpTimer = nil

            remainingTime = 34
        }
    }
    

    @IBAction func resendBtn(_ sender: UIButton) {
        otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    

    @IBAction func verifyTappedBtn(_ sender: UIButton) {
        otpAPI()
        
       
    }
}
extension OtpVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string.count == 1){
            if textField == otpTF1 {
                otpTF2?.becomeFirstResponder()
                View1.layer.borderWidth = 1.0
                View1.layer.borderColor = UIColor.red.cgColor
            }
            if textField == otpTF2 {
                otpTF3?.becomeFirstResponder()
                View2.layer.borderWidth = 1.0
                View2.layer.borderColor = UIColor.red.cgColor
            }
            if textField == otpTF3 {
                otpTF4?.becomeFirstResponder()
                View3.layer.borderWidth = 1.0
                View3.layer.borderColor = UIColor.red.cgColor
            }
            if textField == otpTF4 {
                otpTF5?.becomeFirstResponder()
                View4.layer.borderWidth = 1.0
                View4.layer.borderColor = UIColor.red.cgColor
            }
            if textField == otpTF5 {
                otpTF6?.becomeFirstResponder()
                View5.layer.borderWidth = 1.0
                View5.layer.borderColor = UIColor.red.cgColor
            }
            if textField == otpTF6 {
                otpTF6?.becomeFirstResponder()
                View6.layer.borderWidth = 1.0
                View6.layer.borderColor = UIColor.red.cgColor
            }
            textField.text? = string
            return false
        }else
        {
            if textField == otpTF1 {
                otpTF1?.becomeFirstResponder()
                View1.layer.borderColor = UIColor.clear.cgColor
            }
            if textField == otpTF2 {
                otpTF1.becomeFirstResponder()
                View2.layer.borderColor = UIColor.clear.cgColor
            }
            if textField == otpTF3 {
                otpTF2?.becomeFirstResponder()
                View3.layer.borderColor = UIColor.clear.cgColor
            }
            if textField == otpTF4 {
                otpTF3?.becomeFirstResponder()
                View4.layer.borderColor = UIColor.clear.cgColor
            }
            if textField == otpTF5 {
                otpTF4?.becomeFirstResponder()
                View5.layer.borderColor = UIColor.clear.cgColor
            }
            if textField == otpTF6 {
                otpTF5?.becomeFirstResponder()
                View6.layer.borderColor = UIColor.clear.cgColor
            }
            textField.text? = string
            return false
        }
    }
}
extension OtpVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(OtpVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension OtpVC {
    func otpAPI()
    {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Device_id": "",
            "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDEwNTU3OTMwMTY5YWQ3MWQ1MmFmYmMiLCJpYXQiOjE2ODEyNzgwMzMsImV4cCI6MTY4Mzg3MDAzM30.fht31HqLVbUwKqrNGFIxAhsgQMA8CtfejNz3HoMrKLc"
        ]
        var params: [String: Any] = [:]
        let concatenatedOTP = "\(otpTF1.text!)\(otpTF2.text!)\(otpTF3.text!)\(otpTF4.text!)\(otpTF5.text!)\(otpTF6.text!)"
        params = ["country_code": self.countryCode,
                  "mobile_number": number,
                 "otp": concatenatedOTP,
                 "user_type":"2"]
           
//        let params = ["country_code": self.codeTF.text!,"mobile_number": self.loginTF.text!, "user_type": "2"]as [String: Any]
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/auth/verifyOtp", method: .post, parameters:params, encoding: JSONEncoding.default, headers:headers).responseJSON
        { (response) in
            switch response.result{
                
            case .success(let json):
                let jsonResponse = json as? NSDictionary ?? [:]
                print(jsonResponse)
                let code = jsonResponse.value(forKey: "response_code") as? Int ?? 0
                let message = jsonResponse.value(forKey: "message") as? String ?? ""
                if code == 200 {
                    let data = jsonResponse.value(forKey: "data") as? NSDictionary ?? [:]
                    let success = jsonResponse.value(forKey: "success") as? Int ?? 0
                    let token = data.value(forKey: "token") as? String ?? ""
                    UserDefaults.standard.setValue(token, forKey: "token")
                    if success == 1 {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else {
                        print(message)
                    }
                    
                 
                }
                else {
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

                          
