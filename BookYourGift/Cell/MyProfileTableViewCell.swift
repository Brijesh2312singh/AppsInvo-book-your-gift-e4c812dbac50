//
//  MyProfileTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 02/08/23.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var firstNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstNameView.layer.borderWidth = 1.0
        firstNameView.layer.borderColor = UIColor.gray.cgColor
        firstNameView.layer.cornerRadius = 10
        
        
        lastNameView.layer.borderWidth = 1.0
        lastNameView.layer.borderColor = UIColor.gray.cgColor
        lastNameView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
