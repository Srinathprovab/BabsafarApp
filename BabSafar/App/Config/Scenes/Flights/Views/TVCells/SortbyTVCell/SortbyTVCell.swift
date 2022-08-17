//
//  SortbyTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

protocol SortbyTVCellDelegate {
    func didTapOnLowtoHighBtn(cell:SortbyTVCell)
    func didTapOnHightoLowBtn(cell:SortbyTVCell)
//    func didTapOnResetSortbyBtn(cell:SortbyTVCell)
}

class SortbyTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var lowtoHighView: UIView!
    @IBOutlet weak var lowtoHighlbl: UILabel!
    @IBOutlet weak var lowtoHighBtn: UIButton!
    @IBOutlet weak var hightoLowView: UIView!
    @IBOutlet weak var hightoLowhlbl: UILabel!
    @IBOutlet weak var hightoLowBtn: UIButton!
    
    
    
    
    var delegate:SortbyTVCellDelegate?
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
        titlelbl.text = cellInfo?.title
//
//
//        if cellInfo?.key == "reset" {
//            resetBtnHeight.constant = 30
//            resetBtn.isHidden = false
//        }else {
//            resetBtnHeight.constant = 0
//            resetBtn.isHidden = true
//        }
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupViews(v: buttonsView, radius: 4, color: .WhiteColor)
        setupViews(v: lowtoHighView, radius: 4, color: .WhiteColor)
        setupViews(v: hightoLowView, radius: 4, color: .WhiteColor)
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoMedium(size: 17))
        setupLabels(lbl: lowtoHighlbl, text: "Low to High", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: hightoLowhlbl, text: "High to Low", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        lowtoHighBtn.setTitle("", for: .normal)
        hightoLowBtn.setTitle("", for: .normal)
//        resetBtn.setTitle("Reset", for: .normal)
//        resetBtn.titleLabel?.font = UIFont.LatoRegular(size: 16)
//        resetBtn.setTitleColor(.AppTabSelectColor, for: .normal)
//
//        resetBtnHeight.constant = 0
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
    
    
    @IBAction func didTapOnLowtoHighBtn(_ sender: Any) {
        delegate?.didTapOnLowtoHighBtn(cell: self)
    }
    
    @IBAction func didTapOnHightoLowBtn(_ sender: Any) {
        delegate?.didTapOnHightoLowBtn(cell: self)
    }
    
    
//    @IBAction func didTapOnResetSortbyBtn(_ sender: Any) {
//        delegate?.didTapOnResetSortbyBtn(cell: self)
//    }
    
    
}
