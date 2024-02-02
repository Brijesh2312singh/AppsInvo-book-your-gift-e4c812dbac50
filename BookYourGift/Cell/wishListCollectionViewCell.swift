//
//  wishListCollectionViewCell.swift
//  BookYourGift
//
//  Created by Apple on 10/08/23.
//

import UIKit

class wishListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var wishlistView: UIView!
    @IBOutlet weak var addtoCartLbl: UIButton!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var homedecorLbl: UILabel!
    @IBOutlet weak var motiwatedLbl: UILabel!
    @IBOutlet weak var wishlistImageView: UIImageView!
    
    var flag = false
    
    var checked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        wishlistView.layer.cornerRadius = 8
        wishlistView.layer.shadowColor = UIColor.gray.cgColor
        wishlistView.layer.shadowOffset = .zero
        wishlistView.layer.shadowOpacity = 0.3
        wishListBtn.layer.cornerRadius = 8
        flag = false
        
        
    }
    
    
    @IBAction func heartTappedBtn(_ sender: UIButton) {
        if flag == false{
            sender.setImage(UIImage.init(named: "Mask Group 2"), for: UIControl.State.normal)
            checked = true
            flag = true
            
        }
        else{
            sender.setImage(UIImage.init(named: "Mask Group 1"), for: .normal)
            checked = false
            flag = false
            
        }
    }
    
    @IBAction func addTocarttappedBtn(_ sender: UIButton) {
    }
}
