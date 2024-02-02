//
//  NotificationTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 31/07/23.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

  
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var offerLbl: UILabel!
    @IBOutlet weak var notificationImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

 
    }

}
