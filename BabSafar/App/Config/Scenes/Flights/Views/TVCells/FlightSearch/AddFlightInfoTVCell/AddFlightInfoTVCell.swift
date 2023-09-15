//
//  AddFlightInfoTVCell.swift
//  BabSafar
//
//  Created by FCI on 12/09/23.
//

import UIKit

class AddFlightInfoTVCell: UITableViewCell {

    @IBOutlet weak var airlinelogo: UIImageView!
    @IBOutlet weak var deplogo: UIImageView!
    @IBOutlet weak var airlinenamelbl: UILabel!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var durationlbl: UILabel!
    @IBOutlet weak var noofStopslbl: UILabel!
    @IBOutlet weak var fromTimelbl: UILabel!
    @IBOutlet weak var fromCitylbl: UILabel!
    @IBOutlet weak var toTimelbl: UILabel!
    @IBOutlet weak var toCitylbl: UILabel!
    @IBOutlet weak var cabinlbl: UILabel!
    @IBOutlet weak var checkinBaggagelbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
