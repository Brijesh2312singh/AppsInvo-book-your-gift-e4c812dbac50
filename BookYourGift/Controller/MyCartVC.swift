//
//  MyCartVC.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class MyCartVC: UIViewController {
    
    @IBOutlet weak var onlinepaymentBtn: UIButton!
    
    @IBOutlet weak var totallbl: UILabel!
    @IBOutlet weak var offerlbl: UILabel!
    @IBOutlet weak var gstlbl: UILabel!
    @IBOutlet weak var subtotalLbl: UILabel!
    @IBOutlet weak var codLbl: UILabel!
    @IBOutlet weak var onlinepaymentLbl: UILabel!
    @IBOutlet weak var soniyawanBtn: UIButton!
    @IBOutlet weak var khoraBtn: UIButton!
    @IBOutlet weak var shippingBtn: UIButton!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet var subTotalView: [UIView]!
    @IBOutlet weak var offersView: UIView!
    var imageArr = ["v-1","wall"]
    var lablearr = ["Beautiful Krishna WoodenWall Hanging","Motivated Wooden Wall Hanging"]
    var addressArr = [["address": "RC 278 Khora Noida Sector 62A, Ghaziabad, Uttar Pradesh.201309","Address":"Sonivawan,Jamui. Dulhin bazar, patna. Bihar 801102 "]]
    var addressList = [[String: Any]]()
    var cartModel: [addcartModel] = []
    var selectedIndex: Int?
    var selectedRadioButton: UIButton? = nil
    var count = 0
    var item : [Item] = []
    var getNavigationController = UINavigationController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        onlinepaymentBtn.setImage(UIImage.init(named: "Veg-1"), for: .normal)
        onlinepaymentBtn.setImage(UIImage.init(named: "Veg"), for: .selected)
        soniyawanBtn.setImage(UIImage.init(named: "Veg-1"), for: .normal)
        soniyawanBtn.setImage(UIImage.init(named: "Veg"), for: .selected)
        
        
        
        khoraBtn.setImage(UIImage.init(named: "Veg-1"), for: .normal)
        khoraBtn.setImage(UIImage.init(named: "Veg"), for: .selected)
        shippingBtn.setImage(UIImage.init(named: "Veg-1"), for: .normal)
        shippingBtn.setImage(UIImage.init(named: "Veg"), for: .selected)
        hideView?.isHidden = true
        self.myCartTableView.register(UINib(nibName: "MyCartTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCartTableViewCell")
        myCartTableView.delegate = self
        myCartTableView.dataSource = self
        offersView.layer.cornerRadius = 10
        confirmBtn.layer.cornerRadius = 10
    
            }
            
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addtocartAPI()
       
    }
    @IBAction func myBtn(_ sender: UIButton) {
        if sender == khoraBtn{
            khoraBtn.isSelected = true
            soniyawanBtn.isSelected = false
        }else{
            khoraBtn.isSelected = false
            soniyawanBtn.isSelected = true
            
        }
    }
    @IBAction func hidetappedBtn(_ sender: UIButton) {
        hideView.isHidden = true
    }
    @IBAction func offersTappedBtn(_ sender: UIButton) {
        
    }
    @IBAction func radiotappedBtn(_ sender: UIButton) {
        if sender == onlinepaymentBtn{
            onlinepaymentBtn.isSelected = true
            shippingBtn.isSelected = false
        }else{
            onlinepaymentBtn.isSelected = false
            shippingBtn.isSelected = true
        }
    }

    @objc func deleteButtonClicked(_ sender: UIButton) {
            let rowToDelete = sender.tag
            imageArr.remove(at: rowToDelete)
            
        let indexPath = IndexPath(row: rowToDelete, section: 0)
        myCartTableView.deleteRows(at: [indexPath], with: .fade)
    }
    @IBAction func addNewBtn(_ sender: UIButton) {
       
    }
    @IBAction func liketappedBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WishlistVC") as! WishlistVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func notificationTappedBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func confirmtappedBtn(_ sender: UIButton) {
        if let infoViewController = storyboard?.instantiateViewController(identifier: "EnterPromoCodeVC") {
            infoViewController.modalPresentationStyle = .overCurrentContext
            infoViewController.modalTransitionStyle = .crossDissolve
            present(infoViewController, animated: true)
        }
      
    }
}
extension MyCartVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cartModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == myCartTableView,
           let cell = myCartTableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell") as? MyCartTableViewCell {
            cell.cartImageview.image = nil
            cell.cartImageview.sd_setImage(with: URL(string: cartModel[indexPath.item].addcartimages[0].images ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.cartView.layer.cornerRadius = 20
            cell.cartView.layer.borderWidth = 1.0
            cell.cartView.layer.borderColor = UIColor.gray.cgColor
            cell.myView.layer.cornerRadius = 10
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(_:)), for: .touchUpInside)
            cell.deleteButton.tag = indexPath.row
            cell.addBtn.addTarget(self, action: #selector(addButtonClicked(_:)), for: .touchUpInside)
            cell.addBtn.tag = indexPath.row
            
            return cell
        }
        
        return UITableViewCell()
    }
    @objc func addButtonClicked(_ sender: UIButton) {
        count = (count + 1)
            let indexPath = IndexPath(row: sender.tag, section: 0)
            let cell = myCartTableView.cellForRow(at: indexPath)
            
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            imageArr.remove(at: indexPath.row)
            myCartTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension MyCartVC {
    func addtocartAPI()
    {
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/cart/get?device_id=::1&cod=1", method: .get, encoding: JSONEncoding.default, headers: [
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
                    let carts = data.value(forKey: "carts") as? NSArray ?? []
                    for cart in carts {
                        var tempModels = addcartModel()
                        tempModels.id = (cart as AnyObject).value(forKey: "id") as? Int ?? 0
                        tempModels.product_id = (cart as AnyObject).value(forKey: "product_id") as? Int ?? 0
                        tempModels.quantity = (cart as AnyObject).value(forKey: "quantity") as? Int ?? 0
                       let product = (cart as AnyObject).value(forKey: "product") as? NSDictionary ?? [:]
                        tempModels.p_id = product.value(forKey: "id") as? Int ?? 0
                        tempModels.sku_id = product.value(forKey: "sku_id") as? String ?? ""
                        tempModels.bog_product_id = product.value(forKey: "bog_product_id") as? String ?? ""
                        tempModels.name = product.value(forKey: "name") as? String ?? ""
                        tempModels.price = product.value(forKey: "price") as? Int ?? 0
                        tempModels.unit = product.value(forKey: "unit") as? Int ?? 0
                        tempModels.type = product.value(forKey: "type") as? String ?? ""
                        tempModels.discount = product.value(forKey: "discount") as? Int ?? 0
                        tempModels.description_ = product.value(forKey: "description") as? String ?? ""
                        tempModels.features = product.value(forKey: "features") as? String ?? ""
                        tempModels.rank = product.value(forKey: "rank") as? Int ?? 0
                        tempModels.total_views = product.value(forKey: "total_views") as? Int ?? 0
                        tempModels.total_purchase = product.value(forKey: "total_purchase") as? Int ?? 0
                        tempModels.active = product.value(forKey: "active") as? Int ?? 0
                        tempModels.to_be_showed = product.value(forKey: "to_be_showed") as? Int ?? 0
                        tempModels.to_be_showed_at = product.value(forKey: "to_be_showed_at") as? Int ?? 0
                        tempModels.created_at = product.value(forKey: "created_at") as? Int ?? 0
                        tempModels.updated_at = product.value(forKey: "updated_at") as? Int ?? 0
                        tempModels.discount_price = product.value(forKey: "discount_price") as? Int ?? 0
                        
                        let images = product.value(forKey: "images") as? NSArray ?? []
                        var imageProductModel_: [addcartimagesModel] = []
                        for item in images {
                            let subBannerModel = addcartimagesModel()
                            let id = (item as AnyObject).value(forKey: "id") as? Int ?? 0
                            let name = (item as AnyObject).value(forKey: "name") as? String ?? "".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            imageProductModel_.append(subBannerModel)
                        }
                        tempModels.addcartimages = imageProductModel_
                        self.cartModel.append(tempModels)
                        self.myCartTableView.reloadData()
                        
                    }
                } else {
                    print("Error occurred")
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
}
