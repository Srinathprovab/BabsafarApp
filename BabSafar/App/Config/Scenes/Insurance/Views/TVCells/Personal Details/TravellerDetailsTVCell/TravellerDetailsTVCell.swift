//
//  TravellerDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit

class TravellerDetailsTVCell: TableViewCell {

    
    @IBOutlet weak var totalnooftravellerlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        totalnooftravellerlbl.text = "Total No Of Traveller : \(cellInfo?.title ?? "")"
    }
    
    
    
}
