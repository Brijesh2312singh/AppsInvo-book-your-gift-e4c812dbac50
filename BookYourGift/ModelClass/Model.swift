//
//  Model.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import Foundation
import UIKit


class ModelClass: NSObject {
var userName = ""
var email = ""
var phoneNum = ""
var password = ""
var confirmPass = ""
var fullName = ""
var referralCode = ""
var errorMessage = ""
var errorIndex = -1
var  Datepicker = ""
var coins = ""
var coinsCode = ""
var coinsQuantity = ""
var coinsPrice = ""
var bio = ""
var country = "USA"
var country1 = ""
var city = "New York"
var dateOfBirth = "28 Nov 1999"
var selectedcountryCode = "+91"
var selectedcountryName = "IN"
var selectedCountry = "India"
var countryCode = ""
var countryName = ""
var selectCountry = ""
var selectState = ""
var selectProvince = ""
var otp1Var = ""
var otp2Var = ""
var otp3Var = ""
var otp4Var = ""
var otp5Var = ""
var otp6Var = ""
var oldPassword = ""
var passwordError = ""
var confirmPassError = ""
var genre = ""
var homeView = false
var Name = ""
var ZipCode = ""
var Adhar = ""
var pan = ""
var dob = ""
var state = ""
var province = ""
var datePicker = ""
var isDrop = false
var titleName = ""
var caption = ""
}
class CategoryModel: NSObject {
    var id:Int?
    var name:String?
    var image:String?
    var description_:String?
    var rank:Int?
    var active:Int?
    var sub_category_count:Int?
    var subcategory = [SubCategoryModel]()
    var category_payment_method = [CategoryPaymentMethodModel]()
}

class SubCategoryModel: NSObject {
    var id:Int?
    var name:String?
    var image:String?
    var rank:Int?
    var active:Int?
}
class CategoryPaymentMethodModel: NSObject {
    
}
    class ProductModel {
        var id:Int?
        var sku_id:String?
        var bog_product_id:String?
        var description_:String?
        var name:String?
        var price:Int?
        var unit:Int?
        var type:String?
        var discount:Int?
        var description:String?
        var features:String?
        var rank:Int?
        var total_views:Int?
        var total_purchase:Int?
        var active:Int?
        var to_be_showed:Int?
        var addedToCart:Int?
        var discount_price:Int?
        var subproduct = [SubProductsModel]()
    }
    class SubProductsModel {
        var id:Int?
        var image:String?
    }
class DataModel: NSObject {
    var wishlists: String?
        var sub_total_price:Int?
        var total_discount:Int?
        var total_payable_amount:Int?
        var coupon_discount:Int?
        
    }
    class BannerModel: NSObject {
        var id:Int?
        var name:String?
        var from_date:Int?
        var to_date:Int?
        var active:Int?
        var image:String?
        var webimage = [ImageModel]()
        }
class ImageModel: NSObject {
    var id:Int?
    var image:String?
    }
class CategoriesModel: NSObject {
    var id:Int?
    var name:String?
    var image:String?
    var description_:String?
    var rank:Int?
    var active:Int?
    var created_at:Int?
    var updated_at:Int?
    var product: [ProductsModel] = []
   
}
class ProductsModel: NSObject {
    var id:Int?
    var sku_id:String?
    var bog_product_id:String?
    var name:String?
    var price:Int?
    var unit:Int?
    var type = ""
    var discount:Int?
    var description_:String?
    var features:String?
    var rank:Int?
    var total_views:Int?
    var total_purchase:Int?
    var active:Int?
    var to_be_showed:Int?
    var to_be_showed_at:Int?
    var created_at:Int?
    var updated_at:Int?
    var addedToCart:Int?
    var discountedPrice:Int?
    var addedToWishlist:Int?
    var image:String?
    var product: [ProductsModel] = []
    var webimage = [imagesModel]()
}
class imagesModel: NSObject {
    var id:Int?
    var images:String?
}
class CouponsModel: NSObject {
    var id:Int?
    var code:String?
    var image:String?
    var discount: Int?
    var discount_type:String??
    var description_:String?
    var name:String?
    var is_new_user:Int?
    var is_specific_user:Int?
    var type:String?
    var payment_mode:Int?
    var fixed_amount:Int?
    var max_discount:Int?
    var max_order_value:Int?
    var order_amount:Int?
    var is_for_you:String?
    var have_category:String?
    var have_subcategory:Int?
    var have_product:Int?
    var from_date: Int?
    var to_date: Int?
    var buy_one = ""
    var active = ""
    var get_one = ""
    var created_at: Int?
    var updated_at: Int?
    var coupon = [productimageModel]()
}
class productimageModel: NSObject {
    var id:Int?
    var image:String?
}
class WishlistModel: NSObject {
    var id:Int?
    var myproduct: [myProductsModel] = []
}
class myProductsModel: NSObject {
    var id:Int?
    var sku_id:String?
    var bog_product_id:String?
    var name:String?
    var price:Int?
    var unit:Int?
    var type = ""
    var discount:Int?
    var description_:String?
    var features:String?
    var rank:Int?
    var total_views:Int?
    var total_purchase:Int?
    var active:Int?
    var to_be_showed:Int?
    var to_be_showed_at:Int?
    var created_at:Int?
    var updated_at:Int?
    var addedToCart:Int?
    var discountedPrice:Int?
    var myproduct: [myProductsModel] = []
    var mywebimage = [myimagesModel]()
}
class myimagesModel: NSObject {
    var id:Int?
    var images:String?
}
struct Item {
    let name: String
    let details: String
    var quantity: Int
}
class orderdataModel: NSObject {
    var id:Int?
    var order_status_id:Int?
    var bog_order_id:Int?
    var status:String?
    var payment_mode:String?
    var transaction_status:String?
    var reference_id:Int?
    var amount:Int?
    var coupon_applied:String?
    var discount:Int?
    var cod_price:Int?
    var shipping_price:Int?
    var delivery_date:NSNull?
    var cancel_at:NSNull?
    var delivered_at:NSNull?
    var return_at:NSNull?
    var created_at:Int?
    var orderimage: [orderimagesModel] = []
    var orderproduct: [order_productModel] = []
}
class order_productModel: NSObject {
    var id:Int?
    var product_sku_id:String?
    var product_relation = ""
    var product_relation_image = ""
    var product_occasion_image = ""
    var product_category = ""
    var product_category_image = ""
    var product_sub_category = ""
    var product_sub_category_image = ""
    var product_name:String?
    var product_price:Int?
    var product_type = ""
    var product_discount:Int?
    var product_description:String?
    var product_colour_code = ""
    var product_colour_image = ""
    var product_size = ""
    var quantity:Int?
    var product_features:String?
    var orderimage: [orderimagesModel] = []
   
}
class orderimagesModel: NSObject {
    var id:Int?
    var images:String?
}
class mywishlistModel: NSObject {
    var id:Int?
    var p_id:Int?
    var sku_id:String?
    var bog_product_id:String?
    var name:String?
    var price:Int?
    var unit:Int?
    var type = ""
    var discount:Int?
    var description_:String?
    var features:String?
    var rank:Int?
    var total_views:Int?
    var total_purchase:Int?
    var active:Int?
    var to_be_showed:Int?
    var to_be_showed_at:Int?
    var created_at:Int?
    var updated_at:Int?
    var addedToCart:Int?
    var discountedPrice:Int?
    var wishlistimages: [wishlistimagesModel] = []
   
}

class wishlistimagesModel: NSObject {
    var id:Int?
    var images:String?
}
class SProductsModel: NSObject {
    var id:Int?
    var sku_id:String?
    var bog_product_id:String?
    var name:String?
    var price:Int?
    var unit:Int?
    var type = ""
    var discount:Int?
    var description_:String?
    var features:String?
    var rank:Int?
    var total_views:Int?
    var total_purchase:Int?
    var active:Int?
    var to_be_showed:Int?
    var to_be_showed_at:Int?
    var created_at:Int?
    var updated_at:Int?
    var addedToCart:Int?
    var discountedPrice:Int?
    var addedToWishlist:Int?
    var recommendedP: [recommendedModel] = []
    var recommendedimages: [recommendedimagesModel] = []
}
class recommendedModel: NSObject {
    var id:Int?
    var sku_id:String?
    var bog_product_id:String?
    var name:String?
    var price:Int?
    var unit:Int?
    var type = ""
    var discount:Int?
    var description_:String?
    var features:String?
    var rank:Int?
    var total_views:Int?
    var total_purchase:Int?
    var active:Int?
    var to_be_showed:Int?
    var to_be_showed_at:Int?
    var created_at:Int?
    var updated_at:Int?
    var addedToCart:Int?
    var addedToWishlist:Int?
    var discountedPrice:Int?
    var recommendedimages: [recommendedimagesModel] = []
   

}
class recommendedimagesModel: NSObject {
    var id:Int?
    var images:String?
}
class addModel: NSObject {
    var carts: String?
     var sub_total_price:Int?
       var total_discount:Int?
        var total_payable_amount:Int?
       var coupon_discount: Int?
         var coupon =  ""
         var shipping_price: Int?
      var cod_price: Int?
        var cod_label: String?
       var shipping_label:String?
       var payment_mod: Int?
}
class addcartModel: NSObject {
    var id:Int?
    var product_id:Int?
    var quantity:Int?
    var p_id:Int?
    var sku_id:String?
    var bog_product_id:String?
    var name:String?
    var price:Int?
    var unit:Int?
    var type = ""
    var discount:Int?
    var description_:String?
    var features:String?
    var rank:Int?
    var total_views:Int?
    var total_purchase:Int?
    var active:Int?
    var to_be_showed:Int?
    var to_be_showed_at:Int?
    var created_at:Int?
    var updated_at:Int?
    var discount_price:Int?
    var addcartimages: [addcartimagesModel] = []
}
class addcartimagesModel: NSObject {
    var id:Int?
    var images:String?
}
