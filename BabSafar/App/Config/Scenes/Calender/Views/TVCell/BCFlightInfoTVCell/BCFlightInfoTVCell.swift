//
//  BCFlightInfoTVCell.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import UIKit

class BCFlightInfoTVCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var airlineNamelbl: UILabel!
    @IBOutlet weak var flightNolbl: UILabel!
    @IBOutlet weak var fromTimelbl: UILabel!
    @IBOutlet weak var fromCitylbl: UILabel!
    @IBOutlet weak var fromdatelbl: UILabel!
    @IBOutlet weak var durationlbl: UILabel!
    @IBOutlet weak var stopslbl: UILabel!
    @IBOutlet weak var toTimelbl: UILabel!
    @IBOutlet weak var tocitylbl: UILabel!
    @IBOutlet weak var todatelbl: UILabel!
//    @IBOutlet weak var pricelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    
}
