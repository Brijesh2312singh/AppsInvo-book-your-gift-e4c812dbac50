//
//  EnterPromoCodeTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit

class EnterPromoCodeTableViewCell: UITableViewCell {
  
    @IBOutlet weak var promoLbl: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var offerView: UIView!
  
    @IBOutlet weak var promoBtn: UIButton!
    
    var view = CAShapeLayer()
    
      override func awakeFromNib() {
         super.awakeFromNib()
        
        myView.layer.cornerRadius = 10
    }
    
    
    @IBAction func promoTappedBtn(_ sender: UIButton) {
        UIPasteboard.general.string = promoLbl.text
       
    }
}

    

