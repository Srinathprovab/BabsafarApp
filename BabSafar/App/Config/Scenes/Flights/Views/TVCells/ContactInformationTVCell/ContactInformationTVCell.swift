//
//  ContactInformationTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
protocol ContactInformationTVCellDelegate {
    func didTapOnCountryCodeBtn(cell:ContactInformationTVCell)
    func editingTextField(tf:UITextField)
}

class ContactInformationTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var contactImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var emailTfView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNoView: UIView!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var countryCodeBtn: UIButton!
    
    
    var delegate:ContactInformationTVCellDelegate?
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
        
    }
    
    
    func setupUI() {
        contentView.backgroundColor = .AppBorderColor
        
        contactImg.image = UIImage(named: "contact")?.withRenderingMode(.alwaysOriginal)
        
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        setupViews(v: emailTfView, radius: 4, color: .WhiteColor)
        setupViews(v: mobileNoView, radius: 4, color: .WhiteColor)
        setupViews(v: codeView, radius: 0, color: .WhiteColor)
        
        
        setupLabels(lbl: titlelbl, text: "Contact Information", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: subTitlelbl, text: "E-Ticket will be sent to the registered email address", textcolor: .SubTitleColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: countryCodeLbl, text: "+965", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        
        
        emailTF.placeholder = "Email Address"
        mobileTF.placeholder = "Enter Mobile Number"
        
        emailTfView.layer.borderWidth = 1
        mobileNoView.layer.borderWidth = 1
        
        countryCodeBtn.setTitle("", for: .normal)
        
        emailTF.backgroundColor = .clear
        emailTF.setLeftPaddingPoints(20)
        emailTF.font = UIFont.LatoRegular(size: 12)
        emailTF.tag = 1
        emailTF.delegate = self
        emailTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        
        
        mobileTF.backgroundColor = .clear
        mobileTF.setLeftPaddingPoints(20)
        mobileTF.font = UIFont.LatoRegular(size: 12)
        mobileTF.tag = 2
        mobileTF.delegate = self
        mobileTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func didTapOnCountryCodeBtn(_ sender: Any) {
        delegate?.didTapOnCountryCodeBtn(cell: self)
    }
    
    
}


extension ContactInformationTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == mobileTF {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
