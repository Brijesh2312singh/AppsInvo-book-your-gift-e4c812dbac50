//
//  MyCartTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit
import SwiftyJSON
import Alamofire

class MyCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cartLbl: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var cartImageview: UIImageView!
    var itemCount: Int = 1
    var pricePerItem: Double = 448.00
    override func awakeFromNib() {
        super.awakeFromNib()
        updateLabels()
        pricelbl.text = "₹448.00/-"
    }
    func updateLabels() {
        countLbl.text = "\(itemCount)"
        pricelbl.text = "\(Double(itemCount) + pricePerItem)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func addBtn(_ sender: UIButton) {
        itemCount += 1
                pricePerItem += 448.00
                updateLabels()
    }
}
