//
//  RoomDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit
protocol RoomDetailsTVCellDelegate {
    func didTapOnRefundableBtn1(cell:RoomDetailsTVCell)
}

class RoomDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var roomTypelbl: UILabel!
    @IBOutlet weak var roomImg: UIImageView!
    @IBOutlet weak var adultslbl: UILabel!
    @IBOutlet weak var noofRoomslbl: UILabel!
    @IBOutlet weak var freeWifilbl: UILabel!
    @IBOutlet weak var refundableView: UIView!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var refundableBtn: UIButton!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var freeCancellationlbl: UILabel!
    @IBOutlet weak var perNightlbl: UILabel!
    
    var delegate:RoomDetailsTVCell?
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
        
    }
    
    
    func setupUI() {
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        setupViews(v: refundableView, radius: 15, color: HexColor("#D4F3D4"))
        
        radioImg.image = UIImage(named: "radioUnselected")
        radioImg.contentMode = .scaleToFill
        roomImg.image = UIImage(named: "city")
        roomImg.contentMode = .scaleToFill
        
        
        setupLabels(lbl: roomTypelbl, text: "Executive Studio", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: adultslbl, text: "2 Adults", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: noofRoomslbl, text: "No Of Rooms :1", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: freeWifilbl, text: "Free Wifi", textcolor: .SubTitleColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: refundablelbl, text: "Refundable", textcolor: HexColor("#2FA804"), font: .LatoRegular(size: 10))
        setupLabels(lbl: kwdlbl, text: "KWD:150.00", textcolor: .AppTabSelectColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: perNightlbl, text: "Per Night", textcolor: .SubTitleColor, font: .LatoRegular(size: 10))
        setupLabels(lbl: freeCancellationlbl, text: "Free Cancellation", textcolor: .SubTitleColor, font: .LatoRegular(size: 12))
        
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
        delegate?.didTapOnRefundableBtn(self)
    }
    
    
    
}
