//
//  ItineraryCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit

class ItineraryCVCell: UICollectionViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: HexColor("#E6E8E7"), borderColor: HexColor("#E6E8E7"), cornerRadius: 15)
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoMedium(size: 12)
    }

}
