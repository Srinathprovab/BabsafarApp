//
//  TopCityCVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class TopCityCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var labelHolderView: UIView!
    @IBOutlet weak var cityNamelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        holderView.addCornerRadiusWithShadow(color: .lightGray, borderColor: .clear, cornerRadius: 8)
        holderView.layer.cornerRadius = 8
        holderView.clipsToBounds = true
        
        
        cityImage.contentMode = .scaleToFill
        
        labelHolderView.backgroundColor = .WhiteColor
        setuplabels(lbl: cityNamelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .center)
        
        
    }
    
}
