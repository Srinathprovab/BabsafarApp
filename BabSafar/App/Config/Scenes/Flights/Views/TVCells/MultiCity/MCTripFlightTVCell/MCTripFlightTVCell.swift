//
//  MCTripFlightTVCell.swift
//  BabSafar
//
//  Created by FCI on 20/10/22.
//

import UIKit

class MCTripFlightTVCell: UITableViewCell {
    
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityShortlbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noStopslbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityShortlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    @IBOutlet weak var perPersonlbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        kwdPricelbl.isHidden = true
        setupLabels(lbl: fromCityTimelbl, text: "05:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: fromCityShortlbl, text: "dubai (dXB)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: toCityTimelbl, text: "07:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: toCityShortlbl, text: "kuwait (KWI)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: hourslbl, text: "1h 40mis", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: noStopslbl, text: "No Stops", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: kwdPricelbl, text: "KWD:150.00", textcolor: .AppTabSelectColor, font: .LatoSemibold(size: 13))
        setupLabels(lbl: perPersonlbl, text: "Per Person", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}
