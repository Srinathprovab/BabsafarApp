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
    @IBOutlet weak var airlinelogo: UIImageView!
    @IBOutlet weak var airlineNamelbl: UILabel!
    
    
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
        
        setupLabels(lbl: fromCityTimelbl, text: "05:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: fromCityShortlbl, text: "dubai (dXB)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: toCityTimelbl, text: "07:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: toCityShortlbl, text: "kuwait (KWI)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: hourslbl, text: "1h 40mis", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: noStopslbl, text: "No Stops", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}
