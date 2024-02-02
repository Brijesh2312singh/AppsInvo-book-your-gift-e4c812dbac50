//
//  TabBarVC.swift
//  BookYourGift
//
//  Created by Apple on 25/07/23.
//

import UIKit

class TabBarVC: UIViewController {
    @IBOutlet weak var offerContainerView: UIView!
    @IBOutlet weak var categoryContainerView: UIView!
    @IBOutlet weak var homeContainerView: UIView!
    @IBOutlet weak var cartContainerView: UIView!
    @IBOutlet weak var profileContainerView: UIView!
    @IBOutlet weak var tab1: UIView!
    @IBOutlet weak var tab2: UIView!
    @IBOutlet weak var tab3: UIView!
    @IBOutlet weak var tab4: UIView!
    @IBOutlet weak var tab5: UIView!
    @IBOutlet weak var poppedImage: UIImageView!
    @IBOutlet weak var tabBar: UIView!
    @IBOutlet weak var poppedImageXPosition: NSLayoutConstraint!
    @IBOutlet weak var myView: UIView!
    
//    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.layer.cornerRadius = 20
        offerContainerView.alpha = 0
        categoryContainerView.alpha = 0
        homeContainerView.alpha = 1
        cartContainerView.alpha = 0
        profileContainerView.alpha = 0
        
        tab1.alpha = 1
        tab2.alpha = 1
        tab3.alpha = 0
        tab4.alpha = 1
        tab5.alpha = 1
        
        tabBar.layer.cornerRadius = 20
        tabBar.layer.shadowColor = UIColor.systemPink.cgColor
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowRadius = 20
        poppedImage.layer.cornerRadius = 20
        poppedImage.clipsToBounds = true
        poppedImage.image = UIImage(named: "Group 63993")
    }
    @IBAction func selectTabsButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            UIView.animate(withDuration: 0.5) {
                self.poppedImage.frame.origin.x = (self.tab1.frame.origin.x + (self.tab1.frame.size.width/2)) - 25
                self.offerContainerView.alpha = 1
                self.categoryContainerView.alpha = 0
                self.homeContainerView.alpha = 0
                self.cartContainerView.alpha = 0
                self.profileContainerView.alpha = 0
                self.myView.isHidden = true
                self.tab1.alpha = 0
                self.tab2.alpha = 1
                self.tab3.alpha = 1
                self.tab4.alpha = 1
                self.tab5.alpha = 1
                self.poppedImage.image = UIImage(named: "Group 63993")
                
            }
        case 2:
            UIView.animate(withDuration: 0.5) {
                self.poppedImage.frame.origin.x = (self.tab2.frame.origin.x + (self.tab2.frame.size.width/2)) - 25
                
                self.offerContainerView.alpha = 0
                self.categoryContainerView.alpha = 1
                self.homeContainerView.alpha = 0
                self.cartContainerView.alpha = 0
                self.profileContainerView.alpha = 0
                self.myView.isHidden = true
                self.tab1.alpha = 1
                self.tab2.alpha = 0
                self.tab3.alpha = 1
                self.tab4.alpha = 1
                self.tab5.alpha = 1
                self.poppedImage.image = UIImage(named: "Group 63994")
            }
        case 3:
            UIView.animate(withDuration: 0.5) {
                self.poppedImage.frame.origin.x = (self.tab3.frame.origin.x + (self.tab3.frame.size.width/2)) - 25
                
                self.offerContainerView.alpha = 0
                self.categoryContainerView.alpha = 0
                self.homeContainerView.alpha = 1
                self.cartContainerView.alpha = 0
                self.profileContainerView.alpha = 0
                self.myView.isHidden = false
                self.tab1.alpha = 1
                self.tab2.alpha = 1
                self.tab3.alpha = 0
                self.tab4.alpha = 1
                self.tab5.alpha = 1
                self.poppedImage.image = UIImage(named: "Group 63993")
            }
        case 4:
            UIView.animate(withDuration: 0.5) {
                self.poppedImage.frame.origin.x = (self.tab4.frame.origin.x + (self.tab4.frame.size.width/2)) - 25
                
                self.offerContainerView.alpha = 0
                self.categoryContainerView.alpha = 0
                self.homeContainerView.alpha = 0
                self.cartContainerView.alpha = 1
                self.profileContainerView.alpha = 0
                self.myView.isHidden = true
                self.tab1.alpha = 1
                self.tab2.alpha = 1
                self.tab3.alpha = 1
                self.tab4.alpha = 0
                self.tab5.alpha = 1
                self.poppedImage.image = UIImage(named: "Group 63992")
            }
        case 5:
            UIView.animate(withDuration: 0.5) {
                self.poppedImage.frame.origin.x = (self.tab5.frame.origin.x + (self.tab5.frame.size.width/2)) - 25
                
                self.offerContainerView.alpha = 0
                self.categoryContainerView.alpha = 0
                self.homeContainerView.alpha = 0
                self.cartContainerView.alpha = 0
                self.profileContainerView.alpha = 1
                self.myView.isHidden = true
                self.tab1.alpha = 1
                self.tab2.alpha = 1
                self.tab3.alpha = 1
                self.tab4.alpha = 1
                self.tab5.alpha = 0
                self.poppedImage.image = UIImage(named: "Group 63991")
            }
        default:
            break
        }
    }
}
