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
    @IBOutlet weak var title1lbl: UILabel!
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
    @IBOutlet weak var hourImg1: UIImageView!
    @IBOutlet weak var hourlbl1: UILabel!
    @IBOutlet weak var hourImg3: UIImageView!
    
    
    @IBOutlet weak var deplbl: UILabel!
    @IBOutlet weak var flightImg: UIImageView!
    @IBOutlet weak var economylbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        cityTolbl.text = cellInfo?.title
    }
    
    
    func setupUI() {
        
        //   setupViews(v: holderView, radius: 5, color: .WhiteColor)
        holderView.backgroundColor = .WhiteColor
        airwaysImg1.image = UIImage(named: "airways")
        hourImg1.image = UIImage(named: "hour")
        hourImg3.image = UIImage(named: "hour")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
     
        
        setuplabels(lbl: title1lbl, text: "qatar airways (QR10003)", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setupViews(v: cityToView, radius: 0, color: .AppBorderColor)
        setuplabels(lbl: cityTolbl, text: "dubai to kuwait  ( 2h 25m)", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setupViews(v: timeView, radius: 0, color: .AppCalenderDateSelectColor)
        setuplabels(lbl: timelbl, text: "3h 10m layover time ( bahrain)", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: arivalTime, text: "12:55", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18), align: .left)
        setuplabels(lbl: destTime, text: "12:55", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18), align: .right)
        setuplabels(lbl: arivalDate, text: "Mon 26, 2022", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: destDate, text: "Mon 26, 2022", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12), align: .right)
        setuplabels(lbl: airportlbl, text: "dubai intl airport", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: terminal1lbl, text: "Terminal: 2", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: destTime, text: "13:15", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18), align: .right)
        setuplabels(lbl: destDate, text: "mon 26, 2022", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12), align: .right)
        setuplabels(lbl: destlbl, text: "kuwait ( kWI)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .right)
        setuplabels(lbl: destTerminal1lbl, text: "Terminal: 6", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .right)
        setuplabels(lbl: hourlbl1, text: "1h 20m", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: economylbl, text: "1h 20m", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        
        setuplabels(lbl: deplbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)

        airportlbl.numberOfLines = 2
        destlbl.numberOfLines = 2
        cityToView.backgroundColor = .clear
        cityToView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 0)
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
}
