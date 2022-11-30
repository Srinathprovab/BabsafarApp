//
//  TextfieldTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

protocol TextfieldTVCellDelegate {
    func didTapOnForGetPassword(cell:TextfieldTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnShowPasswordBtn(cell:TextfieldTVCell)
    
    func donedatePicker(cell:TextfieldTVCell)
    func cancelDatePicker(cell:TextfieldTVCell)
    
}


class TextfieldTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var textHolderView: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var forgetPwdBtn: UIButton!
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    @IBOutlet weak var showPassView: UIView!
    
    let datePicker = UIDatePicker()
    var delegate:TextfieldTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        txtField.text = cellInfo?.tempText
    }
    
    override func updateUI() {
        btnHeight.constant = 0
        titlelbl.text = cellInfo?.title
        txtField.placeholder = cellInfo?.tempText
        txtField.tag = Int(cellInfo?.text ?? "") ?? 0
      //  txtField.text = ""
        
        switch cellInfo?.key {
       
        case "pwd":
            showPassView.isHidden = false
            self.txtField.isSecureTextEntry = true
            txtField.textContentType = .oneTimeCode
            btnHeight.constant = 30
            forgetPwdBtn.isHidden = false
            break
        case "signuppwd":
            showPassView.isHidden = false
            self.txtField.isSecureTextEntry = true
            txtField.textContentType = .oneTimeCode
            btnHeight.constant = 0
            forgetPwdBtn.isHidden = true
            break
        case "signup":
            //            showPassView.isHidden = true
            self.txtField.isSecureTextEntry = false
            forgetPwdBtn.isHidden = true
            break
        case "cpwd":
            //            showPassView.isHidden = true
            self.txtField.isSecureTextEntry = true
            txtField.textContentType = .oneTimeCode
            forgetPwdBtn.isHidden = true
            textHolderView.layer.borderColor = UIColor.lightGray.cgColor
            break
        case "myacc":
            //            showPassView.isHidden = true
            self.txtField.isSecureTextEntry = true
            txtField.textContentType = .oneTimeCode
            btnHeight.constant = 30
            forgetPwdBtn.isHidden = false
            forgetPwdBtn.setTitle("Change  password", for: .normal)
            
            break
        case "visa":
            self.viewheight.constant = 120
            break
            
        case "profile":
            self.txtField.isSecureTextEntry = false
            forgetPwdBtn.isHidden = true
            txtField.text = cellInfo?.subTitle
            txtField.isUserInteractionEnabled = false
            break
            
            
        case "profiledit":
            self.txtField.isSecureTextEntry = false
            forgetPwdBtn.isHidden = true
            txtField.text = cellInfo?.subTitle
            txtField.isUserInteractionEnabled = true
            break
            
            
            
        case "cal":
            datePicker.maximumDate = Date()
            showDatePicker()
            break
            
            
            
        default:
            break
        }
        
        
        
        if cellInfo?.key1 == "pdob"{
            datePicker.maximumDate = Date()
            showDatePicker()
        }
    }
    
    
    func setupUI() {
        showPassView.isHidden = true
        showPassBtn.setTitle("", for: .normal)
        holderView.backgroundColor = .WhiteColor
        textHolderView.backgroundColor = .WhiteColor
        textHolderView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        textHolderView.layer.borderWidth = 1
        textHolderView.layer.cornerRadius = 4
        textHolderView.clipsToBounds = true
        showImage.image = UIImage(named: "eyeslash")
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 14)
        txtField.delegate = self
        txtField.backgroundColor = .clear
        txtField.setLeftPaddingPoints(20)
        txtField.font = UIFont.ManropeMedium(size: 18)
        txtField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        txtField.isSecureTextEntry = false
        
        forgetPwdBtn.setTitle("Forgot Password?", for: .normal)
        forgetPwdBtn.setTitleColor(.AppTabSelectColor, for: .normal)
        forgetPwdBtn.titleLabel?.font = UIFont.ManropeRegular(size: 16)
        forgetPwdBtn.isHidden = true
    }
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    
    @IBAction func didTapOnForGetPassword(_ sender: Any) {
        delegate?.didTapOnForGetPassword(cell: self)
    }
    
    
    
    @IBAction func didTapOnShowPasswordBtn(_ sender: Any) {
        delegate?.didTapOnShowPasswordBtn(cell: self)
    }
    
    
    
//MARK: - DATE PICKER
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtField.inputAccessoryView = toolbar
        txtField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        txtField.text = formatter.string(from: datePicker.date)
        
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        txtField.text = formatter1.string(from: datePicker.date)
        
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
}


extension TextfieldTVCell {
    
    
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        switch textField.tag {
        case 11://email
            let maxLength = 30
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
            
        case 12://mobile
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
            
        default:
            let maxLength = 50
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
    }
    
    
    
    
}
