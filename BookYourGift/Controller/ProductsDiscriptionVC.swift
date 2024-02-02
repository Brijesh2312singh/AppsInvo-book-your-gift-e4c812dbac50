//
//  ProductsDiscriptionVC.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductsDiscriptionVC: UIViewController {

    @IBOutlet weak var mycollectionView: UICollectionView!
    
  
    var productsModel: [recommendedModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        mycollectionView.delegate = self
        mycollectionView.dataSource = self
        
        mycollectionView.register(UINib(nibName: "SellerCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SellerCollectionViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProductsDiscriptionAPI()
    }
 
    @IBAction func viewallBtn(_ sender: UIButton) {
    }
}
extension ProductsDiscriptionVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.mycollectionView {
            let cell1 = mycollectionView.dequeueReusableCell(withReuseIdentifier: "SellerCollectionViewCell", for: indexPath) as! SellerCollectionViewCell
            cell1.sellerView.layer.cornerRadius = 10
            
            let product = productsModel[indexPath.item]
            cell1.wallhangingLbl.text = product.name
            cell1.sellerImageView.image = nil
            cell1.sellerImageView.sd_setImage(with: URL(string: productsModel[indexPath.item].recommendedimages[0].images ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            return cell1
       
            
        }
        return UICollectionViewCell()
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let size = (mycollectionView.frame.size.width/2) - 10
                return CGSize(width: size, height:350)
            }
         
        
        }
    
extension ProductsDiscriptionVC {

            func ProductsDiscriptionAPI()
                {

                        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/productDetail?device_id=32772632&id=395", method: .get, encoding: JSONEncoding.default, headers: [
                            "Content-Type": "application/json",
                            "Accept": "application/json",
                            "Device_id": "30a62878-9a42-41d0-bad1c1dc4b3ae589",
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
                                    let product = data.value(forKey: "product")as? NSDictionary ?? [:]
                                    for proddata in product {
                                        var tempModel = recommendedModel()
                                        tempModel.id = (proddata as AnyObject).value(forKey: "id") as? Int ?? 0
//                                        tempModel.bog_product_id = (prod as AnyObject).value(forKey: "bog_product_id") as? String ?? ""
//                                        tempModel.name = (prod as AnyObject).value(forKey: "name") as? String ?? ""
//                                        tempModel.price = (prod as AnyObject).value(forKey: "price") as? Int ?? 0
//                                        tempModel.unit = (prod as AnyObject).value(forKey: "unit") as? Int ?? 0
//                                        tempModel.type = (prod as AnyObject).value(forKey: "type") as? String ?? ""
//                                        tempModel.discount = (prod as AnyObject).value(forKey: "discount") as? Int ?? 0
//                                        tempModel.description_ = (prod as AnyObject).value(forKey: "description") as? String ?? ""
//                                        tempModel.features = (prod as AnyObject).value(forKey: "features") as? String ?? ""
//                                        tempModel.rank = (prod as AnyObject).value(forKey: "rank") as? Int ?? 0
//                                        tempModel.total_views = (prod as AnyObject).value(forKey: "total_views") as? Int ?? 0
//                                        tempModel.total_purchase = (prod as AnyObject).value(forKey: "total_purchase") as? Int ?? 0
//                                        tempModel.active = (prod as AnyObject).value(forKey: "active") as? Int ?? 0
//                                        tempModel.to_be_showed = (prod as AnyObject).value(forKey: "to_be_showed") as? Int ?? 0
//                                        tempModel.to_be_showed_at = (prod as AnyObject).value(forKey: "to_be_showed_at") as? Int ?? 0
//                                        tempModel.created_at = (prod as AnyObject).value(forKey: "created_at") as? Int ?? 0
//                                        tempModel.updated_at = (prod as AnyObject).value(forKey: "updated_at") as? Int ?? 0
//                                        tempModel.addedToCart = (prod as AnyObject).value(forKey: "addedToCart") as? Int ?? 0
//                                        tempModel.addedToWishlist = (prod as AnyObject).value(forKey: "addedToWishlist") as? Int ?? 0
                                        let recommended_items = (proddata as AnyObject).value(forKey: "recommended_items") as? NSDictionary ?? [:]
                                        tempModel.id = recommended_items.value(forKey: "id") as? Int ?? 0
                                        tempModel.sku_id = recommended_items.value(forKey: "sku_id") as? String ?? ""
                                        tempModel.bog_product_id = recommended_items.value(forKey: "bog_product_id") as? String ?? ""
                                        tempModel.name = recommended_items.value(forKey: "name") as? String ?? ""
                                        tempModel.price = recommended_items.value(forKey: "price") as? Int ?? 0
                                        tempModel.unit = recommended_items.value(forKey: "unit") as? Int ?? 0
                                        tempModel.type = recommended_items.value(forKey: "type") as? String ?? ""
                                        tempModel.discount = recommended_items.value(forKey: "discount") as? Int ?? 0
                                        tempModel.description_ = recommended_items.value(forKey: "description") as? String ?? ""
                                        tempModel.features = recommended_items.value(forKey: "features") as? String ?? ""
                                        tempModel.rank = recommended_items.value(forKey: "rank") as? Int ?? 0
                                        tempModel.total_views = recommended_items.value(forKey: "total_views") as? Int ?? 0
                                        tempModel.total_purchase = recommended_items.value(forKey: "total_purchase") as? Int ?? 0
                                        tempModel.active = recommended_items.value(forKey: "active") as? Int ?? 0
                                        tempModel.to_be_showed = recommended_items.value(forKey: "to_be_showed") as? Int ?? 0
                                        tempModel.to_be_showed_at = recommended_items.value(forKey: "to_be_showed_at") as? Int ?? 0
                                        tempModel.created_at = recommended_items.value(forKey: "created_at") as? Int ?? 0
                                        tempModel.updated_at = recommended_items.value(forKey: "updated_at") as? Int ?? 0
                                        tempModel.addedToCart = recommended_items.value(forKey: "addedToCart") as? Int ?? 0
                                        tempModel.addedToWishlist = recommended_items.value(forKey: "addedToWishlist") as? Int ?? 0
                                        tempModel.discountedPrice = recommended_items.value(forKey: "discountedPrice") as? Int ?? 0
                                            let images = recommended_items.value(forKey: "images") as? NSArray ?? []
                                            var imageProductModel_: [recommendedimagesModel] = []
                                            for img in images {
                                                let subBannerModel = recommendedimagesModel()
                                                subBannerModel.id = (img as AnyObject).value(forKey: "id") as? Int ?? 0
                                                subBannerModel.images = ((img as AnyObject).value(forKey: "name") as? String ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                               
                                                    imageProductModel_.append(subBannerModel)
                                                }
                                          
                                        tempModel.recommendedimages = imageProductModel_
                                        self.productsModel.append(tempModel)
                                        self.mycollectionView.reloadData()
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
