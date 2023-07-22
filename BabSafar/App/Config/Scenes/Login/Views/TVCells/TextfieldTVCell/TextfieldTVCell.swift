//
//  TextfieldTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
import DropDown

protocol TextfieldTVCellDelegate {
    func didTapOnForGetPassword(cell:TextfieldTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnShowPasswordBtn(cell:TextfieldTVCell)
    func donedatePicker(cell:TextfieldTVCell)
    func cancelDatePicker(cell:TextfieldTVCell)
    func textFieldText(cell: TextfieldTVCell, text: String)
    func didTapOnCountryCodeBtn(cell:TextfieldTVCell)
    
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
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var countryCodelbl: UILabel!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var countryCodeBtnWidth: NSLayoutConstraint!
    
    
    let datePicker = UIDatePicker()
    var delegate:TextfieldTVCellDelegate?
    var countryNameArray = [String]()
    let dropDown = DropDown()
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
        
        txtField.text = cellInfo?.subTitle
        countryCodeView.isHidden = true
        countryCodeBtnWidth.constant = 0
        dropDown.hide()
      //  datePicker.isHidden = true
        
    }
    
    
    override func updateUI() {
        btnHeight.constant = 0
        titlelbl.text = cellInfo?.title
        txtField.placeholder = cellInfo?.tempText
        txtField.tag = Int(cellInfo?.text ?? "") ?? 0
        
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
            showPassView.isHidden = true
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
            
            
        case "mobile":
            self.viewheight.constant = 120
            countryCodeView.isHidden = false
            countryCodeBtnWidth.constant = 100
            
            countrylist.forEach { i in
                countryNameArray.append(i.name ?? "")
            }
            
            dropDown.isHidden = false
            dropDown.dataSource = countryNameArray
            setupDropDown()
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
            datePicker.minimumDate = Date()  //set the current date/time as a minimum
            datePicker.date = Date()
            showDatePicker()
            break
            
            
            
        case "dateof":
            datePicker.isHidden = false
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
    
    
    
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeView
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countryCodelbl.text = item
            self?.countryCodelbl.textColor = .AppLabelColor
            self?.delegate?.didTapOnCountryCodeBtn(cell: self!)
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
        
        countryCodeBtnWidth.constant = 0
        countryCodeView.isHidden = true
        countryCodeView.backgroundColor = .WhiteColor
        countryCodeView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 0)
        setuplabels(lbl: countryCodelbl, text: "+91", textcolor: .SubTitleColor, font: .LatoSemibold(size: 16), align: .center)
        countryCodeBtn.setTitle("", for: .normal)
        countryCodeBtn.addTarget(self, action: #selector(didTapOnCountryCodeBtnAction(_:)), for: .touchUpInside)
    }
    
    
    
    @objc func didTapOnCountryCodeBtnAction(_ sender:UIButton) {
        dropDown.show()
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
        formatter.dateFormat = "dd-MM-yyyy"
        txtField.text = formatter.string(from: datePicker.date)
        
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
}


extension TextfieldTVCell {
    
    
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //        let result = (txtField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        //        delegate?.textFieldText(cell: self, text: result)
        
        
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
