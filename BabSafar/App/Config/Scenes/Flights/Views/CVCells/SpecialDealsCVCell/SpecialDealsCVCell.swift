//
//  SpecialDealsCVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
protocol SpecialDealsCVCellDelegate {
    func didTapOnPromoCodeBtnAction(cell:SpecialDealsCVCell)
}

class SpecialDealsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var bookinglbl: UILabel!
    @IBOutlet weak var underLine: UIView!
    @IBOutlet weak var promoCodeView: UIView!
    @IBOutlet weak var promocodelbl: UILabel!
    @IBOutlet weak var promoCodeImg: UIImageView!
    @IBOutlet weak var promoCodeBtn: UIButton!
    
    
    var delegate:SpecialDealsCVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    func setupUI() {
        
        offerImage.contentMode = .scaleAspectFill
        
        bookinglbl.textColor = .AppLabelColor
        bookinglbl.font = UIFont.LatoRegular(size: 20)
        promoCodeImg.image = UIImage(named: "promo")
        underLine.backgroundColor = HexColor("#A3A3A3")
        promoCodeView.backgroundColor = .WhiteColor
        bookinglbl.numberOfLines = 0
        
        
        promocodelbl.textColor = .AppCalenderDateSelectColor
        promocodelbl.font = UIFont.LatoRegular(size: 14)
    }
    
    
    @IBAction func didTapOnPromoCodeBtnAction(_ sender: Any) {
        // delegate?.didTapOnPromoCodeBtnAction(cell: self)
    }
    
    
}
