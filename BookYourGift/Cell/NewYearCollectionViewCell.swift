//
//  NewYearCollectionViewCell.swift
//  BookYourGift
//
//  Created by Apple on 25/07/23.
//

import UIKit

class NewYearCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newYearImageView: UIImageView!
    
    var flag = false
    
    var checked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        flag = false

            newYearImageView.contentMode = .scaleAspectFit
           }



        
        
    
    
    @IBAction func heartTappedBtn(_ sender: UIButton) {
        if flag == false{
            sender.setImage(UIImage.init(named: "Mask Group 1"), for: UIControl.State.normal)
            checked = true
            flag = true
            
        }
        else{
            sender.setImage(UIImage.init(named: "unchecked"), for: .normal)
            checked = false
            flag = false
            
        }
    }
}
