//
//  SendUsMessageTVCell.swift
//  BabSafar
//
//  Created by FCI on 18/02/23.
//

import UIKit

protocol SendUsMessageTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnSubmitBtn(cell:SendUsMessageTVCell)
    func didTapOnCountryCodeSelectBtn(cell:SendUsMessageTVCell)
    func textViewDidChange(textView:UITextView)
    
}

class SendUsMessageTVCell: TableViewCell, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phonelbl: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var countryCodelbl: UILabel!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var messagelbl: UILabel!
    @IBOutlet weak var desView: UITextView!
    @IBOutlet weak var submitBtnView: UIView!
    @IBOutlet weak var submitBtnlbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    
    var countrycode = String()
    var placeHolder = String()
    var countryCodePicker: UIPickerView!
    var delegate:SendUsMessageTVCellDelegate?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 10)
        setuplabels(lbl: titlelbl, text: "Send Us A Message", textcolor: HexColor("#64276F"), font: .LatoSemibold(size: 16), align: .center)
        setuplabels(lbl: namelbl, text: "Name", textcolor: HexColor("#10002E"), font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: emaillbl, text: "Email", textcolor: HexColor("#10002E"), font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: phonelbl, text: "Phone", textcolor: HexColor("#10002E"), font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: countryCodelbl, text: "Country Code", textcolor: HexColor("#10002E"), font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: submitBtnlbl, text: "Submit", textcolor: .WhiteColor, font: .LatoMedium(size: 14), align: .center)
        setuplabels(lbl: messagelbl, text: "Message", textcolor: HexColor("#10002E"), font: .LatoRegular(size: 12), align: .left)
        
        submitBtnView.backgroundColor = HexColor("#64276F")
        submitBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        submitBtn.setTitle("", for: .normal)
        submitBtn.addTarget(self, action: #selector(didTapOnSubmitBtn(_:)), for: .touchUpInside)
        
        setupTF(tf: nameTF, placeholder: "Name", tag: 1)
        setupTF(tf: emailTF, placeholder: "Email", tag: 2)
        setupTF(tf: phoneTF, placeholder: "Phone No", tag: 3)
        setupTF(tf: countryCodeTF, placeholder: "Country Code", tag: 4)
        setupdescView()
        
        
        countryCodePicker = UIPickerView()
        countryCodePicker.dataSource = self
        countryCodePicker.delegate = self
        countryCodeTF.inputView = countryCodePicker
        //  countryCodeTF.text = countrylist[0].country_code
        
        
    }
    
    func setupdescView() {
        desView.text = ""
        desView.delegate = self
        desView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        desView.setPlaceholder(ph: placeHolder)
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
        delegate?.textViewDidChange(textView: textView)
    }
    
    
    func setupTF(tf:UITextField,placeholder:String,tag:Int) {
        tf.backgroundColor = .clear
        tf.placeholder = placeholder
        tf.setLeftPaddingPoints(15)
        tf.setRightPaddingPoints(15)
        tf.delegate = self
        tf.font = UIFont.LatoSemibold(size: 14)
        tf.tag = tag
        tf.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        tf.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
    }
    
    
    @objc func editingTextField(_ tf:UITextField) {
        delegate?.editingTextField(tf: tf)
    }
    
    
    @objc func didTapOnSubmitBtn(_ sender:UIButton) {
        delegate?.didTapOnSubmitBtn(cell: self)
    }
    
    
    
    //MARK: - Pickerview method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countrylist.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(countrylist[row].name ?? "")   \(countrylist[row].country_code ?? "")"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.countryCodeTF.text = countrylist[row].name ?? ""
        countrycode = countrylist[row].country_code ?? ""
        print("rowwwwww === >  \(row)")
        delegate?.didTapOnCountryCodeSelectBtn(cell: self)
    }
    
}



extension SendUsMessageTVCell {
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField.tag {
        case 2://email
            let maxLength = 30
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
            
        case 3://mobile
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
