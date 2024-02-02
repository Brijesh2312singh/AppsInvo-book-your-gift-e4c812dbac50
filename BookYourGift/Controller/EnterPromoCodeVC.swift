//
//  EnterPromoCodeVC.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit

class EnterPromoCodeVC: UIViewController {

    @IBOutlet weak var popupView: UIVisualEffectView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var promoCodeView: UIView!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var promoTableView: UITableView!
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        promoTableView.delegate = self
        promoTableView.dataSource = self
        
        applyBtn.layer.cornerRadius = 8
        
        codeView.layer.cornerRadius = 10
        codeView.layer.shadowColor = UIColor.gray.cgColor
        codeView.layer.shadowOffset = .zero
        codeView.layer.shadowOpacity = 0.3
        
   
        promoCodeView.clipsToBounds = true
        promoCodeView.layer.cornerRadius = 20
        promoCodeView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        
           
    
    }

    @IBAction func applyTappedBtn(_ sender: UIButton){
        
//        promoCodeView.isHidden = true
        
        if let infoViewController = storyboard?.instantiateViewController(identifier: "AppliedCouponsVC") {
            infoViewController.modalPresentationStyle = .overCurrentContext
            infoViewController.modalTransitionStyle = .crossDissolve
            present(infoViewController, animated: true)
        }
        
    }

    
    @IBAction func crossedTappedBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
}
extension EnterPromoCodeVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = promoTableView.dequeueReusableCell(withIdentifier: "EnterPromoCodeTableViewCell", for: indexPath) as! EnterPromoCodeTableViewCell
        
        if indexPath.row == 0
        {
            
            cell.offerView.isHidden = true
            
            return cell
            
        }
        if indexPath.row == 1
        {
            
            cell.offerView.isHidden = false
            return cell
            
        }
        if indexPath.row == 2
        {
            
            cell.offerView.isHidden = false
            return cell
            
        }
        if indexPath.row == 3
        {
            
            cell.offerView.isHidden = true
            return cell
            
        }
        
        
        
        return UITableViewCell()
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let Vc = self.storyboard?.instantiateViewController(withIdentifier: "AppliedCouponsVC") as! AppliedCouponsVC
            self.navigationController?.present(Vc, animated: true, completion: nil)
        }
    }
}
