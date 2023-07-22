//
//  VisaEnduiryTVCell.swift
//  BabSafar
//
//  Created by FCI on 17/02/23.
//

import UIKit
import DropDown

protocol VisaEnduiryTVCellDelegate {
    func didTapOnCountryCodeBtn(cell:VisaEnduiryTVCell)
    func didTapOnNationalityBtn(cell:VisaEnduiryTVCell)
    func didTapOnResidencyBtn(cell:VisaEnduiryTVCell)
    func didTapOnDestionationBtn(cell:VisaEnduiryTVCell)
    func didTapOnNoOfPassengersBtn(cell:VisaEnduiryTVCell)
    func didTapOnSubmitEnquireBtn(cell:VisaEnduiryTVCell)
    func donedatePicker(cell:VisaEnduiryTVCell)
    func cancelDatePicker(cell:VisaEnduiryTVCell)
    func editingTextField(tf:UITextField)
}

class VisaEnduiryTVCell: TableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fnamelbl: UILabel!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnamelbl: UILabel!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobilelbl: UILabel!
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var countryCodelbl: UILabel!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var dateOfTravellbl: UILabel!
    @IBOutlet weak var dateOfTravelTF: UITextField!
    @IBOutlet weak var nationalitylbl: UILabel!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var nationalityValuelbl: UILabel!
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var residencylbl: UILabel!
    @IBOutlet weak var residencyBtnView: UIView!
    @IBOutlet weak var residencyValuelbl: UILabel!
    @IBOutlet weak var residencyBtn: UIButton!
    @IBOutlet weak var destinationlbl: UILabel!
    @IBOutlet weak var destinationView: UIView!
    @IBOutlet weak var destinationValuelbl: UILabel!
    @IBOutlet weak var destinationBtn: UIButton!
    @IBOutlet weak var noOfPassengerslbl: UILabel!
    @IBOutlet weak var noOfPassengersValuelbl: UILabel!
    @IBOutlet weak var noOfPassengersView: UIView!
    @IBOutlet weak var noOfPassengersBtn: UIButton!
    @IBOutlet weak var submitlbl: UILabel!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var countryCodeHolderVIew: UIStackView!
    @IBOutlet weak var desView: UITextView!
    @IBOutlet weak var countrycodeTF: UITextField!
    @IBOutlet weak var nationalityTF: UITextField!
    @IBOutlet weak var residencyTF: UITextField!
    @IBOutlet weak var destinationTF: UITextField!
    
    
    let datePicker = UIDatePicker()
    var countryNameArray = [String]()
    let dropDown = DropDown()
    let nationalitydropDown = DropDown()
    let residencyDropdown = DropDown()
    let destinationDropdown = DropDown()
    var delegate:VisaEnduiryTVCellDelegate?
    var nationalityName = String()
    var nationalityCode = String()
    var cityName = String()
    var cityCode = String()
    var placeHolder = String()
    
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [All_country_code_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    
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
        
        if defaults.string(forKey: UserDefaultsKeys.visatravellerDetails) != "" {
            noOfPassengersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.visatravellerDetails) ?? "Add No of Passengers"
            noOfPassengersValuelbl.textColor = .AppLabelColor
        }else {
            noOfPassengersValuelbl.text = "Add No of Passengers"
            noOfPassengersValuelbl.textColor = .SubTitleColor
        }
        datePicker.minimumDate = Date()  //set the current date/time as a minimum
        datePicker.date = Date()
        showDatePicker()
        
        
        filterdcountrylist = countrylist
        loadCountryNamesAndCode(tag5: 55)
        loadCountryNamesAndCode(tag5: 56)
        loadCountryNamesAndCode(tag5: 57)
        loadCountryNamesAndCode(tag5: 58)
        
        
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
        
        dateOfTravelTF.inputAccessoryView = toolbar
        dateOfTravelTF.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateOfTravelTF.text = formatter.string(from: datePicker.date)
        self.nationalityTF.becomeFirstResponder()
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    
    func setupui(){
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 10)
        
        setuplabels(lbl: fnamelbl, text: "First Name", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: lnamelbl, text: "Last Name", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: emaillbl, text: "Email", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: mobilelbl, text: "Phone Number", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: countryCodelbl, text: "+91", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: dateOfTravellbl, text: "Date Of Travel", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: nationalitylbl, text: "Nationality", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: nationalityValuelbl, text: "India", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: residencylbl, text: "Residency", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: residencyValuelbl, text: "India", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: destinationlbl, text: "Visa Destination", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: destinationValuelbl, text: "India", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: noOfPassengerslbl, text: "No Of Passsenger", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: noOfPassengersValuelbl, text: "1 Passenger", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: submitlbl, text: "Submit Enquiry", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .left)
        
        setupTF(tf: fnameTF, placeholder: "First Name", tag: 1)
        setupTF(tf: lnameTF, placeholder: "Last Name", tag: 2)
        setupTF(tf: emailTF, placeholder: "Email Address", tag: 11)
        setupTF(tf: mobileTF, placeholder: "Phone Number", tag: 12)
        mobileTF.layer.cornerRadius = 0
        mobileTF.clipsToBounds = true
        setupTF(tf: dateOfTravelTF, placeholder: "Date Of Travel", tag: 3)
        
        
        setuptf(tf: countrycodeTF, tag1: 55, leftpadding: 12, font: .LatoRegular(size: 16), placeholder: "Kuwait")
        setuptf(tf: nationalityTF, tag1: 56, leftpadding: 20, font: .LatoRegular(size: 16), placeholder: "Nationality")
        setuptf(tf: residencyTF, tag1: 57, leftpadding: 20, font: .LatoRegular(size: 16), placeholder: "Residency")
        setuptf(tf: destinationTF, tag1: 58, leftpadding: 20, font: .LatoRegular(size: 16), placeholder: "Visa Destination")
        
        countryCodelbl.isHidden = true
        nationalityValuelbl.isHidden = true
        residencyValuelbl.isHidden = true
        destinationValuelbl.isHidden = true
        
        setupDropDownforResidency()
        setupDropDownforDestination()
        setupDropDownforNatinality()
        setupDropDown()
        countryCodeBtn.isHidden = true
        nationalityBtn.isHidden = true
        residencyBtn.isHidden = true
        destinationBtn.isHidden = true
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        nationalityTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        nationalityTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        residencyTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        residencyTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        destinationTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        destinationTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        
        setupViews(view: countryCodeHolderVIew, color: .WhiteColor)
        setupViews(view: nationalityView, color: .WhiteColor)
        setupViews(view: residencyBtnView, color: .WhiteColor)
        setupViews(view: destinationView, color: .WhiteColor)
        setupViews(view: noOfPassengersView, color: .WhiteColor)
        setupViews(view: submitView, color: .AppBtnColor)
        
        
        nationalityBtn.setTitle("", for: .normal)
        nationalityBtn.addTarget(self, action: #selector(didTapOnNationalityBtn(_:)), for: .touchUpInside)
        residencyBtn.setTitle("", for: .normal)
        residencyBtn.addTarget(self, action: #selector(didTapOnResidencyBtn(_:)), for: .touchUpInside)
        noOfPassengersBtn.setTitle("", for: .normal)
        noOfPassengersBtn.addTarget(self, action: #selector(didTapOnNoOfPassengersBtn(_:)), for: .touchUpInside)
        destinationBtn.setTitle("", for: .normal)
        destinationBtn.addTarget(self, action: #selector(didTapOnVisaDestinationBtn(_:)), for: .touchUpInside)
        submitBtn.setTitle("", for: .normal)
        submitBtn.addTarget(self, action: #selector(didTapOnSubmitEnquireBtn(_:)), for: .touchUpInside)
        countryCodeBtn.setTitle("", for: .normal)
        countryCodeBtn.addTarget(self, action: #selector(didTapOnCountryCodeBtn(_:)), for: .touchUpInside)
        
        setupdescView()
    }
    
    
    func setuptf(tf:UITextField,tag1:Int,leftpadding:Int,font:UIFont,placeholder:String){
        tf.backgroundColor = .clear
        tf.placeholder = placeholder
        tf.setLeftPaddingPoints(CGFloat(leftpadding))
        tf.font = font
        tf.tag = tag1
        tf.delegate = self
        tf.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    func setupdescView() {
        desView.layer.cornerRadius = 5
        desView.clipsToBounds = true
        desView.layer.borderWidth = 1
        desView.layer.borderColor = UIColor.AppBorderColor.cgColor
        desView.delegate = self
        desView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        desView.setPlaceholder(ph: placeHolder)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
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
    
    
    func setupViews(view:UIView,color:UIColor) {
        view.backgroundColor = color
        view.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E6E8E7"), cornerRadius: 4)
    }
    
    @objc func didTapOnNationalityBtn(_ sender:UIButton) {
        nationalitydropDown.show()
    }
    
    @objc func didTapOnResidencyBtn(_ sender:UIButton) {
        residencyDropdown.show()
    }
    
    @objc func didTapOnVisaDestinationBtn(_ sender:UIButton) {
        destinationDropdown.show()
    }
    
    @objc func didTapOnNoOfPassengersBtn(_ sender:UIButton) {
        delegate?.didTapOnNoOfPassengersBtn(cell: self)
    }
    
    
    @objc func didTapOnCountryCodeBtn(_ sender:UIButton) {
        dropDown.show()
    }
    
    
    @objc func didTapOnSubmitEnquireBtn(_ sender:UIButton) {
        delegate?.didTapOnSubmitEnquireBtn(cell: self)
    }
    
    
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    @objc func searchTextBegin(textField: UITextField) {
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist
        loadCountryNamesAndCode(tag5: textField.tag)
        
        switch textField.tag {
        case 55:
            textField.text = ""
            dropDown.show()
            break
            
        case 56:
            textField.text = ""
            nationalitydropDown.show()
            break
            
        case 57:
            textField.text = ""
            residencyDropdown.show()
            break
            
        case 58:
            textField.text = ""
            destinationDropdown.show()
            break
            
            
        default:
            break
        }
        
        
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText, tag5: textField.tag)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText, tag5: textField.tag)
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String,tag5:Int) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode(tag5: tag5)
        switch tag5 {
        case 55:
            dropDown.show()
            break
            
        case 56:
            nationalitydropDown.show()
            break
            
        case 57:
            residencyDropdown.show()
            break
            
        case 58:
            destinationDropdown.show()
            break
            
            
        default:
            break
        }
        
    }
    
    func loadCountryNamesAndCode(tag5:Int){
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
            
            switch tag5 {
            case 55:
                dropDown.dataSource = countryNames
                break
                
            case 56:
                nationalitydropDown.dataSource = countryNames
                break
                
            case 57:
                residencyDropdown.dataSource = countryNames
                break
                
            case 58:
                destinationDropdown.dataSource = countryNames
                break
                
                
            default:
                break
            }
        }
        
    }
    
    
    //MARK: - setupDropDown
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeView
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countrycodeTF.text = countrylist[index].country_code ?? ""
            self?.mobileTF.becomeFirstResponder()
            self?.delegate?.didTapOnCountryCodeBtn(cell: self!)
        }
    }
    
    func setupDropDownforNatinality() {
        
        nationalitydropDown.direction = .bottom
        nationalitydropDown.backgroundColor = .WhiteColor
        nationalitydropDown.anchorView = self.nationalityView
        nationalitydropDown.bottomOffset = CGPoint(x: 0, y: nationalityView.frame.size.height + 10)
        nationalitydropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.nationalityTF.text = item
            self?.cityName = item
            self?.cityCode = self?.countrycodesArray[index] ?? ""
            self?.residencyTF.becomeFirstResponder()
            self?.delegate?.didTapOnNationalityBtn(cell: self!)
        }
    }
    
    
    func setupDropDownforResidency() {
        
        residencyDropdown.direction = .bottom
        residencyDropdown.backgroundColor = .WhiteColor
        residencyDropdown.anchorView = self.residencyBtnView
        residencyDropdown.bottomOffset = CGPoint(x: 0, y: residencyBtnView.frame.size.height + 10)
        residencyDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.residencyTF.text = item
            self?.cityName = item
            self?.cityCode = self?.originArray[index] ?? ""
            self?.destinationTF.becomeFirstResponder()
            self?.delegate?.didTapOnResidencyBtn(cell: self!)
        }
    }
    
    func setupDropDownforDestination() {
        
        destinationDropdown.direction = .bottom
        destinationDropdown.backgroundColor = .WhiteColor
        destinationDropdown.anchorView = self.destinationView
        destinationDropdown.bottomOffset = CGPoint(x: 0, y: destinationView.frame.size.height + 10)
        destinationDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.destinationTF.text = item
            self?.cityName = item
            self?.cityCode = self?.originArray[index] ?? ""
            self?.destinationTF.resignFirstResponder()
            self?.delegate?.didTapOnDestionationBtn(cell: self!)
        }
    }
    
    
    
}



extension VisaEnduiryTVCell {
    
    
    
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

