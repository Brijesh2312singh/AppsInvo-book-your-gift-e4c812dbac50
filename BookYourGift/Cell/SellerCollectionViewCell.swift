//
//  SellerCollectionViewCell.swift
//  BookYourGift
//
//  Created by Apple on 21/08/23.
//

import UIKit
import SwiftyJSON
import Alamofire

class SellerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var homeDecorLbl: UILabel!
    @IBOutlet weak var wallhangingLbl: UILabel!
    @IBOutlet weak var sellerView: UIView!
    @IBOutlet weak var sellerBtn: UIButton!
    @IBOutlet weak var sellerImageView: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    var flag = false
    
    var checked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sellerBtn.layer.cornerRadius = 8
        sellerView.layer.cornerRadius = 10
        flag = false
        
        sellerView.layer.cornerRadius = 8
        sellerView.layer.shadowColor = UIColor.gray.cgColor
        sellerView.layer.shadowOffset = .zero
        sellerView.layer.shadowOpacity = 0.3
        
    }
    
}

