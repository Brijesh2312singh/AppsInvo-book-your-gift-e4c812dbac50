//
//  ProductsReviewVC.swift
//  BookYourGift
//
//  Created by Apple on 01/08/23.
//

import UIKit

class ProductsReviewVC: UIViewController {

    @IBOutlet weak var reviewCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewCollectionView.register(UINib(nibName: "SellerCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SellerCollectionViewCell")
        
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self

    }
    

    @IBAction func ViewAllBtn(_ sender: UIButton) {
    }
    

}
extension ProductsReviewVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.reviewCollectionView {
            let cell1 = reviewCollectionView.dequeueReusableCell(withReuseIdentifier: "SellerCollectionViewCell", for: indexPath) as! SellerCollectionViewCell
            cell1.sellerView.layer.cornerRadius = 10
            return cell1
       
            
        }
        return UICollectionViewCell()
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let size = (reviewCollectionView.frame.size.width/2) - 10
                return CGSize(width: size, height:350)
            }
         
        
        }
    
    
