//
//  SpecialDealsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class SpecialDealsTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleLblView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dealsHolderView: UIView!
    @IBOutlet weak var bookingHolderView: UIView!
    @IBOutlet weak var specialDealsCV: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        
        contentView.backgroundColor = .AppBorderColor
        holderView.backgroundColor = .clear
        titleLblView.backgroundColor = .WhiteColor
        dealsHolderView.backgroundColor = .WhiteColor
        
        
        bookingHolderView.backgroundColor = .WhiteColor
        bookingHolderView.layer.cornerRadius = 4
        bookingHolderView.clipsToBounds = true
        bookingHolderView.layer.borderWidth = 1
        bookingHolderView.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        setuplabels(lbl: titlelbl, text: "Special Deals For You", textcolor: .AppLabelColor, font: .LatoSemibold(size: 20), align: .left)
        
    }
    
    
    func setupCV() {
        let nib = UINib(nibName: "SpecialDealsCVCell", bundle: nil)
        specialDealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        specialDealsCV.delegate = self
        specialDealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 360, height: 199)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        specialDealsCV.collectionViewLayout = layout
        specialDealsCV.backgroundColor = .clear
        specialDealsCV.layer.cornerRadius = 4
        specialDealsCV.clipsToBounds = true
        specialDealsCV.showsHorizontalScrollIndicator = false
    }
    
}



extension SpecialDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SpecialDealsCVCell {
            cell.offerImage.image = UIImage(named: "offer")
            cell.bookinglbl.text = "First booking international flight  25% off"
            cell.promoCodelbl.text = "PROMOCODE:FLAT20"
            commonCell = cell
        }
        return commonCell
    }
    
}
