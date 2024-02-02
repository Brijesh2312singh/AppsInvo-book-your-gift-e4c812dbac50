//
//  CategeriseCollectionViewCell.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit

class CategeriseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categriseView: UIView!
    @IBOutlet weak var categeriseLbl: UILabel!
    @IBOutlet weak var categeriseImageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        categriseView.layer.cornerRadius = 8
//        categriseView.layer.shadowColor = UIColor.gray.cgColor
//        categriseView.layer.shadowOffset = .zero
//        categriseView.layer.shadowOpacity = 0.3
        
    }

}
