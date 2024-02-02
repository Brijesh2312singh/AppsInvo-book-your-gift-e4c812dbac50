//
//  PastOrdersVC.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit

class PastOrdersVC: UIViewController {
    
    @IBOutlet weak var pastTableView: UITableView!
    var imagrArr = ["Group 63981","Group 63981","Group 63981","Group 63981"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pastTableView.delegate = self
        pastTableView.dataSource = self

        
    }
    

}
extension PastOrdersVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pastTableView.dequeueReusableCell(withIdentifier: "PastOrderTableViewCell", for: indexPath) as! PastOrderTableViewCell
        cell.myOrderImageView.image = UIImage(named: imagrArr[indexPath.row])
        cell.reorderBtn.layer.cornerRadius = 10
        cell.cancelBtn.layer.cornerRadius = 10
        cell.cancelBtn.layer.borderWidth = 1.0
        cell.cancelBtn.layer.borderColor = UIColor.red.cgColor
        
        
        return cell
    }
    
    
}
