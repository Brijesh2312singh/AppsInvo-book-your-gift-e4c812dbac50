//
//  WishlistVC.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
//import StatusProvider


class WishlistVC: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var wishlistCollectionView: UICollectionView!
    var imagArr = ["wall","ganesh","wall","ganesh"]
    var sproduct: Product! = nil
    var wishlistModel: [mywishlistModel] = []
    var users: [AnyObject] = []
    var getNavigationController = UINavigationController()
    var viewControllerr = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        wishlistCollectionView.register(UINib(nibName: "SellerCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SellerCollectionViewCell")
        wishlistCollectionView.delegate = self
        wishlistCollectionView.dataSource = self
        searchView.layer.borderWidth = 1.0
        searchView.layer.borderColor = UIColor.red.cgColor
        searchView.layer.cornerRadius = 10
//        title = "Empty"
//        let status = Status(title: "no Data Found"){
//            self.hideStatus()
//        }
//        show(status: status)
//    }
//    class EmptyStatusTestView: UIView {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wishlistAPI()
        
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func likeAction(sender: UIButton) {
        let index = sender.tag
        
    }
}
extension WishlistVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishlistModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.wishlistCollectionView {
            let cell1 = wishlistCollectionView.dequeueReusableCell(withReuseIdentifier: "SellerCollectionViewCell", for: indexPath) as! SellerCollectionViewCell
            let product = wishlistModel[indexPath.item]
            cell1.wallhangingLbl.text = product.name
            cell1.sellerImageView.image = nil
            cell1.sellerImageView.sd_setImage(with: URL(string: wishlistModel[indexPath.item].wishlistimages[0].images ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
           
            cell1.likeBtn.tag = indexPath.row
            cell1.likeBtn.addTarget(self, action: #selector(self.likeAction(sender:)), for: .touchUpInside)
            
//            if indexPath.item == 0 {
//                cell1.discountLbl.isHidden = true
//                cell1.discountLbl.isHidden = true
//            } else if indexPath.item == 3{
//                cell1.discountLbl.isHidden = true
//                cell1.discountLbl.isHidden = true
//            }
            return cell1
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuirkyHangingVC") as? QuirkyHangingVC
                self.getNavigationController.pushViewController(vc!, animated: true)
                
            }
        }
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let size = (wishlistCollectionView.frame.size.width/2) - 5
                return CGSize(width: size, height: 350)
            }
        }


extension WishlistVC {
    func wishlistAPI()
    {
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/getWishlist", method: .get, encoding: JSONEncoding.default, headers: [
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
                    let wishlists = data.value(forKey: "wishlists") as? NSArray ?? []
                    for wishlistData in wishlists {
                        var tempModel = mywishlistModel()
                        tempModel.id = (wishlistData as AnyObject).value(forKey: "id") as? Int ?? 0
                        let product = (wishlistData as AnyObject).value(forKey: "product") as? NSDictionary ?? [:]
                        tempModel.p_id = product.value(forKey: "id") as? Int ?? 0
                        tempModel.sku_id = product.value(forKey: "sku_id") as? String ?? ""
                        tempModel.bog_product_id = product.value(forKey: "bog_product_id") as? String ?? ""
                        tempModel.name = product.value(forKey: "name") as? String ?? ""
                        tempModel.price = product.value(forKey: "price") as? Int ?? 0
                        tempModel.unit = product.value(forKey: "unit") as? Int ?? 0
                        tempModel.type = product.value(forKey: "type") as? String ?? ""
                        tempModel.discount = product.value(forKey: "discount") as? Int ?? 0
                        tempModel.description_ = product.value(forKey: "description") as? String ?? ""
                        tempModel.features = product.value(forKey: "features") as? String ?? ""
                        tempModel.rank = product.value(forKey: "rank") as? Int ?? 0
                        tempModel.total_views = product.value(forKey: "total_views") as? Int ?? 0
                        tempModel.total_purchase = product.value(forKey: "total_purchase") as? Int ?? 0
                        tempModel.active = product.value(forKey: "active") as? Int ?? 0
                        tempModel.to_be_showed = product.value(forKey: "to_be_showed") as? Int ?? 0
                        tempModel.to_be_showed_at = product.value(forKey: "to_be_showed_at") as? Int ?? 0
                        tempModel.created_at = product.value(forKey: "created_at") as? Int ?? 0
                        tempModel.updated_at = product.value(forKey: "updated_at") as? Int ?? 0
                        tempModel.addedToCart = product.value(forKey: "addedToCart") as? Int ?? 0
                        tempModel.discountedPrice = product.value(forKey: "discount_price") as? Int ?? 0
                        let images = product.value(forKey: "images") as? NSArray ?? []
                        var imageProductModel_: [wishlistimagesModel] = []
                        for img in images {
                            let subBannerModel = wishlistimagesModel()
                            subBannerModel.id = (img as AnyObject).value(forKey: "id") as? Int ?? 0
                            subBannerModel.images = ((img as AnyObject).value(forKey: "name") as? String ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            imageProductModel_.append(subBannerModel)
                        }
                        tempModel.wishlistimages = imageProductModel_
                        self.wishlistModel.append(tempModel)
                        self.wishlistCollectionView.reloadData()
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
