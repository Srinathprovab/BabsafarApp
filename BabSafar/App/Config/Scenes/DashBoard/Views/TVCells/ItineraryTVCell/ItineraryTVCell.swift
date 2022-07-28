//
//  ItineraryTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class ItineraryTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airwaysImg1: UIImageView!
    @IBOutlet weak var airwaysImg2: UIImageView!
    @IBOutlet weak var btnRefund: UIButton!
    @IBOutlet weak var title1lbl: UILabel!
    @IBOutlet weak var title2lbl: UILabel!
    @IBOutlet weak var cityToView: UIView!
    @IBOutlet weak var cityTolbl: UILabel!
    @IBOutlet weak var arivalTime: UILabel!
    @IBOutlet weak var arivalDate: UILabel!
    @IBOutlet weak var airportlbl: UILabel!
    @IBOutlet weak var terminal1lbl: UILabel!
    @IBOutlet weak var destTime: UILabel!
    @IBOutlet weak var destDate: UILabel!
    @IBOutlet weak var destlbl: UILabel!
    @IBOutlet weak var destTerminal1lbl: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var arivalTime1: UILabel!
    @IBOutlet weak var arivalDate1: UILabel!
    @IBOutlet weak var airportlbl1: UILabel!
    @IBOutlet weak var terminal1lbl1: UILabel!
    @IBOutlet weak var destTime1: UILabel!
    @IBOutlet weak var destDate1: UILabel!
    @IBOutlet weak var destlbl1: UILabel!
    @IBOutlet weak var destTerminal1lbl1: UILabel!
    @IBOutlet weak var hourImg1: UIImageView!
    @IBOutlet weak var hourImg2: UIImageView!
    @IBOutlet weak var hourlbl1: UILabel!
    @IBOutlet weak var hourlbl2: UILabel!
    
    @IBOutlet weak var hourImg3: UIImageView!
    
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
        
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        airwaysImg1.image = UIImage(named: "airways")
        airwaysImg2.image = UIImage(named: "airways")
        hourImg1.image = UIImage(named: "hour")
        hourImg2.image = UIImage(named: "hour")
        hourImg3.image = UIImage(named: "hour")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        btnRefund.setTitle("", for: .normal)
        btnRefund.setTitleColor(.AppCalenderDateSelectColor, for: .normal)
        btnRefund.titleLabel?.font = UIFont.LatoMedium(size: 14)
        
        setupLabels(lbl: title1lbl, text: "qatar airways (QR10003)", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: title2lbl, text: "qatar airways (QR10003)", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
        setupViews(v: cityToView, radius: 0, color: .AppBorderColor)
        setupLabels(lbl: cityTolbl, text: "dubai to kuwait  ( 2h 25m)", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
        setupViews(v: timeView, radius: 0, color: .AppCalenderDateSelectColor)
        setupLabels(lbl: timelbl, text: "3h 10m layover time ( bahrain)", textcolor: .WhiteColor, font: .LatoRegular(size: 14))
        
        
        setupLabels(lbl: arivalTime, text: "12:55", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: arivalTime1, text: "12:55", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))

        setupLabels(lbl: destTime, text: "12:55", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))

        
        setupLabels(lbl: arivalDate, text: "Mon 26, 2022", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12))
        setupLabels(lbl: arivalDate1, text: "Mon 26, 2022", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12))

        setupLabels(lbl: destDate, text: "Mon 26, 2022", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12))
        
        
        setupLabels(lbl: airportlbl, text: "dubai intl airport", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: airportlbl1, text: "dubai intl airport", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        
        setupLabels(lbl: terminal1lbl, text: "Terminal: 2", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: terminal1lbl1, text: "Terminal: 2", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        
        
        
        setupLabels(lbl: destTime, text: "13:15", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: destDate, text: "mon 26, 2022", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12))
        setupLabels(lbl: destlbl, text: "kuwait ( kWI)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: destTerminal1lbl, text: "Terminal: 6", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        
        setupLabels(lbl: destTime1, text: "17:30", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: destDate1, text: "mon 26, 2022", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12))
        setupLabels(lbl: destlbl1, text: "kuwait ( kWI)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: destTerminal1lbl1, text: "Terminal: 6", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))

        
        
        
        setupLabels(lbl: hourlbl1, text: "1h 20m", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: hourlbl2, text: "1h 20m", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}
