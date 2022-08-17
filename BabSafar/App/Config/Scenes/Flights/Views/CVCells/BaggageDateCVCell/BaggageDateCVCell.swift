//
//  BaggageDateCVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class BaggageDateCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 3
        holderView.clipsToBounds = true
        
        lineView.backgroundColor = HexColor("#808089")
        
        titlelbl.textColor = HexColor("#808089")
        titlelbl.font = UIFont.LatoRegular(size: 12)
        
        subTitlelbl.textColor = HexColor("#808089")
        subTitlelbl.font = UIFont.LatoRegular(size: 12)
        
    }
    
}
