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
    
    
    func didTapOnFromCityBtn(cell:MultiCityCVCell)
    func didTapOnToCityBtn(cell:MultiCityCVCell)
    func didTapOnDateBtn(cell:MultiCityCVCell)
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
    
    
    
    @IBOutlet weak var fromCityBtn: UIButton!
    @IBOutlet weak var toCityBtn: UIButton!
    @IBOutlet weak var dateBtn: UIButton!
    
    
    var delegate:MultiCityCVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func prepareForReuse() {
        cancelBtnView.isHidden = true
        hideViews()
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
        
        cancelBtnView.isHidden = true
        fromCityBtn.setTitle("", for: .normal)
        toCityBtn.setTitle("", for: .normal)
        dateBtn.setTitle("", for: .normal)
        fromCityBtn.addTarget(self, action: #selector(didTapOnFromCityBtn(_:)), for: .touchUpInside)
        toCityBtn.addTarget(self, action: #selector(didTapOnToCityBtn(_:)), for: .touchUpInside)
        dateBtn.addTarget(self, action: #selector(didTapOnDateBtn(_:)), for: .touchUpInside)
        
        hideViews()
        cancelBtnView.isHidden = false
    }
    
    
    
    func hideViews() {
        fromlbl.isHidden = true
        tolbl.isHidden = true
        departurelbl.isHidden = true
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
    
    
    
    @objc func didtapOnSwapCityBtn(_ sender:UIButton) {
        delegate?.didtapOnSwapCityBtn(cell: self)
    }
    
    @objc func didTapOnDeleteMultiCityTrip(_ sender:UIButton) {
        delegate?.didTapOnDeleteMultiCityTrip(cell: self)
    }
    
    
    @objc func didTapOnFromCityBtn(_ sender:UIButton){
        delegate?.didTapOnFromCityBtn(cell: self)
    }
    
    @objc func didTapOnToCityBtn(_ sender:UIButton){
        delegate?.didTapOnToCityBtn(cell: self)
    }
    
    @objc func didTapOnDateBtn(_ sender:UIButton){
        delegate?.didTapOnDateBtn(cell: self)
    }
    
}
