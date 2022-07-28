//
//  SearchFlightResultTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
protocol SearchFlightResultTVCellDelegate {
    func didTapOnViewVoucherBtn(cell:SearchFlightResultTVCell)
}

class SearchFlightResultTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airwaysLogoImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityShortlbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noStopslbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityShortlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    @IBOutlet weak var perPersonlbl: UILabel!
    @IBOutlet weak var imagesHolderView: UIView!
    @IBOutlet weak var wifiImg: UIImageView!
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var plugImg: UIImageView!
    @IBOutlet weak var bagImg: UIImageView!
    @IBOutlet weak var bagWeightlbl: UILabel!
    @IBOutlet weak var suitCaseImg: UIImageView!
    @IBOutlet weak var suitcaseWeightlbl: UILabel!
    @IBOutlet weak var imagesHolderHeight: NSLayoutConstraint!
    @IBOutlet weak var fromDaylbl: UILabel!
    @IBOutlet weak var toDaylbl: UILabel!
    @IBOutlet weak var viewVoucherBtn: UIButton!
    @IBOutlet weak var imagesHolder1: UIStackView!
    @IBOutlet weak var imagesHolder2: UIStackView!
    
    
    var delegate:SearchFlightResultTVCellDelegate?
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
        switch cellInfo?.key {
        case "booked":
            shadowView(yourView: holderView)
            imagesHolderHeight.constant = 0
            imagesHolderView.isHidden = true
            fromDaylbl.isHidden = false
            toDaylbl.isHidden = false
            fromDaylbl.text = cellInfo?.text
            toDaylbl.text = cellInfo?.tempText
            
            fromCityShortlbl.textColor = HexColor("#808089")
            toCityShortlbl.textColor = HexColor("#808089")
            toCityShortlbl.textColor = HexColor("#808089")
            hourslbl.textColor = HexColor("#808089")
            noStopslbl.textColor = HexColor("#808089")
            perPersonlbl.textColor = HexColor("#808089")
            
            break
            
        case "mybooking":
            viewVoucherBtn.isHidden = false
            imagesHolder1.isHidden = true
            imagesHolder2.isHidden = true
            break
        default:
            break
        }
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        holderView.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        holderView.layer.borderWidth = 1
        
        airwaysLogoImg.image = UIImage(named: "airways")
        setupLabels(lbl: titlelbl, text: "Qatar Airways (QR10003)", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: fromCityTimelbl, text: "05:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: fromCityShortlbl, text: "dubai (dXB)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: toCityTimelbl, text: "07:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: toCityShortlbl, text: "kuwait (KWI)", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: hourslbl, text: "1h 40mis", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: noStopslbl, text: "No Stops", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: kwdPricelbl, text: "KWD:150.00", textcolor: .AppTabSelectColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: perPersonlbl, text: "Per Person", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        
        setupLabels(lbl: fromDaylbl, text: "", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12))
        setupLabels(lbl: toDaylbl, text: "", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12))
        
        imagesHolderHeight.constant = 25
        imagesHolderView.isHidden = false
        imagesHolderView.backgroundColor = .AppCalenderDateSelectColor
        wifiImg.image = UIImage(named: "wifi")
        foodImg.image = UIImage(named: "food")
        bagImg.image = UIImage(named: "bag")
        suitCaseImg.image = UIImage(named: "suit")
        plugImg.image = UIImage(named: "plug")
        radioImg.image = UIImage(named: "radio")
        
        setupLabels(lbl: suitcaseWeightlbl, text: "7 kg", textcolor: .WhiteColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: bagWeightlbl, text: "25 kg", textcolor: .WhiteColor, font: .LatoRegular(size: 12))
        
        hourslbl.addBottomBorderWithColor(color: .AppCalenderDateSelectColor, width: 1)
        
        fromDaylbl.isHidden = true
        toDaylbl.isHidden = true
        viewVoucherBtn.isHidden = true
        viewVoucherBtn.setTitle("View Voucher", for: .normal)
        viewVoucherBtn.setTitleColor(.WhiteColor, for: .normal)
        viewVoucherBtn.titleLabel?.font = UIFont.LatoRegular(size: 16)
        
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
    
    func shadowView(yourView:UIView){
        yourView.layer.borderWidth = 1
        yourView.layer.borderColor = UIColor.AppBorderColor.cgColor
        yourView.layer.shadowColor = UIColor.gray.cgColor
        yourView.layer.shadowOpacity = 0.3
        yourView.layer.shadowOffset = CGSize.zero
        yourView.layer.shadowRadius = 6
    }
    
    @IBAction func didTapOnViewVoucherBtn(_ sender: Any) {
        delegate?.didTapOnViewVoucherBtn(cell: self)
    }
}
