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
    @IBOutlet weak var locImage: UIImageView!
    @IBOutlet weak var cityNamelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.layer.cornerRadius = 4
        holderView.clipsToBounds = true
        cityImage.contentMode = .scaleAspectFill
        
        labelHolderView.backgroundColor = .AppLabelColor.withAlphaComponent(0.5)
        locImage.image = UIImage(named: "loc")
        cityNamelbl.textColor = .WhiteColor
        cityNamelbl.font = UIFont.LatoRegular(size: 16)
    }
    
}
