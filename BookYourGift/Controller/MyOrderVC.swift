//
//  MyOrderVC.swift
//  BookYourGift
//
//  Created by Apple on 28/07/23.
//

import UIKit
import HMSegmentedControl


class MyOrderVC: UIViewController {
    
    @IBOutlet weak var myview: UIView!
    
    
    @IBOutlet weak var myContainerview: UIView!
    @IBOutlet weak var mySegmentedControl: UIView!
    
    private var hmSegmentController = HMSegmentedControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "OngoingOrdersVC") as! OngoingOrdersVC
        addChild(vc)
        myContainerview.addSubview(vc.view)
        vc.view.frame = myContainerview.bounds
        addSegmentController()
        
        myview.layer.shadowColor = UIColor.gray.cgColor
        myview.layer.shadowOffset = .zero
        myview.layer.shadowOpacity = 0.3
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hmSegmentController.frame = self.mySegmentedControl.bounds
    }
    
    func addSegmentController(){
        self.hmSegmentController.sectionTitles = ["Ongoing Orders","Past Orders"]
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
            let vc = storyboard?.instantiateViewController(withIdentifier: "OngoingOrdersVC") as! OngoingOrdersVC
            addChild(vc)
            myContainerview.addSubview(vc.view)
            vc.view.frame = myContainerview.bounds
        case 1 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "PastOrdersVC") as! PastOrdersVC
            addChild(vc)
            myContainerview.addSubview(vc.view)
            vc.view.frame = myContainerview.bounds
        default:
            break
        }
    }
        @IBAction func backBtn(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    

