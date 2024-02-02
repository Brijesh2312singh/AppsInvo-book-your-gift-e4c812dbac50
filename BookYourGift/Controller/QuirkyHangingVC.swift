//
//  QuirkyHangingVC.swift
//  BookYourGift
//
//  Created by Apple on 03/08/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class QuirkyHangingVC: UIViewController {

    @IBOutlet weak var quirkyView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var quirkyCollectionView: UICollectionView!
    
    @IBOutlet weak var searchview: UIView!
    var imageArr = ["Group 520","Group 521","Group 522","Group 523","Group 524","Group 525"]
    
    var lableArr = ["Quirky Wall Hanging","6Layer Hanging","3Layer Hanging","Key Holders","Key Holders","Key Holders"]
    
    var categoryModel: [CategoryModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.register(UINib(nibName: "SellerCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SellerCollectionViewCell")
        
        quirkyCollectionView.delegate = self
        quirkyCollectionView.dataSource = self
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        searchview.layer.borderWidth = 1.0
        searchview.layer.borderColor = UIColor.red.cgColor
        searchview.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quirkyhangingAPI()
    
    }
    
    @IBAction func likeTappedBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WishlistVC") as! WishlistVC
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    @IBAction func notificationTappedBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    

}
extension QuirkyHangingVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.quirkyCollectionView {
            return self.categoryModel.count
        }  else if collectionView == self.myCollectionView {
            return 4
            
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.quirkyCollectionView {
            let cell1 = quirkyCollectionView.dequeueReusableCell(withReuseIdentifier: "QuirkyHangingCollectionViewCell", for: indexPath) as! QuirkyHangingCollectionViewCell
            cell1.quirkyLbl!.text! = categoryModel[indexPath.item].name ?? ""
            print(categoryModel[indexPath.item].image as Any)
            let image_url = (categoryModel[indexPath.item].image ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            cell1.quirkyImageView.sd_setImage(with: URL(string: image_url ?? ""),placeholderImage: UIImage(named: "9055549_bxs_file_image_icon"), options: SDWebImageOptions(rawValue: 0))
            return cell1
            
        }else if collectionView == self.myCollectionView {
            let cell2 = myCollectionView.dequeueReusableCell(withReuseIdentifier: "SellerCollectionViewCell", for: indexPath) as! SellerCollectionViewCell
            cell2.sellerView.layer.cornerRadius = 10
            
            
            return cell2
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = (myCollectionView.frame.size.width/2) - 10
            return CGSize(width: size, height:350)
        }
}
extension QuirkyHangingVC {
    
    func quirkyhangingAPI()
        {

                AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/category?page&limit&search", method: .get, encoding: JSONEncoding.default, headers: [
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")"
                ]).responseJSON { response in
//                    print(response)
                    switch response.result {
                        
                    case .success(let json):
                        let jsonResponse = JSON(json)
                        let statusCode = jsonResponse["response_code"].intValue
                        if statusCode == 200 {
                            let jsonResponse = json as? NSDictionary ?? [:]
                            print(jsonResponse)
                            let message = jsonResponse.value(forKey: "message") as? String ?? ""
                            let data = jsonResponse.value(forKey: "data") as? NSDictionary ?? [:]
                            let categories = data.value(forKey: "categories") as? NSArray ?? []
                            self.categoryModel.removeAll()
                            for cat in categories {
                                let tempModel = CategoryModel()
                                tempModel.id = (cat as AnyObject).value(forKey: "id") as? Int ?? 0
                                tempModel.name = (cat as AnyObject).value(forKey: "name") as? String ?? ""
                                tempModel.image = (cat as AnyObject).value(forKey: "image") as? String ?? ""
                                tempModel.description_ = (cat as AnyObject).value(forKey: "description") as? String ?? ""
                                tempModel.rank = (cat as AnyObject).value(forKey: "rank") as? Int ?? 0
                                tempModel.active = (cat as AnyObject).value(forKey: "active") as? Int ?? 0
                                tempModel.sub_category_count = (cat as AnyObject).value(forKey: "active") as? Int ?? 0
                                
                                let subcategory = (cat as AnyObject).value(forKey: "subcategory") as? NSArray ?? []
                                var subCategoryModel: [SubCategoryModel] = []
                                
                                for subCat in subcategory {
                                    let tempSubModel = SubCategoryModel()
                                    tempSubModel.id = (subCat as AnyObject).value(forKey: "id") as? Int ?? 0
                                    tempSubModel.name = (subCat as AnyObject).value(forKey: "name") as? String ?? ""
                                    tempSubModel.image = (subCat as AnyObject).value(forKey: "image") as? String ?? ""
                                    tempSubModel.rank = (subCat as AnyObject).value(forKey: "rank") as? Int ?? 0
                                    tempSubModel.active = (subCat as AnyObject).value(forKey: "active") as? Int ?? 0
                                    subCategoryModel.append(tempSubModel)
                                }
                                
                                tempModel.subcategory = subCategoryModel
                                var categoryPaymentMethodModel: [CategoryPaymentMethodModel] = []
                                let category_payment_method = (cat as AnyObject).value(forKey: "category_payment_method") as? NSArray ?? []
                                
                                self.categoryModel.append(tempModel)
                            }
                            print(self.categoryModel.count)
                            self.quirkyCollectionView.reloadData()
                        }
                        
                        else {
                            print("error occuring")
                        }
                        
                    case .failure(_):
                        print("error")
                    }
                }
                
//            }
        }
}


