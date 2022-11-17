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
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.layer.cornerRadius = 4
        holderView.clipsToBounds = true
        cityImage.contentMode = .scaleAspectFill
        
        labelHolderView.backgroundColor = .AppLabelColor.withAlphaComponent(0.3)
        setuplabels(lbl: cityNamelbl, text: "", textcolor: .WhiteColor, font: .LatoRegular(size: 16), align: .center)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .WhiteColor, font: .LatoRegular(size: 12), align: .center)
        subtitlelbl.isHidden = true
        
    }
    
}
