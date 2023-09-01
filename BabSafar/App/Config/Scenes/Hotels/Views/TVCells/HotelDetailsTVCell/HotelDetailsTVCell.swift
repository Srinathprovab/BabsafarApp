//
//  HotelDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 02/08/22.
//

import UIKit


protocol HotelDetailsTVCellDelegate {
    func didTapOnforMoreInfo(cell:HotelDetailsTVCell)
}

class HotelDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelIconImg: UIImageView!
    @IBOutlet weak var hotelDetailslbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var loclbl: UILabel!
    @IBOutlet weak var checkInlbl: UILabel!
    @IBOutlet weak var checkOutlbl: UILabel!
    @IBOutlet weak var noOfRoomslbl: UILabel!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var formoreInfolbl: UILabel!

    @IBOutlet weak var cancellationlbl: UILabel!
    var delegate:HotelDetailsTVCellDelegate?
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
        loclbl.text = cellInfo?.subTitle
        checkInlbl.attributedText = setAttributedText(str1: "Check In: ", str2: cellInfo?.text ?? "")
        checkOutlbl.attributedText = setAttributedText(str1: "Check Out: ", str2: cellInfo?.tempText ?? "")
        noOfRoomslbl.attributedText = setAttributedText(str1: "Room(s): ", str2: cellInfo?.tempInfo as? String ?? "")
        adultlbl.attributedText = setAttributedText(str1: "Guest(s): ", str2: cellInfo?.buttonTitle ?? "")
        
        self.hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        
        if cellInfo?.key == "booksucess" {
            contentView.backgroundColor = .WhiteColor
            ulView.isHidden = true
            holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        }else {
            contentView.backgroundColor = .AppHolderViewColor
        }
        
        
        cancellationlbl.text = "Cancellation made From \(convertDateFormat(inputDate: prebookingcancellationpolicy?.from_time ?? "", f1: "dd-MM-yyyy HH:mm:ss", f2: "E dd MMM yyyy HH:mm:ss")) (Based on Destination time) would Charge \(prebookingcancellationpolicy?.amount ?? "") \(prebookingcancellationpolicy?.currency ?? "")"
    }
    
    func setupUI() {
        
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        setupViews(v: ulView, radius: 0, color: .AppBorderColor)
        
        hotelIconImg.image = UIImage(named: "hotel")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#00A898"))
        hotelImg.image = UIImage(named: "city")
        hotelImg.contentMode = .scaleToFill
        hotelImg.layer.cornerRadius = 10
        hotelImg.clipsToBounds = true
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        
        setupLabels(lbl: hotelDetailslbl, text: "Hotel details", textcolor: .AppLabelColor, font: .LatoMedium(size: 16))
        setupLabels(lbl: hotelNamelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14))
        setupLabels(lbl: loclbl, text: "", textcolor: .SubTitleColor, font: .LatoLight(size: 12))
        
        setAttributedStringFormoreInfo(str1: "For more information please contact us on the ",
                                       str2: "babsafar.support@johnmenzies.aero")
        
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
    
    
    func setAttributedText(str1:String,str2:String) -> NSAttributedString {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.SubTitleColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 12)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.LatoSemibold(size: 12)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        
        return combination
    }
    
}


extension HotelDetailsTVCell {
    
    
    func setAttributedStringFormoreInfo(str1:String,str2:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:HexColor("#ED1654"),NSAttributedString.Key.font:UIFont.LatoRegular(size: 12)] as [NSAttributedString.Key : Any]
        let atter2 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:HexColor("#ED1654"),
                                                      NSAttributedString.Key.font:UIFont.LatoRegular(size: 12),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue,
                                                      NSAttributedString.Key.underlineColor:HexColor("#ED1654")]
        
       
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        formoreInfolbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        formoreInfolbl.addGestureRecognizer(tapGesture)
        formoreInfolbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("babsafar.support@johnmenzies.aero", in: formoreInfolbl) {
            delegate?.didTapOnforMoreInfo(cell: self)
        }
    }
}
