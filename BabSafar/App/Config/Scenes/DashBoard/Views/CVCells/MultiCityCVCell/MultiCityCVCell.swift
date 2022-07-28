//
//  MultiCityCVCell.swift
//  BabSafar
//
//  Created by MA673 on 28/07/22.
//

import UIKit

protocol MultiCityCVCellDelegate {
    func didtapOnSwapCityBtn(cell:MultiCityCVCell)
    func didTapOnDeleteMultiCityTrip(cell:MultiCityCVCell)
}

class MultiCityCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromToView: UIView!
    @IBOutlet weak var departureView: UIView!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var swipeImg: UIImageView!
    @IBOutlet weak var swipeBtn: UIButton!
    @IBOutlet weak var cancelBtnView: UIView!
    @IBOutlet weak var cancelImg: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var fromCityname: UILabel!
    @IBOutlet weak var fromCityCodelbl: UILabel!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var toCityCodelbl: UILabel!
    @IBOutlet weak var departurelbl: UILabel!
    @IBOutlet weak var depratureDatelbl: UILabel!
    
    
    
    var delegate:MultiCityCVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    @objc func didtapOnSwapCityBtn(_ sender:UIButton) {
        delegate?.didtapOnSwapCityBtn(cell: self)
    }
    
    @objc func didTapOnDeleteMultiCityTrip(_ sender:UIButton) {
        delegate?.didTapOnDeleteMultiCityTrip(cell: self)
    }
    
    
    func setupUI() {
        swipeBtn.setTitle("", for: .normal)
        swipeBtn.addTarget(self, action: #selector(didtapOnSwapCityBtn(_:)), for: .touchUpInside)
        cancelBtn.setTitle("", for: .normal)
        cancelBtn.addTarget(self, action: #selector(didTapOnDeleteMultiCityTrip(_:)), for: .touchUpInside)
        
        swipeImg.image = UIImage(named: "multitrip")
        cancelImg.image = UIImage(named: "close")
        
        holderView.backgroundColor = .WhiteColor
        setupViews(v: fromToView, radius: 5, color: HexColor("#FCFCFC"))
        setupViews(v: departureView, radius: 5, color: HexColor("#FCFCFC"))
        
        swipeView.backgroundColor = .clear
        cancelBtnView.backgroundColor = .clear
        
        setupLabels(lbl: fromCityname, text: "Dubai", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: toCityNamelbl, text: "Kuwait", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: fromlbl, text: "From", textcolor: .AppLabelColor, font: .LatoLight(size: 12))
        setupLabels(lbl: fromCityCodelbl, text: "DXB", textcolor: .AppLabelColor, font: .LatoLight(size: 12))
        setupLabels(lbl: tolbl, text: "To", textcolor: .AppLabelColor, font: .LatoLight(size: 12))
        setupLabels(lbl: toCityCodelbl, text: "KWI", textcolor: .AppLabelColor, font: .LatoLight(size: 12))
        setupLabels(lbl: departurelbl, text: "Departure ", textcolor: .AppLabelColor, font: .LatoLight(size: 12))
        setupLabels(lbl: depratureDatelbl, text: "26-07-2022", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14))
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}
