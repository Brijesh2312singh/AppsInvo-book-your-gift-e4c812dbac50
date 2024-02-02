//
//  PastOrderTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit

class PastOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var myOrderView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var reorderBtn: UIButton!
    @IBOutlet weak var myOrderImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        myOrderView.layer.cornerRadius = 10
        myOrderView.layer.shadowColor = UIColor.gray.cgColor
        myOrderView.layer.shadowOffset = .zero
        myOrderView.layer.shadowOpacity = 0.3
        
    }

   
}
