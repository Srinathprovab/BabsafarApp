//
//  HotelDesclblTVCell.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import UIKit

class HotelDesclblTVCell: TableViewCell {

    @IBOutlet weak var titlelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
    }
    
}
