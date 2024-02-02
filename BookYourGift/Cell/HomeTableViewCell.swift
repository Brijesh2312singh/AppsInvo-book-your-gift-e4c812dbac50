//
//  HomeTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 27/07/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
protocol delodDelegate: class {
    func reload(_ result: Bool)
}
class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var catCallection: UICollectionView!
    @IBOutlet weak var catCallectionHeight: NSLayoutConstraint!
    var SellerImagearr = ["1 3","2","3","4"]
    var  sellerlblArr = ["Ganesha Quirky Wall Hanging","Ganesha Quirky Wall Hanging","Ganesha Quirky Wall Hanging","Ganesha Quirky Wall Hanging"]
    
    var BeerImagearr = ["21","22","23","24"]
    var  BeerlblArr = ["Beer Mug","Beer Mug","Beer Mug","Beer Mug"]
    
    
    var delegate: delodDelegate?
    var getNavigationController = UINavigationController()
    var viewControllerr = UIViewController()
    var productsModel: [ProductsModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        self.catCallection.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    func setCollectionViewDataSourceDelegate(forArray pList: [ProductsModel], navigationCLR : UINavigationController, viewCR: UIViewController) {
        //        self.catCallection.register(UINib(nibName: "BestsellerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BestsellerCollectionViewCell")
        let nib = UINib(nibName: "SellerCollectionViewCell", bundle: nil)
        catCallection.register(nib, forCellWithReuseIdentifier: "SellerCollectionViewCell")
        //        self.catCallection.register(UINib(nibName: "BestSellerBeerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BestSellerBeerCollectionViewCell")
        //        self.catCallection.register(UINib(nibName: "RecentlyViewedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentlyViewedCollectionViewCell")
        self.catCallection.delegate = self
        self.catCallection.dataSource = self
        self.productsModel.removeAll()
        self.productsModel = pList
        self.getNavigationController = navigationCLR
        self.viewControllerr = viewCR
        self.catCallection.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UICollectionView {
            if obj == self.catCallection && keyPath == "contentSize" {
                self.catCallectionHeight.constant = self.catCallection.contentSize.height
                delegate?.reload(true)
            }
        }
    }
    
    @objc func likeAction(sender: UIButton) {
        let index = sender.tag
        self.wishlistAPI(productId:"\(productsModel[index].id ?? 0)")
        let wishlist = self.getNavigationController.storyboard?.instantiateViewController(withIdentifier: "WishlistVC")as! WishlistVC
        self.getNavigationController.pushViewController(wishlist, animated: true)
    }
    @objc func addButtonAction(sender: UIButton) {
        let index = sender.tag
        self.addtocartAPI(productId:"\(productsModel[index].id ?? 0)")
        let addtocart = self.getNavigationController.storyboard?.instantiateViewController(withIdentifier: "MyCartVC")as! MyCartVC
        self.getNavigationController.pushViewController(addtocart, animated: true)
    }
}
extension HomeTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.productsModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = catCallection.dequeueReusableCell(withReuseIdentifier: "BestsellerCollectionViewCell", for: indexPath)as! BestsellerCollectionViewCell
        let cell = catCallection.dequeueReusableCell(withReuseIdentifier: "SellerCollectionViewCell", for: indexPath) as! SellerCollectionViewCell
        
        let product = productsModel[indexPath.item]
        cell.wallhangingLbl.text = product.name
        cell.sellerImageView.image = nil
        cell.sellerImageView.sd_setImage(with: URL(string: productsModel[indexPath.item].webimage[0].images ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(self.likeAction(sender:)), for: .touchUpInside)
        cell.sellerBtn.tag = indexPath.row
        cell.sellerBtn.addTarget(self, action: #selector(self.addButtonAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (catCallection.bounds.width/2)-5
        return CGSize(width: size, height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductsDetailsVC") as? ProductsDetailsVC
                self.getNavigationController.pushViewController(vc!, animated: true)
           
    }
}
extension HomeTableViewCell {
    
    func wishlistAPI(productId: String)
    {
        let params = ["product": productId]as [String: Any]
        print("params:=== \(params)")
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/productWishlist", method: .post,parameters:params, encoding: JSONEncoding.default, headers: [
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
                } else {
                    print("Error occurred")
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
    func addtocartAPI(productId: String)
    {
        let params = ["product": productId,"quantity":"1"]as [String: Any]
        print("params:=== \(params)")
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/cart/add", method: .post,parameters:params, encoding: JSONEncoding.default, headers: [
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
                } else {
                    print("Error occurred")
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
}
