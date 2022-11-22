//
//  SpecialDealsCVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SpecialDealsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var bookinglbl: UILabel!
    @IBOutlet weak var promoCodelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    func setupUI() {
        
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 12)
        offerImage.layer.cornerRadius = 12
        offerImage.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        offerImage.clipsToBounds = true
        setuplabels(lbl: bookinglbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: promoCodelbl, text: "PROMO CODE:Flat20", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        
    }
    
}
