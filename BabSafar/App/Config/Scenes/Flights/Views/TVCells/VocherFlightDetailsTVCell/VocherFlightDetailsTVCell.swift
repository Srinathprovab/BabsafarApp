//
//  VocherFlightDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 27/12/22.
//

import UIKit
import SDWebImage
protocol VocherFlightDetailsTVCellDelegate {
    func didTapOnViewVocherBtn(cell:VocherFlightDetailsTVCell)
}


class VocherFlightDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airlinesImg: UIImageView!
    @IBOutlet weak var airlinesNamelbl: UILabel!
    @IBOutlet weak var airlinesCode: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCitylbl: UILabel!
    @IBOutlet weak var fromDatelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCitylbl: UILabel!
    @IBOutlet weak var toDatelbl: UILabel!
    @IBOutlet weak var hourlbl: UILabel!
    @IBOutlet weak var stopslbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var totlePriceTitlelbl: UILabel!
    @IBOutlet weak var vocherBtnView: UIView!
    @IBOutlet weak var vocherBtnViewHeight: NSLayoutConstraint!
    @IBOutlet weak var vocherlbl: UILabel!
    @IBOutlet weak var vocherBtn: UIButton!
    
    
    var vocherUrl = String()
    var delegate:VocherFlightDetailsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        vocherBtnViewHeight.constant = 0
        vocherBtnView.isHidden = true
    }
    
    
    override func updateUI() {
        airlinesNamelbl.text = cellInfo?.airlinesname
        airlinesCode.text = "\(cellInfo?.airlinesCode ?? "")"
        
        fromCityTimelbl.text = cellInfo?.fromTime
        fromCitylbl.text = cellInfo?.fromCity
        fromDatelbl.text = cellInfo?.fromDate
        
        toCityTimelbl.text = cellInfo?.toTime
        toCitylbl.text = cellInfo?.toCity
        toDatelbl.text = cellInfo?.toDate
        
        hourlbl.text = cellInfo?.travelTime
        stopslbl.text = cellInfo?.noosStops
        kwdlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.APICurrencyType) ?? "")\(cellInfo?.price ?? "")"
        
        
        airlinesImg.sd_setImage(with: URL(string: cellInfo?.airlineslogo ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        if cellInfo?.key == "completed" {
            vocherBtnView.isHidden = false
            vocherBtnViewHeight.constant = 20
            vocherUrl = cellInfo?.title ?? ""
        }
    }
    
    
    
    func setupUI() {
        
        holderView.addCornerRadiusWithShadow(color: .lightGray.withAlphaComponent(0.5), borderColor: .black.withAlphaComponent(0.10), cornerRadius: 10)
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: airlinesNamelbl, text: "Qatar Airways", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: airlinesCode, text: "(QR10003)", textcolor: .AppLabelColor, font: .LatoLight(size: 12), align: .left)
        setuplabels(lbl: fromCityTimelbl, text: "05:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        setuplabels(lbl: fromCitylbl, text: "Dubai (dXB)", textcolor: .SubTitleColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: fromDatelbl, text: "Fri 26 jul", textcolor: .SubTitleColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: toCityTimelbl, text: "05:50", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .right)
        setuplabels(lbl: toCitylbl, text: "Dubai (dXB)", textcolor: .SubTitleColor, font: .LatoRegular(size: 12), align: .right)
        setuplabels(lbl: toDatelbl, text: "Fri 26 jul", textcolor: .SubTitleColor, font: .LatoRegular(size: 12), align: .right)
        setuplabels(lbl: hourlbl, text: "1h 40mis", textcolor: .SubTitleColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: stopslbl, text: "no stops", textcolor: .SubTitleColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: kwdlbl, text: "KWD:150.00", textcolor: .AppLabelColor, font: .LatoBold(size: 15), align: .center)
        setuplabels(lbl: totlePriceTitlelbl, text: "Total  price", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        lineView.backgroundColor = HexColor("#00A898")
        
        vocherBtnViewHeight.constant = 0
        vocherBtnView.isHidden = true
        vocherBtnView.backgroundColor = HexColor("#00A898")
        vocherBtn.setTitle("", for: .normal)
        setuplabels(lbl: vocherlbl, text: "View Voucher", textcolor: .WhiteColor, font: .LatoRegular(size: 16), align: .left)
        
        vocherBtnView.layer.cornerRadius = 10
        vocherBtnView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        vocherBtnView.clipsToBounds = true
    }
    
    
    @IBAction func didTapOnViewVocherBtn(_ sender: Any) {
        delegate?.didTapOnViewVocherBtn(cell: self)
    }
    
    
    
}
