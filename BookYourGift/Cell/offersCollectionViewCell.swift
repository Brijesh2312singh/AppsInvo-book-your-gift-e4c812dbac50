//
//  offersCollectionViewCell.swift
//  BookYourGift
//
//  Created by Apple on 31/07/23.
//

import UIKit

class offersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var offersLbl: UILabel!
    @IBOutlet weak var addCartbtn: UIButton!
    @IBOutlet weak var offersImageView: UIImageView!
    @IBOutlet weak var offersView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addCartbtn.layer.cornerRadius = 8
        offersView.layer.cornerRadius = 8
        offersView.layer.shadowColor = UIColor.gray.cgColor
        offersView.layer.shadowOffset = .zero
        offersView.layer.shadowOpacity = 0.3
    }

}
