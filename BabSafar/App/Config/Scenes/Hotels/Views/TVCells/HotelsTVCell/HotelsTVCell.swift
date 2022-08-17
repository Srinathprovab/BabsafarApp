//
//  HotelsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

protocol HotelsTVCellelegate{
    func didTapOnRefundableBtn(cell: HotelsTVCell)
}

class HotelsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var ratingsView: UIView!
    @IBOutlet weak var ratingslbl: UILabel!
    
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var perNightlbl: UILabel!
    @IBOutlet weak var refundableView: UIView!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var refundableBtn: UIButton!
    
    
    var delegate:HotelsTVCellelegate?
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
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        setupViews(v: ratingsView, radius: 4, color: HexColor("#2FA804"))
        ratingsView.layer.borderColor = HexColor("#2FA804").cgColor
        setupViews(v: refundableView, radius: 10, color: HexColor("#D4F3D4"))
        ratingsView.layer.borderColor = HexColor("#D4F3D4").cgColor
        
        hotelImg.image = UIImage(named: "city")
        hotelImg.layer.cornerRadius = 8
        hotelImg.clipsToBounds = true
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        
        setupLabels(lbl: hotelNamelbl, text: "Majestic City Retreat Hotel", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: ratingslbl, text: "4.1", textcolor: .WhiteColor, font: .LatoMedium(size: 12))
        setupLabels(lbl: locationlbl, text: "Bur Dubai, Dubai | 700 m from Al Fahidi Metro Station", textcolor: .SubTitleColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: kwdlbl, text: "KWD:150.00", textcolor: .AppTabSelectColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: perNightlbl, text: "per night", textcolor: .SubTitleColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: refundablelbl, text: "Refundable", textcolor: HexColor("#2FA804"), font: .LatoRegular(size: 12))
        
        refundableBtn.setTitle("", for: .normal)
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    @IBAction func didTapOnRefundableBtn(_ sender: Any) {
        delegate?.didTapOnRefundableBtn(cell: self)
    }
    
    
    
}
