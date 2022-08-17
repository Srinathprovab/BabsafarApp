//
//  HotelImagesCVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class HotelImagesCVCell: UICollectionViewCell {

    @IBOutlet weak var hotelImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        hotelImg.layer.cornerRadius = 8
        hotelImg.clipsToBounds = true
        hotelImg.contentMode = .scaleToFill
    }

}
