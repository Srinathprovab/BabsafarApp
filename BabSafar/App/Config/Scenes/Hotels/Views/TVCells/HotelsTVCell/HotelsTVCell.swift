//
//  HotelsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

protocol HotelsTVCellelegate{
    func didTapOnTermsAndConditionBtn(cell: HotelsTVCell)
    func didTapOnBookNowBtnAction(cell: HotelsTVCell)
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
    @IBOutlet weak var termsAndConditionlbl: UILabel!
    @IBOutlet weak var refundableBtn: UIButton!
    @IBOutlet weak var faretypelbl: UILabel!
    @IBOutlet weak var markupPricelbl: UILabel!
    
    
    var bookingsource = String()
    var hotelid = String()
    var searchid = String()
    var lat = String()
    var long = String()
    var hotelDesc :Hotel_desc?
    var facilityArray = [HFacility]()
    var hotelDescLabel = String()
    var delegate:HotelsTVCellelegate?
    var completeDescription = ""
    
    
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
        hotelNamelbl.text = cellInfo?.title ?? ""
        self.hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        ratingslbl.text = cellInfo?.subTitle
        locationlbl.text = cellInfo?.buttonTitle
        kwdlbl.text = cellInfo?.text
        
        
        setAttributedString1(str1: "\(cellInfo?.text ?? ""):", str2: "\(cellInfo?.price ?? "")")
    }
    
    
    func setupUI() {
        
        
        hotelImg.image = UIImage(named: "city")
        hotelImg.layer.cornerRadius = 8
        hotelImg.clipsToBounds = true
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    
    
    
    @IBAction func didTapOnTermsAndConditionBtn(_ sender: Any) {
        
        
        if let meals = hotelDesc?.meals {
            completeDescription += "Meals: \(meals)\n\n"
        }
        if let rooms = hotelDesc?.rooms {
            completeDescription += "Rooms: \(rooms)\n\n"
        }
        if let payment = hotelDesc?.payment {
            completeDescription += "Payment: \(payment)\n\n"
        }
        if let location = hotelDesc?.location {
            completeDescription += "Location: \(location)\n\n"
        }
        if let facilities = hotelDesc?.facilities {
            completeDescription += "Facilities: \(facilities)\n\n"
        }
        
        if let sportsEntertainment = hotelDesc?.sportsEntertainment {
            completeDescription += "Sports Entertainment : \(sportsEntertainment)\n\n"
        }
        
        hotelDescLabel  = completeDescription
        
        delegate?.didTapOnTermsAndConditionBtn(cell: self)
    }
    
    
    
    
    func setAttributedString1(str1:String,str2:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 10),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 14),NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        
        markupPricelbl.attributedText = combination
        
    }
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        delegate?.didTapOnBookNowBtnAction(cell: self)
    }
    
}

