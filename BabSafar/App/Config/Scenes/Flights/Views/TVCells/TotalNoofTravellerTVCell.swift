//
//  TotalNoofTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 13/07/23.
//

import UIKit

class TotalNoofTravellerTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
