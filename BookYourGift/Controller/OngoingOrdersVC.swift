//
//  OngoingOrdersVC.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage


class OngoingOrdersVC: UIViewController {
    
    @IBOutlet weak var orderTableView: UITableView!
    var imagrArr = ["Group 63981","Group 63981","Group 63981","Group 63981"]
    var dataModel: [orderdataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ongoingOrdersAPI()
        
    }
}
extension OngoingOrdersVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagrArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: "MyOrderTableViewCell", for: indexPath) as! MyOrderTableViewCell
        cell.myOrderImageView.image = UIImage(named: imagrArr[indexPath.row])
//        cell.myOrderImageView.image = nil
//        cell.myOrderImageView.sd_setImage(with: URL(string: dataModel[indexPath.item].orderimage[0].images ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
       
    }
}
extension OngoingOrdersVC {
    func ongoingOrdersAPI()
    {
        AF.request("https://api.bookyourgift.in/bookyourgift-api/api/customer/order/myOrder?page=1", method: .get, encoding: JSONEncoding.default, headers: [
            "Accept": "application/json",
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
let orders = data.value(forKey: "orders") as? NSArray ?? []
self.dataModel.removeAll()
for ord in orders {
    var ordModel = orderdataModel()
    ordModel.id = (ord as AnyObject).value(forKey: "id") as? Int ?? 0
    ordModel.order_status_id = (ord as AnyObject).value(forKey: "order_status_id") as? Int ?? 0
    ordModel.bog_order_id = (ord as AnyObject).value(forKey: "bog_order_id") as? Int ?? 0
    ordModel.status = (ord as AnyObject).value(forKey: "status") as? String ?? ""
    ordModel.payment_mode = (ord as AnyObject).value(forKey: "payment_mode") as? String ?? ""
    ordModel.transaction_status = (ord as AnyObject).value(forKey: "transaction_status") as? String ?? ""
    ordModel.reference_id = (ord as AnyObject).value(forKey: "reference_id") as? Int ?? 0
    ordModel.amount = (ord as AnyObject).value(forKey: "amount") as? Int ?? 0
    ordModel.coupon_applied = (ord as AnyObject).value(forKey: "coupon_applied") as? String ?? ""
    ordModel.discount = (ord as AnyObject).value(forKey: "discount") as? Int ?? 0
    ordModel.cod_price = (ord as AnyObject).value(forKey: "cod_price") as? Int ?? 0
    ordModel.shipping_price = (ord as AnyObject).value(forKey: "shipping_price") as? Int ?? 0
    ordModel.delivery_date = (ord as AnyObject).value(forKey: "delivery_date") as! NSNull;NSNull()
    ordModel.cancel_at = (ord as AnyObject).value(forKey: "cancel_at") as! NSNull;NSNull()
    ordModel.delivered_at = (ord as AnyObject).value(forKey: "delivered_at") as! NSNull;NSNull()
    ordModel.return_at = (ord as AnyObject).value(forKey: "return_at") as! NSNull;NSNull()
    ordModel.created_at = (ord as AnyObject).value(forKey: "created_at") as? Int ?? 0
    let order_product = (ord as AnyObject).value(forKey: "order_product") as? NSArray ?? []
    var subOrdersModel_: [order_productModel] = []
    for prod in order_product{
        var productsModel = order_productModel()
        productsModel.id = (prod as AnyObject).value(forKey: "id") as? Int ?? 0
        productsModel.product_sku_id = (prod as AnyObject).value(forKey: "product_sku_id") as? String ?? ""
        productsModel.product_relation = (prod as AnyObject).value(forKey: "product_relation") as? String ?? ""
        productsModel.product_relation_image = (prod as AnyObject).value(forKey: "product_relation_image") as? String ?? ""
        productsModel.product_occasion_image = (prod as AnyObject).value(forKey: "product_occasion_image") as? String ?? ""
        productsModel.product_category = (prod as AnyObject).value(forKey: "product_category") as? String ?? ""
        productsModel.product_category_image = (prod as AnyObject).value(forKey: "product_category_image") as? String ?? ""
        productsModel.product_sub_category = (prod as AnyObject).value(forKey: "product_sub_category")as? String ?? ""
        productsModel.product_sub_category_image = (prod as AnyObject).value(forKey: "product_sub_category_image") as? String ?? ""
        productsModel.product_name = (prod as AnyObject).value(forKey: "product_name") as? String ?? ""
        productsModel.product_price = (prod as AnyObject).value(forKey: "product_price") as? Int ?? 0
        productsModel.product_type = (prod as AnyObject).value(forKey: "product_type")as? String ?? ""
        productsModel.product_discount = (prod as AnyObject).value(forKey: "product_discount") as? Int ?? 0
        productsModel.product_description = (prod as AnyObject).value(forKey: "product_description")as? String ?? ""
        productsModel.product_colour_code = (prod as AnyObject).value(forKey: "product_colour_code") as? String ?? ""
        productsModel.product_colour_image = (prod as AnyObject).value(forKey: "product_colour_image") as? String ?? ""
        productsModel.product_size = (prod as AnyObject).value(forKey: "product_size") as? String ?? ""
        productsModel.quantity = (prod as AnyObject).value(forKey: "quantity") as? Int ?? 0
        productsModel.product_features = (prod as AnyObject).value(forKey: "product_features") as? String ?? ""
       
        let images = (prod as AnyObject).value(forKey: "images") as? NSArray ?? []
        var imageProductModel_: [orderimagesModel] = []
        for img in images {
            let subBannerModel = orderimagesModel()
            subBannerModel.id = (img as AnyObject).value(forKey: "id") as? Int ?? 0
            subBannerModel.images = ((img as AnyObject).value(forKey: "name") as? String ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            imageProductModel_.append(subBannerModel)
        }
        productsModel.orderimage = imageProductModel_
        subOrdersModel_.append(productsModel)
    }
    ordModel.orderproduct = subOrdersModel_
    self.dataModel.append(ordModel)
    self.orderTableView.reloadData()
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
