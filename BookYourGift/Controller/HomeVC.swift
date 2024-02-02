//
//  HomeVC.swift
//  BookYourGift
//
//  Created by Apple on 25/07/23.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SDWebImage

class HomeVC:UIViewController, delodDelegate {
    func reload(_ result: Bool) {
    }
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var catTable: UITableView!
    @IBOutlet weak var catTableHeght: NSLayoutConstraint!
    @IBOutlet weak var dealCollectionView: UICollectionView!
    @IBOutlet weak var notificationview: UIView!
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var newYearCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    var locationManager: CLLocationManager?
    var headingArray = ["Bestseller Quirky Wall hanging","Bestseller Beer Glass","Recently Viewed Products"]
    var NewYearImageArr = ["new-years-2023","new-years-2023","new-years-2023","new-years-2023"]
    var DealImageArr = ["c2","c1"]
    var imageArr = ["Group 520","Group 521","Group 522","Group 523","Group 524","Group 525","Group 527","Group 530","Group 531","Group 533","Group 63104","Group 63717",]
    var LblArr = ["Quirky Wall Hanging","6Layer Hanging", "3Layer Hanging","Key Holders","Coasters Set","Fridge Magnet","Decor Huts","Decor Combo","Beer Glass","Wooden plates","Share App","Contact Us"]
    var categoriesModel: [CategoriesModel] = []
    var getNavigationController = UINavigationController()
    var viewControllerr = UIViewController()
//    var coupons: [AnyObject] = []
    var coupons: [JSON] = []
    var currentPage = 0
    var begin = false
    var bannerModels: [BannerModel] = []
    var couponsModels: [CouponsModel] = []
    var categoryModel: [CategoryModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
            newYearCollectionView.dataSource = self
            self.myCollectionView.register(UINib(nibName: "Demo2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Demo2CollectionViewCell")
            myCollectionView.delegate = self
            myCollectionView.dataSource = self
            heartView.layer.cornerRadius = 10
            notificationview.layer.cornerRadius = 10
            pageController.currentPage = 0
            pageController.numberOfPages = NewYearImageArr.count
            newYearCollectionView.delegate = self
            newYearCollectionView.dataSource = self
            categoryView.layer.borderWidth = 1.0
            categoryView.layer.borderColor = UIColor.red.cgColor
            categoryView.layer.cornerRadius = 10
            categoryView.layer.shadowColor = UIColor.red.cgColor
            categoryView.layer.shadowOffset = .zero
            categoryView.layer.shadowOpacity = 0.3
            dealCollectionView.delegate = self
            dealCollectionView.dataSource = self
            shadowView.layer.cornerRadius = 10
            self.catTable.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
            self.catTable.delegate = self
            self.catTable.dataSource = self
            self.catTable.rowHeight = UITableView.automaticDimension
            self.catTable.separatorStyle = .none
            self.catTable.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        }

            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                homeAPI()
            
            }
            @IBAction func heartTappedBtn(_ sender: UIButton) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WishlistVC") as! WishlistVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
            @IBAction func notificationtappedBtn(_ sender: UIButton) {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
            override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
                if let obj = object as? UITableView {
                    if obj == self.catTable && keyPath == "contentSize" {
                        catTableHeght.constant = catTable.contentSize.height
                    }
                }
            }
            func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                pageController.currentPage = indexPath.row
            }
            func scrollToNextCell(){
                let cellSize = CGSizeMake(self.view.frame.width, self.view.frame.height);
                let contentOffset = newYearCollectionView.contentOffset;
                if begin == true
                {
                    pageController.currentPage = 0
                    newYearCollectionView.scrollRectToVisible(CGRectZero, animated: true)
                    begin = false
                }
                else
                {
                    newYearCollectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true);
                }
            }
        }
extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.newYearCollectionView {
            pageController.numberOfPages = bannerModels.count
            return self.bannerModels.count
        }  else if collectionView == self.dealCollectionView {
            return couponsModels.count
        } else if collectionView == self.myCollectionView {
            return self.categoryModel.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.newYearCollectionView {
            return CGSize(width: newYearCollectionView.bounds.width, height: newYearCollectionView.bounds.height)
        } else if collectionView == self.dealCollectionView {
            return CGSize(width:dealCollectionView.bounds.width, height: dealCollectionView.bounds.height)
        }  else if collectionView == self.myCollectionView {
            let size = (myCollectionView.frame.size.width/4) - 10
            return CGSize(width: size, height: 80)
        }
        return CGSize(width: 0 , height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.newYearCollectionView {
            let cell1 = newYearCollectionView.dequeueReusableCell(withReuseIdentifier: "NewYearCollectionViewCell", for: indexPath) as! NewYearCollectionViewCell
            print(bannerModels[indexPath.item].image as Any)
            let webImages = bannerModels[indexPath.item].image as? [[String: Any]]
            if bannerModels[indexPath.row].webimage.count != 0 {
                let url = (bannerModels[indexPath.row].webimage[0].image ?? "")
                cell1.newYearImageView.sd_setImage(with: URL(string: url ), placeholderImage: UIImage(named: "9055549_bxs_file_image_icon"), options: SDWebImageOptions(rawValue: 0))
            }
            
            return cell1
            
        }else if collectionView == self.dealCollectionView {
            let cell2 = dealCollectionView.dequeueReusableCell(withReuseIdentifier: "DealCollectionViewCell", for: indexPath) as! DealCollectionViewCell
            let product = couponsModels[indexPath.item]
            
            cell2.dealImageView.image = nil
            cell2.dealImageView.sd_setImage(with: URL(string: couponsModels[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            
            return cell2
            
        }
        else if collectionView == self.myCollectionView {
            let cell3 = myCollectionView.dequeueReusableCell(withReuseIdentifier: "Demo2CollectionViewCell", for: indexPath) as! Demo2CollectionViewCell
            cell3.demoLbl!.text! = categoryModel[indexPath.item].name ?? ""
            print(categoryModel[indexPath.item].image as Any)
            let image_url = (categoryModel[indexPath.item].image ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            cell3.demoImageview.sd_setImage(with: URL(string: image_url ?? ""),placeholderImage: UIImage(named: "9055549_bxs_file_image_icon"), options: SDWebImageOptions(rawValue: 0))
            return cell3
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.myCollectionView{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuirkyHangingVC") as? QuirkyHangingVC
            self.getNavigationController.pushViewController(vc!, animated: true)
            
        }
    }
}
    extension HomeVC: UITableViewDelegate,UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categoriesModel.count
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return catTable.rowHeight
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
            cell.headerLbl.text = categoriesModel[indexPath.row].name ?? ""
            cell.delegate = self
            cell.setCollectionViewDataSourceDelegate(forArray: categoriesModel[indexPath.row].product, navigationCLR: self.navigationController!, viewCR: self)
            return cell
        }
    }
extension HomeVC {
    func homeAPI()
    {
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/home", method: .get, encoding: JSONEncoding.default, headers: [
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
                    let bannerArray = data.value(forKey: "banner") as? NSArray ?? []
                    for bannerData in bannerArray {
                        var bannerModel = BannerModel()
                        bannerModel.id = (bannerData as AnyObject).value(forKey: "id") as? Int ?? 0
                        bannerModel.name = (bannerData as AnyObject).value(forKey: "name") as? String ?? ""
                        bannerModel.from_date = (bannerData as AnyObject).value(forKey: "from_date") as? Int ?? 0
                        bannerModel.to_date = (bannerData as AnyObject).value(forKey: "to_date") as? Int ?? 0
                        bannerModel.active = (bannerData as AnyObject).value(forKey: "active") as? Int ?? 0
                        let web_images = (bannerData as AnyObject).value(forKey: "web_images") as? NSArray ?? []
                        var subBannerModel_: [ImageModel] = []
                        for img in web_images {
                            let subBannerModel = ImageModel()
                            subBannerModel.id = (img as AnyObject).value(forKey: "id") as? Int ?? 0
                            subBannerModel.image = ((img as AnyObject).value(forKey: "name") as? String ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            subBannerModel_.append(subBannerModel)
                        }
                        print(self.bannerModels.count)
                        bannerModel.webimage = subBannerModel_
                        self.bannerModels.append(bannerModel)
                        self.newYearCollectionView.reloadData()
                    }
                    
                    
                    
                    let coupons = data.value(forKey: "coupons") as? NSArray ?? []
                    for cop in coupons {
                        var couponmodel = CouponsModel()
                        couponmodel.id = (cop as AnyObject).value(forKey: "id") as? Int ?? 0
                        couponmodel.code = (cop as AnyObject).value(forKey: "code") as? String ?? ""
                        couponmodel.image = ((cop as AnyObject).value(forKey: "image") as? String ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        couponmodel.discount = (cop as AnyObject).value(forKey: "discount") as? Int ?? 0
                        couponmodel.discount_type = (cop as AnyObject).value(forKey: "discount_type") as? String ?? ""
                        couponmodel.description_ = (cop as AnyObject).value(forKey: "description_")as? String ?? ""
                        couponmodel.name = (cop as AnyObject).value(forKey: "name") as? String ?? ""
                        couponmodel.is_new_user = (cop as AnyObject).value(forKey: "is_new_user") as? Int ?? 0
                        couponmodel.is_specific_user = (cop as AnyObject).value(forKey: "is_specific_user") as? Int ?? 0
                        couponmodel.type = (cop as AnyObject).value(forKey: "type") as? String ?? ""
                        couponmodel.payment_mode = (cop as AnyObject).value(forKey: "payment_mode") as? Int ?? 0
                        couponmodel.fixed_amount = (cop as AnyObject).value(forKey: "fixed_amount") as? Int ?? 0
                        couponmodel.max_discount = (cop as AnyObject).value(forKey: "max_discount") as? Int ?? 0
                        couponmodel.max_order_value = (cop as AnyObject).value(forKey: "max_order_value") as? Int ?? 0
                        couponmodel.order_amount = (cop as AnyObject).value(forKey: "order_amount") as? Int ?? 0
                        couponmodel.is_for_you = (cop as AnyObject).value(forKey: "is_for_you") as? String ?? ""
                        couponmodel.have_category = (cop as AnyObject).value(forKey: "have_category")as? String ?? ""
                        couponmodel.have_subcategory = (cop as AnyObject).value(forKey: "have_subcategory") as? Int ?? 0
                        couponmodel.have_product = (cop as AnyObject).value(forKey: "have_product")as? Int ?? 0
                        couponmodel.from_date = (cop as AnyObject).value(forKey: "from_date") as? Int ?? 0
                        couponmodel.to_date = (cop as AnyObject).value(forKey: "to_date") as? Int ?? 0
                        couponmodel.buy_one = (cop as AnyObject).value(forKey: "buy_one") as? String ?? ""
                        couponmodel.active = (cop as AnyObject).value(forKey: "active") as? String ?? ""
                        couponmodel.get_one = (cop as AnyObject).value(forKey: "get_one") as? String ?? ""
                        couponmodel.created_at = (cop as AnyObject).value(forKey: "created_at") as? Int ?? 0
                        couponmodel.updated_at = (cop as AnyObject).value(forKey: "updated_at") as? Int ?? 0
                        couponmodel.buy_one = (cop as AnyObject).value(forKey: "buy_one") as? String ?? ""
                        couponmodel.active = (cop as AnyObject).value(forKey: "active") as? String ?? ""
                        let image = (cop as AnyObject).value(forKey: "image") as? NSArray ?? []
                        var subCouponsModel_: [productimageModel] = []
                        for img in image {
                            let subBannerModel = productimageModel()
                            subBannerModel.id = (img as AnyObject).value(forKey: "id") as? Int ?? 0
                            subBannerModel.image = ((img as AnyObject).value(forKey: "image") as? String ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            subCouponsModel_.append(subBannerModel)
                        }
                        print(self.coupons.count)
                        couponmodel.coupon = subCouponsModel_
                        self.couponsModels.append(couponmodel)
                        self.dealCollectionView.reloadData()
                    }
                    
                    let categories = data.value(forKey: "categories") as? NSArray ?? []
                    self.categoriesModel.removeAll()
                    for cat in categories {
                        var tempModel = CategoriesModel()
                        tempModel.id = (cat as AnyObject).value(forKey: "id") as? Int ?? 0
                        tempModel.name = (cat as AnyObject).value(forKey: "name") as? String ?? ""
                        tempModel.image = ((cat as AnyObject).value(forKey: "image") as? String ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        tempModel.description_ = (cat as AnyObject).value(forKey: "description") as? String ?? ""
                        tempModel.rank = (cat as AnyObject).value(forKey: "rank") as? Int ?? 0
                        tempModel.active = (cat as AnyObject).value(forKey: "active") as? Int ?? 0
                        tempModel.created_at = (cat as AnyObject).value(forKey: "created_at") as? Int ?? 0
                        tempModel.updated_at = (cat as AnyObject).value(forKey: "updated_at") as? Int ?? 0
                        let products = (cat as AnyObject).value(forKey: "products") as? NSArray ?? []
                        var subCategoriesModel_: [ProductsModel] = []
                        for prod in products{
                            var productsModel = ProductsModel()
                            productsModel.id = (prod as AnyObject).value(forKey: "id") as? Int ?? 0
                            productsModel.sku_id = (prod as AnyObject).value(forKey: "sku_id") as? String ?? ""
                            productsModel.bog_product_id = (prod as AnyObject).value(forKey: "bog_product_id") as? String ?? ""
                            productsModel.name = (prod as AnyObject).value(forKey: "name") as? String ?? ""
                            productsModel.price = (prod as AnyObject).value(forKey: "price") as? Int ?? 0
                            productsModel.unit = (prod as AnyObject).value(forKey: "unit") as? Int ?? 0
                            productsModel.type = (prod as AnyObject).value(forKey: "type") as? String ?? ""
                            productsModel.discount = (prod as AnyObject).value(forKey: "discount") as? Int ?? 0
                            productsModel.description_ = (prod as AnyObject).value(forKey: "description") as? String ?? ""
                            productsModel.features = (prod as AnyObject).value(forKey: "features") as? String ?? ""
                            productsModel.rank = (prod as AnyObject).value(forKey: "rank") as? Int ?? 0
                            productsModel.total_views = (prod as AnyObject).value(forKey: "total_views") as? Int ?? 0
                            productsModel.total_purchase = (prod as AnyObject).value(forKey: "total_purchase") as? Int ?? 0
                            productsModel.active = (prod as AnyObject).value(forKey: "active") as? Int ?? 0
                            productsModel.to_be_showed = (prod as AnyObject).value(forKey: "to_be_showed") as? Int ?? 0
                            productsModel.to_be_showed_at = (prod as AnyObject).value(forKey: "to_be_showed_at") as? Int ?? 0
                            productsModel.created_at = (prod as AnyObject).value(forKey: "created_at") as? Int ?? 0
                            productsModel.updated_at = (prod as AnyObject).value(forKey: "updated_at") as? Int ?? 0
                            productsModel.addedToCart = (prod as AnyObject).value(forKey: "addedToCart") as? Int ?? 0
                            productsModel.addedToWishlist = (prod as AnyObject).value(forKey: "addedToWishlist") as? Int ?? 0
                            productsModel.discountedPrice = (prod as AnyObject).value(forKey: "discount_price") as? Int ?? 0
                            let images = (prod as AnyObject).value(forKey: "images") as? NSArray ?? []
                            var imageProductModel_: [imagesModel] = []
                            for img in images {
                                let subBannerModel = imagesModel()
                                subBannerModel.id = (img as AnyObject).value(forKey: "id") as? Int ?? 0
                                subBannerModel.images = ((img as AnyObject).value(forKey: "name") as? String ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                imageProductModel_.append(subBannerModel)
                            }
                            productsModel.webimage = imageProductModel_
                            subCategoriesModel_.append(productsModel)
                        }
                        tempModel.product = subCategoriesModel_
                        self.categoriesModel.append(tempModel)
                        self.catTable.reloadData()
                    }
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
                    self.myCollectionView.reloadData()
                    
                    
                    
                } else {
                    print("Error occurred")
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
}
