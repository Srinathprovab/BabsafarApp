//
//  RegisterUserTVCell.swift
//  BabSafar
//
//  Created by FCI on 26/09/23.
//

import UIKit
import DropDown

protocol RegisterUserTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnCountryCodeBtnAction(cell:RegisterUserTVCell)
}

class RegisterUserTVCell: TableViewCell {
    
    
    @IBOutlet weak var fnameView: BorderedView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameView: BorderedView!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var mobileView: BorderedView!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var emailView: BorderedView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: BorderedView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordShowImg: UIImageView!
    @IBOutlet weak var confPasswordView: BorderedView!
    @IBOutlet weak var confPasswordTF: UITextField!
    @IBOutlet weak var confPasswordshowImg: UIImageView!
    
    
    var maxLength = 8
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [All_country_code_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    
    var nationalityCode = String()
    let dropDown = DropDown()
    var countryNameArray = [String]()
    var isoCountryCode = String()
    var billingCountryName = String()
    
    var isPasswordVisible = false
    var isPasswordVisible1 = false
    var delegate:RegisterUserTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupui()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
    }
    
    
    func setupui() {
        
        setupTF(txtField: fnameTF)
        setupTF(txtField: lnameTF)
        setupTF(txtField: mobileTF)
        setupTF(txtField: emailTF)
        setupTF(txtField: passwordTF)
        setupTF(txtField: confPasswordTF)
        setupTF(txtField: countrycodeTF)
        confPasswordTF.isSecureTextEntry = true
        passwordTF.isSecureTextEntry = true
        
        setupDropDown()
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
    }
    
    func setupTF(txtField:UITextField) {
        txtField.delegate = self
        txtField.backgroundColor = .clear
        txtField.setLeftPaddingPoints(20)
        txtField.font = UIFont.ManropeMedium(size: 16)
        txtField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        txtField.isSecureTextEntry = false
    }
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.mobileView
        dropDown.bottomOffset = CGPoint(x: 0, y: self.mobileView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
           
            self?.countrycodeTF.text = self?.countrycodesArray[index]
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
            self?.countrycodeTF.textColor = .AppLabelColor
            
            
            
            self?.countrycodeTF.text = self?.countrycodesArray[index] ?? ""
            paymobilecountrycode = self?.countrycodesArray[index] ?? ""
            self?.countrycodeTF.resignFirstResponder()
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            
            self?.delegate?.didTapOnCountryCodeBtnAction(cell: self!)
            
        }
    }
    
    @objc func searchTextBegin(textField: UITextField) {
        textField.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown.show()
        
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
    
    
    
    @IBAction func didTapOnShowPasswordBtnAction(_ sender: Any) {
        isPasswordVisible.toggle()
        passwordTF.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "showpass" : "eyeslash"
        passwordShowImg.image = UIImage(named: imageName)
    }
    
    @IBAction func didTapOnShowConfPasswordBtnAction(_ sender: Any) {
        isPasswordVisible1.toggle()
        confPasswordTF.isSecureTextEntry = !isPasswordVisible1
        let imageName = isPasswordVisible1 ? "showpass" : "eyeslash"
        confPasswordshowImg.image = UIImage(named: imageName)    }
    
}



extension RegisterUserTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == mobileTF {
            maxLength = self.billingCountryName.getMobileNumberMaxLength() ?? 8
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
        }else {
            maxLength = 30
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        //  return true
    }
    
    
}
