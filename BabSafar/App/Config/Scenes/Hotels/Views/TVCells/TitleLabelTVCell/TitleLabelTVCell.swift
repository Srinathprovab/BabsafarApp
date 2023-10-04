//
//  TitleLabelTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit


class TitleLabelTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    
    var formatDesc:Hotel_desc?
    var key = ""
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
        hotelNamelbl.text = cellInfo?.title
        locationlbl.text = cellInfo?.subTitle
       
        
        if cellInfo?.key == "hoteldisc" {
            formatDesc = cellInfo?.moreData as? Hotel_desc
            setupHotelDetails()
            
        }
    }
    
    func setupUI() {
        contentView.backgroundColor = HexColor("#E6E8E7")
        holderView.backgroundColor = HexColor("#E6E8E7")
        setuplabels(lbl: hotelNamelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: locationlbl, text: "", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        locationlbl.numberOfLines = 0
        
       
    }
    
    
    func setupHotelDetails() {
        holderView.backgroundColor = .WhiteColor
        hotelNamelbl.font = UIFont.LatoMedium(size: 14)
        locationlbl.textColor = HexColor("#5B5B5B")
        locationlbl.font = UIFont.LatoRegular(size: 14)
    }
    
    
}
