//
//  BestSellerBeerCollectionViewCell.swift
//  BookYourGift
//
//  Created by Apple on 04/08/23.
//

import UIKit

class BestSellerBeerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var beerLbl: UILabel!
    @IBOutlet weak var beerView: UIView!
    @IBOutlet weak var addtoCartBtn: UIButton!
    @IBOutlet weak var beerImageView: UIImageView!
    
    var flag = false
    
    var checked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        flag = false
        addtoCartBtn.layer.cornerRadius = 10
        beerView.layer.cornerRadius = 10
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
    }

