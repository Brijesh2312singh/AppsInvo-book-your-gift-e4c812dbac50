//
//  MyOrderTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit

class MyOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var myOrderView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var reorderBtn: UIButton!
    @IBOutlet weak var myOrderImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        reorderBtn.layer.cornerRadius = 10
        cancelBtn.layer.borderWidth = 1.0
        cancelBtn.layer.borderColor = UIColor.red.cgColor
        cancelBtn.layer.cornerRadius = 10
        myOrderView.layer.cornerRadius = 10
        myOrderView.layer.shadowColor = UIColor.gray.cgColor
        myOrderView.layer.shadowOffset = .zero
        myOrderView.layer.shadowOpacity = 0.3
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
