//
//  ViewFlightFromToDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 02/03/23.
//

import UIKit

class ViewFlightFromToDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromtimelbl: UILabel!
    @IBOutlet weak var fromCityShortlbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noStopslbl: UILabel!
    @IBOutlet weak var totimelbl: UILabel!
    @IBOutlet weak var toCityShortlbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var airwaysImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
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
        
        holderView.backgroundColor = .WhiteColor
        lineView.backgroundColor = HexColor("#00A898")
        setuplabels(lbl: fromtimelbl, text: "05:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18), align: .left)
        setuplabels(lbl: fromCityShortlbl, text: "dubai (dXB)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: totimelbl, text: "07:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18), align: .right)
        setuplabels(lbl: toCityShortlbl, text: "kuwait (KWI)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .right)
        setuplabels(lbl: hourslbl, text: "1h 40mis", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: noStopslbl, text: "No Stops", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        
        
        airwaysImg.contentMode = .scaleToFill
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
    }
    
}
