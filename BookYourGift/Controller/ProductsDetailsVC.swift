//
//  ProductsDetailsVC.swift
//  BookYourGift
//
//  Created by Apple on 31/07/23.
//

import UIKit

import HMSegmentedControl
import Alamofire
import SwiftyJSON

class ProductsDetailsVC: UIViewController {
    
    @IBOutlet weak var myContainerview: UIView!
    
    @IBOutlet weak var whatsappBtn: UIButton!
    
    @IBOutlet weak var mySegmentedControl: UIView!
    
    private var hmSegmentController = HMSegmentedControl()
    
    @IBOutlet weak var addCartBtn: UIButton!
    
    
    var flag = false
    
    var checked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsDiscriptionVC") as! ProductsDiscriptionVC
        addChild(vc)
        myContainerview.addSubview(vc.view)
        vc.view.frame = myContainerview.bounds
        flag = false
        addCartBtn.layer.cornerRadius = 10
        addSegmentController()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hmSegmentController.frame = self.mySegmentedControl.bounds
    }
    
    func addSegmentController(){
        self.hmSegmentController.sectionTitles = ["DETAILS","REVIEWS"]
        self.hmSegmentController.selectionIndicatorLocation = .bottom
        self.hmSegmentController.selectionIndicatorColor = .red
        self.hmSegmentController.borderColor = .lightGray
        
        self.hmSegmentController.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.black
                ]
        self.hmSegmentController.selectedTitleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.red
                ]
        
        self.hmSegmentController.borderType = .bottom
        self.hmSegmentController.selectionIndicatorHeight = 2
        self.hmSegmentController.selectionStyle = .fullWidthStripe
        self.hmSegmentController.isUserDraggable = true
        self.hmSegmentController.addTarget(self, action: #selector(segmentedControlChangedvalue(_ :)), for: UIControl.Event.valueChanged)
        mySegmentedControl.addSubview(self.hmSegmentController)
        
        
    }
    @objc func segmentedControlChangedvalue(_ sender: HMSegmentedControl) {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsDiscriptionVC") as! ProductsDiscriptionVC
            addChild(vc)
            myContainerview.addSubview(vc.view)
            vc.view.frame = myContainerview.bounds
        case 1 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsReviewVC") as! ProductsReviewVC
            addChild(vc)
            myContainerview.addSubview(vc.view)
            vc.view.frame = myContainerview.bounds
        default:
            break
        }
    
}
    @IBAction func addtoCartBtn(_ sender: UIButton) {
       
    }
    
    @IBAction func heartTappedBtn(_ sender: UIButton) {
        if flag == false{
            sender.setImage(UIImage.init(named: "Mask Group 2"), for: UIControl.State.normal)
            checked = true
            flag = true
            
        }
        else{
            sender.setImage(UIImage.init(named: "Mask Group 1"), for: .normal)
            checked = false
            flag = false
            
        }
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
}
