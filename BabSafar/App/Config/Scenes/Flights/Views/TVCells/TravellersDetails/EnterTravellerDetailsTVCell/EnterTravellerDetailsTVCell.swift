//
//  EnterTravellerDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 01/12/22.
//

import UIKit
import DropDown


protocol EnterTravellerDetailsTVCellDelegate {
    func editingTextField(tf:UITextField)
    func donedatePicker(cell:EnterTravellerDetailsTVCell)
    func cancelDatePicker(cell:EnterTravellerDetailsTVCell)
    
    func selectedTitle(cell:EnterTravellerDetailsTVCell)
}

class EnterTravellerDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var tfHolderView: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var dropImage: UIImageView!
    @IBOutlet weak var countrycodeView: UIView!
    @IBOutlet weak var countrycodeViewWidth: NSLayoutConstraint!
    @IBOutlet weak var countryCodeTF: UITextField!
    
    
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    var mrArray = ["Mr","Mrs","Miss","M"]
    let datePicker = UIDatePicker()
    var nationality:String?
    var nationalitycode = String()
    var issuingCountry:String?
    var issuingCountrycode = String()
    var countryNameArray = [String]()
    var delegate:EnterTravellerDetailsTVCellDelegate?
    var selectedTitle = String()
    
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
        dropImage.image = UIImage(named: cellInfo?.image ?? "")
        txtField.tag = cellInfo?.characterLimit ?? 0
        txtField.placeholder = cellInfo?.buttonTitle
        countrycodeViewWidth.constant = 0
        countrycodeView.isHidden = true
        
        countrylist.forEach { i in
            print(i.name)
            countryNameArray.append(i.name ?? "")
        }
        
        
        
        if cellInfo?.key == "fname" {
            countrycodeViewWidth.constant = 90
            countrycodeView.isHidden = false
            setupTextFiels(tf: countryCodeTF, placeholder: "Mr")
            
            if cellInfo?.key1 == "edit" {
                txtField.text = cellInfo?.text
                countryCodeTF.text = cellInfo?.headerText
            }
            
        }
        
//        else if cellInfo?.key == "dob" {
//            dropView.isHidden = false
//            self.tfHolderView.bringSubviewToFront(dropView)
//            showDatePicker()
//        }
        
        else {
            
        }
        
        
        switch cellInfo?.key1 {
        case "editfname":
            txtField.text = edit_fname
            countryCodeTF.text = cellInfo?.headerText
            break
        case "editlname":
            txtField.text = edit_lname 
            break
        case "editpassportno":
            txtField.text = edit_passportno
            break
        default:
            break
        }
        
    }
    
    
    
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: HexColor("#10002E"), font: .LatoRegular(size: 14), align: .left)
        txtField.addCornerRadiusWithShadow(color: .clear, borderColor: UIColor.lightGray.withAlphaComponent(0.5), cornerRadius: 4)
        countrycodeView.addCornerRadiusWithShadow(color: .clear, borderColor: UIColor.lightGray.withAlphaComponent(0.5), cornerRadius: 4)
        tfHolderView.backgroundColor = .WhiteColor
        countrycodeViewWidth.constant = 0
        countrycodeView.backgroundColor = .WhiteColor
        countrycodeView.isHidden = true
        
        setupTextFiels(tf: txtField, placeholder: cellInfo?.buttonTitle ?? "")
        setupTextFiels(tf: countryCodeTF, placeholder: "+91")
        txtField.addTarget(self, action: #selector(editingTextField(_:)), for: .editingChanged)
        countryCodeTF.addTarget(self, action: #selector(editingChanged1(_:)), for: .editingChanged)
        txtField.delegate = self
        countryCodeTF.delegate = self
        dropView.isHidden = true
    }
    
    
    func setupTextFiels(tf:UITextField,placeholder:String) {
        tf.backgroundColor = .WhiteColor
        tf.setLeftPaddingPoints(15)
        tf.placeholder = placeholder
        tf.font = .poppinsMedium(size: 15)
        tf.isSecureTextEntry = false
    }
    
    
    @objc func editingTextField(_ tf: UITextField){
        delegate?.editingTextField(tf: tf)
    }
    
    
    
    func setupDropDown() {
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countrycodeView
        dropDown.bottomOffset = CGPoint(x: 0, y: countrycodeView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            switch self?.cellInfo?.key {
            case "fname":
                self?.countryCodeTF.text = item
                self?.countryCodeTF.textColor = .AppLabelColor
                self?.countryCodeTF.resignFirstResponder()
                // self?.txtField.becomeFirstResponder()
                self?.selectedTitle = item
                
                self?.delegate?.selectedTitle(cell: self!)
                break
            default:
                break
            }
            
        }
        
        
        
        
    }
    
    
    @objc func editingChanged1(_ tf: UITextField){
        print(tf.text)
        
        if countryCodeTF.text?.isEmpty == true {
            dropDown.hide()
        }else {
            setupDropDown()
            dropDown.dataSource = mrArray
            dropDown.show()
        }
        
    }
    
    
    
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


extension EnterTravellerDetailsTVCell {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool {
        
        let maxLength = 50
        let currentString: NSString = txtField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
