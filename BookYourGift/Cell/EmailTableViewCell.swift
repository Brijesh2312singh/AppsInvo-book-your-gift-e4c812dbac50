//
//  EmailTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 02/08/23.
//

import UIKit

class EmailTableViewCell: UITableViewCell {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        emailView.layer.borderWidth = 1.0
        emailView.layer.borderColor = UIColor.gray.cgColor
        emailView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
