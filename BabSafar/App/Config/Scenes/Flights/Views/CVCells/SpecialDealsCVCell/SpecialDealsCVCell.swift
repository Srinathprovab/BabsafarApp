//
//  SpecialDealsCVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SpecialDealsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var promoValuelbl: UILabel!
    @IBOutlet weak var promoCodelbl: UILabel!
    @IBOutlet weak var promoCodeCopyBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 8)
        bottomView.backgroundColor = .WhiteColor
        bottomView.layer.cornerRadius = 8
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomView.clipsToBounds = true

        
        
        offerImage.layer.cornerRadius = 8
        offerImage.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        offerImage.clipsToBounds = true
        setuplabels(lbl: promoCodelbl, text: "Promo Code: ", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: promoValuelbl, text: "", textcolor: HexColor("#EC441E"), font: .LatoRegular(size: 14), align: .left)
        promoCodeCopyBtn.setImage(UIImage(named: "promo")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#EC441E")), for: .normal)

    }
    
    
    
    func setAttributedText(str1:String,str2:String)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.SubTitleColor,NSAttributedString.Key.font:UIFont.LatoBold(size: 16)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.IttenarySelectedColor,NSAttributedString.Key.font:UIFont.LatoSemibold(size: 16)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        promoCodelbl.attributedText = combination
        
    }
    
    
    
    
    @IBAction func didTapOnCopyPromoCodeBtnAction(_ sender: Any) {
        
    }
    
}
