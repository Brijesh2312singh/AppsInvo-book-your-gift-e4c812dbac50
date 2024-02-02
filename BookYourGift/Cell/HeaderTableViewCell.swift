//
//  HeaderTableViewCell.swift
//  BookYourGift
//
//  Created by Apple on 26/07/23.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var catCallection: UICollectionView!
    @IBOutlet weak var catCallectionHeight: NSLayoutConstraint!
    
    var sheepTypeArr = [[String: String]]()
        var getNavigationController = UINavigationController()
        var viewControllerr = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.catCallection.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    func setCollectionViewDataSourceDelegate(forArray sheepList: [[String: String]], navigationCLR : UINavigationController, viewCR: UIViewController) {
        self.catCallection.register(UINib(nibName: "SellerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SellerCollectionViewCell")
        catCallection.delegate = self
        catCallection.dataSource = self
        self.sheepTypeArr.removeAll()
        self.sheepTypeArr = sheepList
        self.getNavigationController = navigationCLR
        self.viewControllerr = viewCR
        catCallection.reloadData()
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if let obj = object as? UICollectionView {
                if obj == self.catCallection && keyPath == "contentSize" {
                    catCallectionHeight.constant = catCallection.contentSize.height
                }
            }
        }

}



extension HeaderTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = catCallection.dequeueReusableCell(withReuseIdentifier: "SellerCollectionViewCell", for: indexPath) as! SellerCollectionViewCell
        
        return cell
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (catCallection.bounds.width/2)-5
        return CGSize(width: size, height: 260)
        //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        //        let size = (catCallection.bounds.width/2) - 10
        //        return CGSize(width: size, height: 500)
        //    }
    }
}
