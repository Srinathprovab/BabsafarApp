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
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    
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
        
    }
    
    func setupUI() {
        contentView.backgroundColor = .AppBorderColor
        holderView.backgroundColor = .AppBorderColor
        setupLabels(lbl: hotelNamelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: locationlbl, text: "", textcolor: .SubTitleColor, font: .LatoRegular(size: 12))
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        locationlbl.numberOfLines = 0
        
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    func setupHotelDetails() {
        holderView.backgroundColor = .WhiteColor
        imgWidth.constant = 0
        locImg.isHidden = true
        hotelNamelbl.font = UIFont.LatoMedium(size: 14)
        locationlbl.textColor = HexColor("#5B5B5B")
        locationlbl.font = UIFont.LatoRegular(size: 14)
    }
    
}
