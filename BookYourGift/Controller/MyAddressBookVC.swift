//
//  MyAddressBookVC.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit
import AVFoundation
import PhotosUI
import DropDown
import Alamofire
import SwiftyJSON



class MyAddressBookVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var totalOrders: UITextField!
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var alternateTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var stack3: UIStackView!
    @IBOutlet weak var stack4: UIStackView!
    @IBOutlet weak var stack5: UIStackView!
    @IBOutlet weak var stack6: UIStackView!
    @IBOutlet weak var stack7: UIStackView!
    @IBOutlet weak var stack8: UIStackView!
    
    @IBOutlet weak var View1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var view11: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view10: UIView!
    
    @IBOutlet weak var view9: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view5: UIView!
    
  
    var ImageFront = false
    
    var imagePicker = UIImagePickerController()
    let captureSession = AVCaptureSession()
    var isSelectCheck:Bool = false
  
    var imageBack = false
    var dropDown = DropDown()
  
    var addressArr = [["address": "RC 278 Khora Noida Sector 62A, Ghaziabad, Uttar Pradesh.201309"]]
    var addressList = [[String: Any]]()
    var selectedIndex: Int?
//    var userModels: [userModel] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.isHidden = true
        self.addressTableView.register(UINib(nibName: "MyAddressBookTableViewCell", bundle: nil), forCellReuseIdentifier: "MyAddressBookTableViewCell")
        addressView.isHidden = true
        addressTableView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        addressTableView.delegate = self
        addressTableView.dataSource = self
        cameraImageView.layer.cornerRadius = cameraImageView.frame.size.height/2
        addressBtn.layer.borderWidth = 1.0
        addressBtn.layer.borderColor = UIColor.red.cgColor
        addressBtn.layer.cornerRadius = 8
        View1.layer.borderWidth = 1.0
        View1.layer.borderColor = UIColor.gray.cgColor
        View1.layer.cornerRadius = 10
        view2.layer.borderWidth = 1.0
        view2.layer.borderColor = UIColor.gray.cgColor
        view2.layer.cornerRadius = 10
        view3.layer.borderWidth = 1.0
        view3.layer.borderColor = UIColor.gray.cgColor
        view3.layer.cornerRadius = 10
        view4.layer.borderWidth = 1.0
        view4.layer.borderColor = UIColor.gray.cgColor
        view4.layer.cornerRadius = 10
        view5.layer.borderWidth = 1.0
        view5.layer.borderColor = UIColor.gray.cgColor
        view5.layer.cornerRadius = 10
        view6.layer.borderWidth = 1.0
        view6.layer.borderColor = UIColor.gray.cgColor
        view6.layer.cornerRadius = 10
        view7.layer.borderWidth = 1.0
        view7.layer.borderColor = UIColor.gray.cgColor
        view7.layer.cornerRadius = 10
        view8.layer.borderWidth = 1.0
        view8.layer.borderColor = UIColor.gray.cgColor
        view8.layer.cornerRadius = 10
        view9.layer.borderWidth = 1.0
        view9.layer.borderColor = UIColor.gray.cgColor
        view9.layer.cornerRadius = 10
        view10.layer.borderWidth = 1.0
        view10.layer.borderColor = UIColor.gray.cgColor
        view10.layer.cornerRadius = 10
        view11.layer.borderWidth = 1.0
        view11.layer.borderColor = UIColor.gray.cgColor
        view11.layer.cornerRadius = 10
        continueBtn.layer.cornerRadius = 10
       
        
        profileAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileAPI()
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UITableView {
            if obj == addressTableView {
                addressTableView.layer.removeAllAnimations()
                tableViewHeight.constant = addressTableView.contentSize.height
                UIView.animate(withDuration: 0.5) {
                    self.updateViewConstraints()
                }
            }
        }
    }
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true, completion: nil)

           if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               cameraImageView.image = selectedImage
           }
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }

  
    @IBAction func countrytappedBtn(_ sender: UIButton) {
        dropDown.dataSource = ["India"]
        dropDown.topOffset = CGPoint(x:0, y: view.frame.size.height)
        dropDown.show()
        dropDown.textColor = .black
        
        dropDown.cornerRadius = 10
        
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = .white
        
        dropDown.cellHeight = 40
        
        dropDown.cornerRadius = 10
        
        
        countryTF.isUserInteractionEnabled = false
        dropDown.anchorView = countryTF
        
        
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.countryTF.text = item
        }
    }
    @IBAction func stateTappedBtn(_ sender: UIButton) {
        dropDown.dataSource = ["Andhra Pradesh","Arunachal Pradesh","Assam","Andhra Pradesh","Bihar","Chhattisgarh","Goa","Gujarat","Haryana","Andhra Pradesh","Himachal Pradesh","Uttar Pradesh","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","ARajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttarakhand","West Bengal"]
        dropDown.topOffset = CGPoint(x:0, y: view.frame.size.height)
        dropDown.show()
        dropDown.textColor = .black
        
        dropDown.cornerRadius = 10
        
        dropDown.backgroundColor = UIColor.white
        dropDown.separatorColor = .white
        
        dropDown.cellHeight = 40
        
        dropDown.cornerRadius = 10
        
        
        stateTF.isUserInteractionEnabled = false
        dropDown.anchorView = stateTF
        
        
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            self?.stateTF.text = item
        }
    }
    
    @IBAction func continueTappedBtn(_ sender: UIButton) {
        
        profileAPI()
    }
    @IBAction func myaddressBooktapped(_ sender: UIButton) {
        
        if sender.isSelected == false {
            sender.isSelected = true
            sender.setImage(UIImage.init(named: "icons8-arrow-32"), for: UIControl.State.normal)
            addressList = addressArr
            self.addressView.isHidden = false
            UIView.animate(withDuration: 0.5) {
                
                sender.transform = sender.transform.rotated(by: sender.isSelected ? .pi/2 : -.pi/2)
            }
        }
        else {
            sender.isSelected = false
            addressList.removeAll()
            self.addressView.isHidden = true
            UIView.animate(withDuration: 0.5) {
                
                sender.transform = sender.transform.rotated(by: sender.isSelected ? .pi/2 : -.pi/2)
            }
        }
        addressTableView.reloadData()
    }
    
    @IBAction func myOrderTappedBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyOrderVC") as! MyOrderVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func myprofileTapped(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            sender.setImage(UIImage.init(named: "icons8-arrow-32"), for: UIControl.State.normal)
//            self.hideShowProfileSection(isHidden: false)
            UIView.animate(withDuration: 0.5) {
                self.profileView.isHidden = false
//                self.hideShowProfileSection(isHidden: false)
                sender.transform = sender.transform.rotated(by: sender.isSelected ? .pi/2 : -.pi/2)
            }
        }
        else {
            sender.isSelected = false
//            self.hideShowProfileSection(isHidden: true)
            UIView.animate(withDuration: 0.5) {
//                self.hideShowProfileSection(isHidden: true)
                self.profileView.isHidden = true
                sender.transform = sender.transform.rotated(by: sender.isSelected ? .pi/2 : -.pi/2)
            }
        }
    }
    
    @IBAction func liketappedBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WishlistVC") as! WishlistVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func notificationtappedBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func addNewAddressButtonAction(_ sender: UIButton) {
        addressArr.append(["address": "RC 278 Khora Noida Sector 62A, Ghaziabad, Uttar Pradesh.201309"])
        addressList = addressArr
        addressTableView.reloadData()
    }
    @IBAction func logoutTappedBtn(_ sender: UIButton) {
        if let vc = self.navigationController?.viewControllers.last(where: { $0.isKind(of: LoginVC.self) }) {
            self.navigationController?.popToViewController(vc, animated: true)
        }
        else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
    }
    @IBAction func cameraTapped(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}
extension MyAddressBookVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addressTableView {
                   return 1
        }
        else{
            return  0
        }
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        addressTableView.reloadData()
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addressTableView,
           let cell = addressTableView.dequeueReusableCell(withIdentifier: "MyAddressBookTableViewCell", for: indexPath) as? MyAddressBookTableViewCell {
            let isSelected = indexPath.row == selectedIndex
            let title = addressArr[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension MyAddressBookVC {
    func hideShowProfileSection(isHidden: Bool) {
        if isHidden {
            stack1.isHidden = true
            stack2.isHidden = true
            stack3.isHidden = true
            stack4.isHidden = true
            stack5.isHidden = true
            stack6.isHidden = true
            stack7.isHidden = true
            stack8.isHidden = true
        }
        else {
            stack1.isHidden = false
            stack2.isHidden = false
            stack3.isHidden = false
            stack4.isHidden = false
            stack5.isHidden = false
            stack6.isHidden = false
            stack7.isHidden = false
            stack8.isHidden = false
        }
    }
}
extension MyAddressBookVC {
    func profileAPI()
    {
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/getProfile", method: .get, encoding: JSONEncoding.default, headers: [
            "Accept": "application/json",
            "Device_id": "30a62878-9a42-41d0-bad1c1dc4b3ae589",
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"
        ]).responseJSON { response in
            print(response)
            switch response.result {
            case .success(let json):
                let jsonResponse = JSON(json)
                
                let statusCode = jsonResponse["response_code"].intValue
                if statusCode == 200 {
                    let jsonResponse = json as? NSDictionary ?? [:]
                    print(jsonResponse)
                    let message = jsonResponse.value(forKey: "message") as? String ?? ""
                    let data = jsonResponse.value(forKey: "data") as? NSDictionary ?? [:]
                    let use = data.value(forKey: "user") as? NSDictionary ?? [:]
                    let id = use.value(forKey: "id") as? String ?? ""
                    let bog_id = use.value(forKey: "bog_id") as? String ?? ""
                    let user_type = use.value(forKey: "user_type") as? Int ?? 0
                    let can_share = use.value(forKey: "can_share") as? Int ?? 0
                    let first_name = use.value(forKey: "first_name") as? String ?? ""
                    let last_name = use.value(forKey: "last_name") as? String ?? ""
                    let email = use.value(forKey: "email") as? String ?? ""
                    let email_verified_at = use.value(forKey: "email_verified_at") as? Int ?? 0
                    let country_code = use.value(forKey: "country_code")  as? Int ?? 0
                    let mobile_number = use.value(forKey: "mobile_number")  as? Int ?? 0
                    let image = use.value(forKey: "image") as? String ?? ""
                    let active = use.value(forKey: "active") as? Int ?? 0
                    let verify_otp = use.value(forKey: "verify_otp") as? Int ?? 0
                    let created_at = use.value(forKey: "created_at") as? Int ?? 0
                    let updated_at = use.value(forKey: "updated_at")as? String ?? ""
                    let total_order = use.value(forKey: "total_order") as? Int ?? 0
                    let add = use.value(forKey: "address") as? NSDictionary ?? [:]
                    
                    let address_id = add.value(forKey: "id")  as? Int ?? 0
                    let address = add.value(forKey: "address") as? String ?? ""
                    let city = add.value(forKey: "city")as? String ?? ""
                    let zipcode = add.value(forKey: "zipcode")as? Int ?? 0
                    let country = add.value(forKey: "country") as? String ?? ""
                    let state_id = add.value(forKey: "state_id") as? String ?? ""
                    let resident_type = add.value(forKey: "raddressesident_type")as? String ?? ""
                    let state = add.value(forKey: "state") as? String ?? ""
                   
                    
                } else {
                    }
                case .failure(_):
                    print("error")
                }
            }
    }
}
