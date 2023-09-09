//
//  FromLeadPassengerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/09/23.
//

import UIKit
import DropDown


protocol  FromLeadPassengerTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnAdultBtnAction(cell:FromLeadPassengerTVCell)
    func didTapOnChildBtnAction(cell:FromLeadPassengerTVCell)
    func donedatePicker(cell:FromLeadPassengerTVCell)
    func cancelDatePicker(cell:FromLeadPassengerTVCell)
    func doneTimePicker(cell:FromLeadPassengerTVCell)
    func cancelTimePicker(cell:FromLeadPassengerTVCell)
    func didTapOnTerminalBtnAction(cell:FromLeadPassengerTVCell)
    func didTapOnCountryCodeBtn(cell:FromLeadPassengerTVCell)

    
}

class FromLeadPassengerTVCell: TableViewCell {
    
    @IBOutlet weak var fullnameTF: UITextField!
    @IBOutlet weak var terminalTF: UITextField!
    @IBOutlet weak var flightnoTF: UITextField!
    @IBOutlet weak var depDateTF: UITextField!
    @IBOutlet weak var depTimeTF: UITextField!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var adultView: BorderedView!
    @IBOutlet weak var childView: BorderedView!
    @IBOutlet weak var terminalView: BorderedView!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var countryCodeView: UIView!

    
    var maxLength = 8
    var filterdcountrylist = [All_country_code_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    let dropDown = DropDown()
    
    var countryNameArray = [String]()
    var isoCountryCode = String()
    var billingCountryName = String()
    var nationalityCode = String()
    
    let depTimePicker = UIDatePicker()
    let depDatePicker = UIDatePicker()
    var adultDropdown = DropDown()
    var childDropdown = DropDown()
    var terminalDropdown = DropDown()
    var delegate:FromLeadPassengerTVCellDelegate?
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
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
        
    }

    
    
    func setupUI() {
        setuptf(tf: fullnameTF, tag1: 111, leftpadding: 10, font: .LatoRegular(size: 12))
        setuptf(tf: terminalTF, tag1: 222, leftpadding: 10, font: .LatoRegular(size: 12))
        setuptf(tf: flightnoTF, tag1: 333, leftpadding: 10, font: .LatoRegular(size: 12))
        setuptf(tf: depDateTF, tag1: 4, leftpadding: 10, font: .LatoRegular(size: 12))
        setuptf(tf: depTimeTF, tag1: 5, leftpadding: 10, font: .LatoRegular(size: 12))
        
        setuptf(tf: mobileTF, tag1: 444, leftpadding: 20, font: .LatoRegular(size: 16))
        setuptf(tf: countryCodeTF, tag1: 555, leftpadding: 20, font: .LatoRegular(size: 16))
        countryCodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        
        
        setupAdultDropDown()
        setupChildDropDown()
        setupTerminalDropDown()
        showdebDatePicker()
        showdepTimePicker()
        setupDropDown()
        
    }
    
    
    func setuptf(tf:UITextField,tag1:Int,leftpadding:Int,font:UIFont){
        tf.backgroundColor = .clear
        tf.setLeftPaddingPoints(CGFloat(leftpadding))
        tf.font = font
        tf.tag = tag1
        tf.delegate = self
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    @objc func editingText(textField:UITextField) {
    
            if textField == mobileTF {
                if let text = textField.text {
                    let length = text.count
                    if length != maxLength {
                        mobilenoMaxLengthBool = false
                    }else{
                        mobilenoMaxLengthBool = true
                    }
                   
                } else {
                    mobilenoMaxLengthBool = false
                }
            }
            
           
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    
    @IBAction func didTapOnAdultBtnAction(_ sender: Any) {
        adultDropdown.show()
    }
    
    
    
    
    @IBAction func didTapOnChildBtnAction(_ sender: Any) {
        childDropdown.show()
    }
    
    
    
    @IBAction func didTapOnTerminalBtnAction(_ sender: Any) {
        terminalDropdown.show()
    }
    
    
}



extension FromLeadPassengerTVCell {
    
    
    //MARK: - setupAdultDropDown
    func setupAdultDropDown() {
        
        adultDropdown.dataSource = adult18Array
        adultDropdown.direction = .bottom
        adultDropdown.backgroundColor = .WhiteColor
        adultDropdown.anchorView = self.adultView
        adultDropdown.bottomOffset = CGPoint(x: 0, y: adultView.frame.size.height + 10)
        adultDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.adultlbl.text = item
            self?.adultlbl.textColor = .AppLabelColor
            self?.delegate?.didTapOnAdultBtnAction(cell: self!)
            
        }
    }
    
    
    //MARK: - setupChildDropDown
    func setupChildDropDown() {
        
        childDropdown.dataSource = child2_7Array
        childDropdown.direction = .bottom
        childDropdown.backgroundColor = .WhiteColor
        childDropdown.anchorView = self.childView
        childDropdown.bottomOffset = CGPoint(x: 0, y: childView.frame.size.height + 10)
        childDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.childlbl.text = item
            self?.childlbl.textColor = .AppLabelColor
            self?.delegate?.didTapOnChildBtnAction(cell: self!)
            
        }
    }
    
    
    //MARK: - setupChildDropDown
    func setupTerminalDropDown() {
        
        terminalDropdown.dataSource = terminalArray
        terminalDropdown.direction = .bottom
        terminalDropdown.backgroundColor = .WhiteColor
        terminalDropdown.anchorView = self.terminalView
        terminalDropdown.bottomOffset = CGPoint(x: 0, y: terminalView.frame.size.height + 10)
        terminalDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.terminalTF.text = item
            self?.terminalTF.textColor = .AppLabelColor
            self?.delegate?.didTapOnTerminalBtnAction(cell: self!)
            
        }
    }
    
    
    
    
    
    
}




extension FromLeadPassengerTVCell {
    
    
    //MARK: - showdebDatePicker
    func showdebDatePicker() {
        // Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.maximumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        depDateTF.inputAccessoryView = toolbar
        depDateTF.inputView = depDatePicker
    }
    
    
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        depDateTF.text = formatter.string(from: depDatePicker.date)
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    
    //MARK: - Dep Time Picker
    func showdepTimePicker(){
        //Formate Date
        depTimePicker.datePickerMode = .time
        depTimePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        depTimeTF.inputAccessoryView = toolbar
        depTimeTF.inputView = depTimePicker
        
    }
    
    @objc func doneTimePicker(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm" // Customize the date format as needed
        
        depTimeTF.text = dateFormatter.string(from: depTimePicker.date)
        //   depTimeView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        delegate?.doneTimePicker(cell: self)
    }
    
    @objc func cancelTimePicker(){
        delegate?.cancelTimePicker(cell: self)
    }
    
    
}



extension FromLeadPassengerTVCell {
    
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeView
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
           
            self?.countryCodeTF.text = self?.countrycodesArray[index]
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
            self?.countryCodeTF.textColor = .AppLabelColor



            self?.countryCodeTF.text = self?.countrycodesArray[index] ?? ""
            paymobilecountrycode = self?.countrycodesArray[index] ?? ""
            self?.countryCodeTF.resignFirstResponder()
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            
            self?.delegate?.didTapOnCountryCodeBtn(cell: self!)
            
        }
    }
   
    @objc func searchTextChanged(textField: UITextField) {
        filterContentForSearchText(textField.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
       
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
       
        
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
        dropDown.show()
    }
}



extension FromLeadPassengerTVCell {
    
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
