//
//  SpecialRequestTVCell.swift
//  BabSafar
//
//  Created by FCI on 01/09/23.
//

import UIKit


protocol SpecialRequestTVCellDelegate {
    func didTapOnTAndCAction(cell:SpecialRequestTVCell)
    func didTapOnPrivacyPolicyAction(cell:SpecialRequestTVCell)
    
}

class SpecialRequestTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    
    var checkBool = true
    var delegate: SpecialRequestTVCellDelegate?
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
        titlelbl.text = cellInfo?.title ?? ""
        setAttributedString(str1: "By booking this item, you agree to pay the total amount shown, which includes Service Fees, on the right and to the, ", str2: "User Terms,", str3: " Privacy policy .")
        
        titlelbl.numberOfLines = 0
    }
    
    func setupUI() {
        checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func setAttributedString(str1:String,str2:String,str3:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:HexColor("#ED1654"),NSAttributedString.Key.font:UIFont.LatoRegular(size: 12)] as [NSAttributedString.Key : Any]
        let atter2 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,
                      NSAttributedString.Key.font:UIFont.LatoRegular(size: 12),
                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let atter3 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,
                      NSAttributedString.Key.font:UIFont.LatoRegular(size: 12),
                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter3)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        combination.append(atterStr3)
        
        titlelbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        titlelbl.addGestureRecognizer(tapGesture)
        titlelbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("User Terms,", in: titlelbl) {
            checkBool = false
            checkTermsAndCondationStatus = true
            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            delegate?.didTapOnTAndCAction(cell: self)
        }else if gesture.didTapAttributedString(" Privacy policy .", in: titlelbl){
            checkBool = false
            checkTermsAndCondationStatus = true
            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            delegate?.didTapOnPrivacyPolicyAction(cell: self)
        }
    }
    
    
    @IBAction func didTapOnCheckTCBtnAction(_ sender: Any) {
        if checkBool == true {
            checkTermsAndCondationStatus = true
            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            checkBool = false
        }else {
            checkTermsAndCondationStatus = false
            checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            checkBool = true
        }
    }
    
    
    
    
    
    
}
