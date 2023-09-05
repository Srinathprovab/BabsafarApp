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
    @IBOutlet weak var specialRequestlbl: UILabel!
    
    
    var str1 = "By selecting to complete this booking I agree to pay the total amount shown, which includes Service Fees (if applicable), and I acknowledge that I have read and accept the "
    var str2 = "Booking Terms and Conditions"
    var str3 = " and "
    var str4 = "Conditions and Privacy Policy"
    var str5 = " \n\nEnsure to check the passport validity requirements of the countries you are visiting prior to completing your booking."
    
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
        titlelbl.numberOfLines = 0
        
        if cellInfo?.key == "explore" {
            titlelbl.font = .LatoSemibold(size: 12)
            specialRequestlbl.isHidden = true
            setAttributedString1(str1: str1,
                                 str2: str2,
                                 str3: str3,
                                 str4: str4,
                                 str5: str5)
        }else {
            specialRequestlbl.isHidden = false
            setAttributedString(str1: "By booking this item, you agree to pay the total amount shown, which includes Service Fees, on the right and to the, ",
                                str2: "User Terms,",
                                str3: " Privacy policy .")
        }
    }
    
    func setupUI() {
        checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
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


extension SpecialRequestTVCell {
    
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
    
    
}





extension SpecialRequestTVCell {
    
    func setAttributedString1(str1:String,str2:String,str3:String,str4:String,str5:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.errorLabelColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 12)] as [NSAttributedString.Key : Any]
        
        
        
        let atter2 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.errorLabelColor,
                                                      NSAttributedString.Key.font:UIFont.LatoRegular(size: 12),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter1)
        let atterStr4 = NSMutableAttributedString(string: str4, attributes: atter2)
        let atterStr5 = NSMutableAttributedString(string: str5, attributes: atter1)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        combination.append(atterStr3)
        combination.append(atterStr4)
        combination.append(atterStr5)
        
        titlelbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped1))
        titlelbl.addGestureRecognizer(tapGesture)
        titlelbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped1(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("Booking Terms and Conditions", in: titlelbl) {
            checkBool = false
            checkTermsAndCondationStatus = true
            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            delegate?.didTapOnTAndCAction(cell: self)
        }else if gesture.didTapAttributedString("Conditions and Privacy Policy", in: titlelbl){
            checkBool = false
            checkTermsAndCondationStatus = true
            checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            delegate?.didTapOnPrivacyPolicyAction(cell: self)
        }
    }
    
    
}
