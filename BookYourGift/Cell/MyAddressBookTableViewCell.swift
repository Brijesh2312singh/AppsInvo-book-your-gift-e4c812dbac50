//
//  MyAddressBookTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit

class MyAddressBookTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

   
    }
    func configure(title: String, isSelected: Bool) {
        addressLbl.text = title
        checkBtn.isSelected = isSelected
       }
    
}
