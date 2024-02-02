//
//  NotificationVC.swift
//  BookYourGift
//
//  Created by Apple on 31/07/23.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var notificationView: UIView!
    
    var headingArray = ["Today","Yesterday"]
    var TodayImageArray = ["Group 64002","Group 64005"]
    var YesterdayImageArray = ["Group 64002","Group","Group 64004","Group 64005","Group 64002","Group","Group 64004","Group 64005"]
    var todaytimeArr = ["16:35 PM","19:35 PM"]
    var TodayContentArray = ["Special Offer 50% for New Year. Don't forget to use."," Your order #BYG089 has been shiped! "]
    
    var YesterdayContentArray = ["Special Offer 50% for New Year. Don't forget to use.","Flash Sale starting tommorrow Don't forget to check it oput","special Offer 50% off for New User. Don't forget to use","your order #8yg089 has been shipped!","Special Offer 50% for New Year. Don't forget to use.","Flash Sale starting tommorrow Don't forget to check it oput","special Offer 50% off for New User. Don't forget to use","your order #8yg089 has been shipped!"]
    var YesterdaytimeArr = ["20:35 PM","07:35 PM","20:35 PM","07:35 PM","20:35 PM","07:35 PM","20:35 PM","07:35 PM"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        myTableView.delegate = self

        
    }
    

    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            
            return TodayContentArray.count
        }
        
        else if section == 1{
            
            return YesterdayContentArray.count
        }
        
        else{
            
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
            let headerCell = myTableView.dequeueReusableCell(withIdentifier: "NotificationTitleTableViewCell") as! NotificationTitleTableViewCell
            
            headerCell.headingLbl.text = headingArray[section]
            
            
            
            return headerCell
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let contentCell = myTableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
            
            
            if indexPath.section == 0{
                
                contentCell.notificationImageView.image = UIImage(named: TodayImageArray[indexPath.row])
                
                contentCell.offerLbl.text = TodayContentArray[indexPath.row]
                contentCell.timeLbl.text = todaytimeArr[indexPath.row]
                
                return contentCell
            }
            else if indexPath.section == 1{
                
                contentCell.notificationImageView.image = UIImage(named: YesterdayImageArray[indexPath.row])
                
                contentCell.offerLbl.text = YesterdayContentArray[indexPath.row]
                contentCell.timeLbl.text = YesterdaytimeArr[indexPath.row]
             
                
                return contentCell
                
            }
            else{
                
                return UITableViewCell()
            }
        }
    }

