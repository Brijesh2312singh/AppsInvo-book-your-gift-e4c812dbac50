//
//  CategeriseVC.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class CategeriseVC: UIViewController {
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var categeriView: UIView!
    @IBOutlet weak var categeriseCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    //    var photos: [Photo] = []
    var imagearr = ["Group 520","Group 521","Group 522","Group 524","Group 525","Group 530","Group 533","Group 63104","Group 63717","Group 63724",]
    var labelArr = ["Quiry wall hanging","6layer wall Hanging","3 layer Hanging Wall"," Key Holders","Coasters set","Fridge magnet","Decor Huts","Decor Combo","Beer Glass","Wooden plates",]
    var categoryModel: [CategoryModel] = []
    var users: [AnyObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        categeriseCollectionView.register(UINib(nibName: "CategeriseCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CategeriseCollectionViewCell")
        searchView.layer.borderWidth = 1.0
        searchView.layer.cornerRadius = 10
        searchView.layer.borderColor = UIColor.red.cgColor
        categeriseCollectionView.delegate = self
        categeriseCollectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categeriseAPI()
    }
    @IBAction func HeartTappedBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WishlistVC") as! WishlistVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func notificationButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension CategeriseVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categeriseCollectionView.dequeueReusableCell(withReuseIdentifier: "CategeriseCollectionViewCell", for: indexPath) as! CategeriseCollectionViewCell
        cell.categeriseLbl!.text! = categoryModel[indexPath.item].name ?? ""
        print(categoryModel[indexPath.item].image as Any)
        let image_url = (categoryModel[indexPath.item].image ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        cell.categeriseImageview.sd_setImage(with: URL(string: image_url ?? ""),placeholderImage: UIImage(named: "9055549_bxs_file_image_icon"), options: SDWebImageOptions(rawValue: 0))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (categeriseCollectionView.frame.size.width/2) - 10
        return CGSize(width: size, height: size)
    }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                }
}

extension CategeriseVC {
    
    func categeriseAPI()
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
                            self.categeriseCollectionView.reloadData()
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

