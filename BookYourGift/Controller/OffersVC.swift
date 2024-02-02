//
//  OffersVC.swift
//  BookYourGift
//
//  Created by Apple on 31/07/23.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage

class OffersVC: UIViewController {
    
    @IBOutlet weak var offersNotificationview: UIView!
    @IBOutlet weak var offersHeartView: UIView!
    @IBOutlet weak var offersShadowView: UIView!
    @IBOutlet weak var offersCollectionView: UICollectionView!
    @IBOutlet weak var offersPageControl: UIPageControl!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var imagearr = ["ganesh","wall","ganesh","wall","Group 525","Group 530","Group 533","Group 63104","Group 63717","Group 63724",]
    var OfferImageArr = ["new-years-2023","new-years-2023","new-years-2023","new-years-2023"]
    var bannerModels: [BannerModel] = []
    var productModels: [CategoriesModel] = []
    var currentPage = 0
    var begin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.register(UINib(nibName: "offersCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "offersCollectionViewCell")
        
        
        offersHeartView.layer.cornerRadius = 10
        offersNotificationview.layer.cornerRadius = 10
        
        offersCollectionView.delegate = self
        offersCollectionView.dataSource = self
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
       
      
        offersShadowView.layer.cornerRadius = 10
        
    }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            offersAPI()
        
    }
    @IBAction func likeTappedBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WishlistVC") as! WishlistVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func notificationBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        offersPageControl.currentPage = indexPath.row
    }
    func scrollToNextCell(){
        
        
        let cellSize = CGSizeMake(self.view.frame.width, self.view.frame.height);
        
       
        let contentOffset = offersCollectionView.contentOffset;
        
        
        if begin == true
        {
            offersPageControl.currentPage = 0
            offersCollectionView.scrollRectToVisible(CGRectZero, animated: true)
            begin = false
        }
        else
        {
            offersCollectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true);
        }
        
    }
    
    
}
extension OffersVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.offersCollectionView {
            offersPageControl.numberOfPages = bannerModels.count
            return self.bannerModels.count
            
        }else if collectionView == self.myCollectionView {
           return 4
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.offersCollectionView {
            let cell1 = offersCollectionView.dequeueReusableCell(withReuseIdentifier: "MyNewYearCollectionViewCell", for: indexPath) as! MyNewYearCollectionViewCell
            print(bannerModels[indexPath.item].image as Any)
            let webImages = bannerModels[indexPath.item].image as? [[String: Any]]
            if bannerModels[indexPath.row].webimage.count != 0 {
                let url = (bannerModels[indexPath.row].webimage[0].image ?? "")
                cell1.myImageview.sd_setImage(with: URL(string: url ), placeholderImage: UIImage(named: "9055549_bxs_file_image_icon"), options: SDWebImageOptions(rawValue: 0))
            }
            
            return cell1
        }else if collectionView == self.myCollectionView {
            let cell2 = myCollectionView.dequeueReusableCell(withReuseIdentifier: "offersCollectionViewCell", for: indexPath) as! offersCollectionViewCell
            
                  
            cell2.offersImageView.image = UIImage(named: imagearr[indexPath.row])
            cell2.offersView.layer.cornerRadius = 10
            return cell2
            
        }
        return UICollectionViewCell()
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == self.offersCollectionView {
                return CGSize(width: offersCollectionView.bounds.width, height: offersCollectionView.bounds.height)
            } else if collectionView == self.myCollectionView {
                let size = (myCollectionView.frame.size.width/2) - 5
                return CGSize(width: size, height:320)
            }
            return CGSize(width: 0 , height: 0)
        }
            
        
        }
    
    
extension OffersVC {
    func offersAPI()
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
                        self.offersCollectionView.reloadData()
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


