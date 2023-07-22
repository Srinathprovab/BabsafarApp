//
//  TitleLabelTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit
protocol TitleLabelTVCellDelegate {
    func didTapOnViewMapBtnAction(cell:TitleLabelTVCell)
}

class TitleLabelTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    @IBOutlet weak var viewMapBtnView: UIView!
    @IBOutlet weak var viewMaplbl: UILabel!
    @IBOutlet weak var viewMapBtn: UIButton!
    
    
    var key = ""
    var delegate:TitleLabelTVCellDelegate?
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
       
        if cellInfo?.key == "hotel" {
            viewMapBtnView.isHidden = false
        }
    }
    
    func setupUI() {
        contentView.backgroundColor = HexColor("#E6E8E7")
        holderView.backgroundColor = HexColor("#E6E8E7")
        setuplabels(lbl: hotelNamelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: locationlbl, text: "", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        locationlbl.numberOfLines = 0
        
        viewMapBtnView.backgroundColor = .red
        viewMapBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 3)
        setuplabels(lbl: viewMaplbl, text: "VIEW MAP", textcolor: .WhiteColor, font: .LatoSemibold(size: 14), align: .center)
        viewMapBtnView.isHidden = true
    }
    
    
    func setupHotelDetails() {
        holderView.backgroundColor = .WhiteColor
        imgWidth.constant = 0
        locImg.isHidden = true
        hotelNamelbl.font = UIFont.LatoMedium(size: 14)
        locationlbl.textColor = HexColor("#5B5B5B")
        locationlbl.font = UIFont.LatoRegular(size: 14)
    }
    
    
    
    @IBAction func didTapOnViewMapBtnAction(_ sender: Any) {
        delegate?.didTapOnViewMapBtnAction(cell: self)
    }
    
}
