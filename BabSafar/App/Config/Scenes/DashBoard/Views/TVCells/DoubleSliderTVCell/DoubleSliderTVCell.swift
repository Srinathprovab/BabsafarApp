//
//  DoubleSliderTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
import SwiftRangeSlider

class DoubleSliderTVCell: TableViewCell {

    
    @IBOutlet weak var rangeSlider: RangeSlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
