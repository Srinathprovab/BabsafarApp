//
//  BookingConfirmedTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookingConfirmedTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var bclbl: UILabel!
    @IBOutlet weak var congratulationslbl: UILabel!
    @IBOutlet weak var bookingIDlbl: UILabel!
    @IBOutlet weak var bookingReflbl: UILabel!
    @IBOutlet weak var bookingDatelbl: UILabel!
    @IBOutlet weak var pnrNolbl: UILabel!
    
    
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
        
        bclbl.text = cellInfo?.title
        switch cellInfo?.key {
        case "visa":
            bookingIDlbl.text = ""
            pnrNolbl.text = ""
            bookingReflbl.text = ""
            break
            
        case "booksucess":
            pnrNolbl.text = ""
            pnrNolbl.isHidden = true
            break
        default:
            break
        }
    }
    
    func setupUI() {
        setupViews(v: holderView, radius: 10, color: HexColor("#EDF7ED"))
        checkImg.image = UIImage(named: "bc")?.withRenderingMode(.alwaysOriginal)
        
        setupLabels(lbl: bclbl, text: "Booking Confirmed", textcolor: HexColor("#4AA449"), font: .LatoSemibold(size: 22))
        setupLabels(lbl: congratulationslbl, text: "Congratulations! your e-tickets  are successfuly booked.", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: bookingIDlbl, text: "Booking id: 2548791", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14))
        setupLabels(lbl: bookingDatelbl, text: "Booking Reference: HB14-25474-4975487", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14))
        setupLabels(lbl: bookingReflbl, text: "Booking Date: 26-07-2022", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14))
        setupLabels(lbl: pnrNolbl, text: "PNR No: MSD589", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}
