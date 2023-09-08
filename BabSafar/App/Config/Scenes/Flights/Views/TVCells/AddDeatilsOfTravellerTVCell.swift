//
//  AddDeatilsOfTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 13/07/23.
//

import UIKit
import DropDown
import CoreData


struct Traveler {
    var mrtitle:String?
    var gender:String?
    var firstName: String?
    var lastName: String?
    var dob:String?
    var nationality:String?
    var passportno:String?
    var passportIssuingCountry:String?
    var passportIssuingCountryName:String?
    var passportExpireDate:String?
    var frequentFlyrNo:String?
    var meal:String?
    var specialAssicintence:String?
    var passengertype:String?
    var laedpassenger:String?
    var middlename:String?
    
}

enum AgeCategory {
    case adult
    case child
    case infant
}


protocol AddDeatilsOfTravellerTVCellDelegate {
    func didTapOnExpandAdultViewbtnAction(cell:AddDeatilsOfTravellerTVCell)
    func tfeditingChanged(tf:UITextField)
    
    func didTapOnTitleBtnAction(cell:AddDeatilsOfTravellerTVCell)
    func didTapOnMrBtnAction(cell:AddDeatilsOfTravellerTVCell)
    func didTapOnMrsBtnAction(cell:AddDeatilsOfTravellerTVCell)
    func didTapOnMissBtnAction(cell:AddDeatilsOfTravellerTVCell)
    func didTapOnSaveTravellerDetailsBtnAction(cell:AddDeatilsOfTravellerTVCell)
    func editingMDCOutlinedTextField(tf:UITextField)
    func donedatePicker(cell:AddDeatilsOfTravellerTVCell)
    func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell)
    func didTapOnSelectNationalityBtn(cell:AddDeatilsOfTravellerTVCell)
    func didTapOnSelectIssuingCountryBtn(cell:AddDeatilsOfTravellerTVCell)
    func didTapOnMealPreferenceBtn(cell:AddDeatilsOfTravellerTVCell)
    func didTapOnSpecialAssicintenceBtn(cell:AddDeatilsOfTravellerTVCell)
    
    func didTapOnFlyerProgramBtnAction(cell:AddDeatilsOfTravellerTVCell)
}

class AddDeatilsOfTravellerTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownimg: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var passportnoTF: UITextField!
    @IBOutlet weak var passportIssuingCountryTF: UITextField!
    @IBOutlet weak var passportExpireDateTF: UITextField!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var nameTitleSelectBtn: UIButton!
    @IBOutlet weak var passportIssueingCountrySelectBtn: UIButton!
    @IBOutlet weak var fnameView: UIView!
    @IBOutlet weak var lnameView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var passportnoView: UIView!
    @IBOutlet weak var issuecountryView: UIView!
    @IBOutlet weak var passportexpireView: UIView!
    @IBOutlet weak var flyerNoTF: UITextField!
    @IBOutlet weak var flyerProgramTF: UITextField!
    @IBOutlet weak var flyerPgmBtn: UIButton!
    
    
    
    let dobDatePicker = UIDatePicker()
    let passportDatePicker = UIDatePicker()
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    let mealsDropdown = DropDown()
    let specialAssistenceDropDown = DropDown()
    let titledropDown = DropDown()
    let flyerdropDown = DropDown()
    var clist = [All_country_code_list]()
    var countryNames = [String]()
    var natinalityCode = String()
    var countryCode = String()
    var isssuingCountryCode = String()
    var maxLength = 50
    var nationalityName = String()
    var passIssuingCountryName = String()
    var expandViewBool = true
    var delegate:AddDeatilsOfTravellerTVCellDelegate?
    var indexposition = Int()
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [All_country_code_list]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    var frequentflyersArrayString = [String]()
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
        collapsView()
    }
    
    
    
    @objc func tfeditingChanged(tf:UITextField) {
        delegate?.tfeditingChanged(tf: tf)
    }
    
    
    func expandView() {
        dropdownimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        saveView.isHidden = false
        viewHeight.constant = 305
    }
    
    
    func collapsView() {
        dropdownimg.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        saveView.isHidden = true
        viewHeight.constant = 0
    }
    
    
    override func updateUI() {
        
        titlelbl.text = cellInfo?.title
        
        guard let characterLimit = cellInfo?.characterLimit else {
            return
        }
        indexposition = characterLimit - 1
        
        
        
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
        
        frequent_flyersArray.forEach { i in
            frequentflyersArrayString.append(i.airline_name ?? "")
        }
        flyerdropDown.dataSource = frequentflyersArrayString
        
        
        
        if let cellInfo = cellInfo {
            if cellInfo.key == "adult" {
                if travelerArray.count <= self.indexposition {
                    travelerArray += Array(repeating: Traveler(), count: (self.indexposition ) - travelerArray.count + 1)
                }
                
                // Update the gender property of the Traveler object at the specified index
                travelerArray[self.indexposition ].middlename = ""
                travelerArray[self.indexposition ].laedpassenger = "0"
                titledropDown.dataSource = ["Mr","Ms","Mrs"]
                
            } else if cellInfo.key == "child" {
                if travelerArray.count <= self.indexposition {
                    travelerArray += Array(repeating: Traveler(), count: (self.indexposition ) - travelerArray.count + 1)
                }
                
                // Update the gender property of the Traveler object at the specified index
                travelerArray[self.indexposition ].middlename = ""
                travelerArray[self.indexposition ].laedpassenger = "0"
                titledropDown.dataSource = ["Master","Miss"]
                
            } else {
                if travelerArray.count <= self.indexposition {
                    travelerArray += Array(repeating: Traveler(), count: (self.indexposition ) - travelerArray.count + 1)
                }
                
                // Update the gender property of the Traveler object at the specified index
                travelerArray[self.indexposition ].middlename = ""
                travelerArray[self.indexposition ].laedpassenger = "0"
                titledropDown.dataSource = ["Master","Miss"]
                
            }
            showdobDatePicker()
        }
        
        
        if cellInfo?.title == "Adult 1" {
            setAttributedText(str1: "Adult 1", str2: "  Lead Passanger")
            travelerArray[self.indexposition ].laedpassenger = "1"
            expandView()
            expandViewBool = false
        }
    }
    
    
    func setupUI() {
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        dropdownimg.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        contentView.backgroundColor = UIColor.AppHolderViewColor
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.borderWidth = 1
        holderView.layer.cornerRadius = 3
        holderView.clipsToBounds = true
        
        collapsView()
        
        
        setupTextField(txtField: titleTF, tag1: 11, label: "Title*", placeholder: "MR")
        setupTextField(txtField: fnameTF, tag1: 1, label: "First Name*", placeholder: "First Name")
        setupTextField(txtField: lnameTF, tag1: 2, label: "Last Name*", placeholder: "Last Name")
        setupTextField(txtField: dobTF, tag1: 3, label: "Date of Birth*", placeholder: "DOB")
        setupTextField(txtField: passportnoTF, tag1: 5, label: "Passport NO*", placeholder: "Passport NO")
        setupTextField(txtField: passportIssuingCountryTF, tag1: 6, label: "Passport Issuing Country*", placeholder: "Issuing Country")
        setupTextField(txtField: passportExpireDateTF, tag1: 7, label: "Passport Exprity Date*", placeholder: "Exprity Date")
        setupTextField(txtField: flyerProgramTF, tag1: 8, label: "Flyer Program ", placeholder: "Flyer Program")
        setupTextField(txtField: flyerNoTF, tag1: 9, label: "Flyer Number ", placeholder: "Flyer Number")
        
        
        passportIssueingCountrySelectBtn.isHidden = true
        passportIssueingCountrySelectBtn.setTitle("", for: .normal)
        passportIssueingCountrySelectBtn.addTarget(self, action: #selector(didTapOnPassportIssuingCountrySelectBtnAction(_:)), for: .touchUpInside)
        
        
        showdobDatePicker()
        showexpirDatePicker()
        setupTitleDropDown()
        setupFlyerDropDown()
        setupIssuingCountryDropDown()
        
        
        setupView(v: titleView)
        setupView(v: fnameView)
        setupView(v: lnameView)
        setupView(v: dobView)
        setupView(v: passportnoView)
        setupView(v: issuecountryView)
        setupView(v: passportexpireView)
       
        passportIssuingCountryTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        
    }
    
    
    
    func setupView(v:UIView) {
        v.layer.cornerRadius = 4
        v.clipsToBounds = true
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
        v.layer.borderWidth = 1
    }
    
    
    
    @objc func didTapOnPassportIssuingCountrySelectBtnAction(_ sender:UIButton) {
       // dropDown1.show()
    }
    
    @objc func didTapOnPassportNationalitySelectBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    
    @objc func didTapOnFrequentFlyrPgmBtn(_ sender:UIButton) {
        print("didTapOnFrequentFlyrPgmBtn")
    }
    
    @objc func didTapOnMealPreferenceBtn(_ sender:UIButton) {
        mealsDropdown.show()
    }
    
    @objc func didTapOnSpecialAssicintenceBtn(_ sender:UIButton) {
        specialAssistenceDropDown.show()
    }
    
    
    
    func setupTextField(txtField:UITextField,tag1:Int,label:String,placeholder:String) {
        txtField.setLeftPaddingPoints(15)
        txtField.delegate = self
        txtField.tag = tag1
        txtField.placeholder = placeholder
        txtField.textColor = .AppLabelColor
        txtField.backgroundColor = .clear
        txtField.font = UIFont.LatoRegular(size: 16)
        txtField.addTarget(self, action: #selector(editingTextField1(textField:)), for: .editingChanged)
        
    }
    
    
    
    
    
    func setupTitleDropDown() {
        
        titledropDown.direction = .bottom
        titledropDown.backgroundColor = .WhiteColor
        titledropDown.anchorView = self.titleView
        
        titledropDown.bottomOffset = CGPoint(x: 0, y: titleView.frame.size.height + 20)
        titledropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.titleTF.text = item
            
            if travelerArray.count <= self?.indexposition ?? 0 {
                travelerArray += Array(repeating: Traveler(), count: (self?.indexposition ?? 0) - travelerArray.count + 1)
            }
            
            switch item {
            case "Mr":
                travelerArray[self?.indexposition ?? 0].mrtitle = "1"
                travelerArray[self?.indexposition ?? 0].gender = "1"
                break
                
                
            case "Master":
                travelerArray[self?.indexposition ?? 0].mrtitle = "4"
                travelerArray[self?.indexposition ?? 0].gender = "1"
                break
                
            case "Ms":
                travelerArray[self?.indexposition ?? 0].mrtitle = "2"
                travelerArray[self?.indexposition ?? 0].gender = "2"
                break
                
                
            case "Miss":
                travelerArray[self?.indexposition ?? 0].mrtitle = "3"
                travelerArray[self?.indexposition ?? 0].gender = "2"
                break
                
            case "Mrs":
                travelerArray[self?.indexposition ?? 0].mrtitle = "5"
                travelerArray[self?.indexposition ?? 0].gender = "2"
                break
                
            default:
                break
                
            }
            
            self?.titleView.layer.borderColor = UIColor.AppBorderColor.cgColor
            self?.fnameTF.becomeFirstResponder()
            self?.delegate?.didTapOnTitleBtnAction(cell: self!)
        }
        
    }
    
    
    func setupFlyerDropDown() {
        
        flyerdropDown.direction = .bottom
        flyerdropDown.backgroundColor = .WhiteColor
        flyerdropDown.anchorView = self.flyerPgmBtn
        flyerdropDown.bottomOffset = CGPoint(x: 0, y: flyerPgmBtn.frame.size.height + 20)
        flyerdropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.flyerProgramTF.text = item
            self?.delegate?.didTapOnFlyerProgramBtnAction(cell: self!)
        }
        
    }
    
    
    func setupIssuingCountryDropDown() {
        
        dropDown1.direction = .bottom
        dropDown1.backgroundColor = .WhiteColor
        dropDown1.anchorView = self.issuecountryView
        dropDown1.bottomOffset = CGPoint(x: 0, y: issuecountryView.frame.size.height + 20)
        dropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            self?.passportIssuingCountryTF.text = self?.countryNames[index] ?? ""
            
            
            if travelerArray.count <= self?.indexposition ?? 0 {
                travelerArray += Array(repeating: Traveler(), count: (self?.indexposition ?? 0) - travelerArray.count + 1)
            }
            
            // Update the gender property of the Traveler object at the specified index
            travelerArray[self?.indexposition ?? 0].passportIssuingCountry = self?.originArray[index] ?? ""
            travelerArray[self?.indexposition ?? 0].passportIssuingCountryName = self?.countryNames[index] ?? ""
            
            self?.issuecountryView.layer.borderColor = UIColor.AppBorderColor.cgColor
            self?.passportExpireDateTF.becomeFirstResponder()
            
          //  self?.delegate?.didTapOnSelectIssuingCountryBtn(cell: self!)
        }
        
    }
    
    
    func showdobDatePicker() {
        // Formate Date
        dobDatePicker.datePickerMode = .date
        dobDatePicker.maximumDate = Date()
        dobDatePicker.preferredDatePickerStyle = .wheels
        
        // Set date restrictions based on age category
        let calendar = Calendar.current
        var components = DateComponents()
        
        
        switch ageCategory {
        case .adult:
            
            components.year = -12 // Allow selecting a date at least 12 years in the past
            dobDatePicker.maximumDate = calendar.date(byAdding: components, to: Date())
            
            //            components.year = -100
            //            dobDatePicker.minimumDate = calendar.date(byAdding: components, to: Date())
        case .child:
            components.year = -12
            dobDatePicker.minimumDate = calendar.date(byAdding: components, to: Date())
        case .infant:
            components.year = -2
            dobDatePicker.minimumDate = calendar.date(byAdding: components, to: Date())
        }
        
        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        dobTF.inputAccessoryView = toolbar
        dobTF.inputView = dobDatePicker
    }
    
    
    
    
    func showexpirDatePicker(){
        //Formate Date
        passportDatePicker.datePickerMode = .date
        passportDatePicker.minimumDate = Date()
        passportDatePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        passportExpireDateTF.inputAccessoryView = toolbar
        passportExpireDateTF.inputView = passportDatePicker
        
    }
    
    
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        if dobTF.isFirstResponder {
            dobTF.text = formatter.string(from: dobDatePicker.date)
            if travelerArray.count <= indexposition {
                travelerArray += Array(repeating: Traveler(), count: indexposition - travelerArray.count + 1)
            }
            
            // Update the gender property of the Traveler object at the specified index
            travelerArray[indexposition].dob = dobTF.text
            self.dobTF.resignFirstResponder()
            self.dobView.layer.borderColor = UIColor.AppBorderColor.cgColor
            self.passportnoTF.becomeFirstResponder()
            
        } else if passportExpireDateTF.isFirstResponder {
            passportExpireDateTF.text = formatter.string(from: passportDatePicker.date)
            
            if travelerArray.count <= indexposition {
                travelerArray += Array(repeating: Traveler(), count: indexposition - travelerArray.count + 1)
            }
            
            // Update the gender property of the Traveler object at the specified index
            travelerArray[indexposition].passportExpireDate = passportExpireDateTF.text
            self.passportexpireView.layer.borderColor = UIColor.AppBorderColor.cgColor
            self.passportExpireDateTF.resignFirstResponder()
        }
        
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dobTF {
            if let cellInfo = cellInfo {
                if cellInfo.key == "adult" {
                    ageCategory = AgeCategory.adult
                } else if cellInfo.key == "child" {
                    ageCategory = AgeCategory.child
                } else {
                    ageCategory = AgeCategory.infant
                }
                showdobDatePicker()
            }
        }
       
        else if textField == passportIssuingCountryTF {
           loadCountryNamesAndCode()
        }
    }
    
    
    
    
    @objc func editingTextField1(textField: UITextField) {
        
        if travelerArray.count <= indexposition {
            travelerArray += Array(repeating: Traveler(), count: indexposition - travelerArray.count + 1)
        }
        
        if let text = textField.text, !text.isEmpty {
            
            switch textField {
            case fnameTF:
                fnameView.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].firstName = text
                
                
                
                break
                
            case lnameTF:
                lnameView.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].lastName = text
                break
                
                
            case passportnoTF:
                passportnoView.layer.borderColor = UIColor.AppBorderColor.cgColor
                travelerArray[indexposition].passportno = text
                break
                
                
                
            default:
                break
            }
            
            
            
        }
        
        
    }
    
    
    
    private func getIndexPath() -> IndexPath? {
        guard let tableView = superview as? UITableView else {
            return nil
        }
        
        return tableView.indexPath(for: self)
    }
    
    
    
    @IBAction func didTapOnExpandAdultViewbtnAction(_ sender: Any) {
        delegate?.didTapOnExpandAdultViewbtnAction(cell: self)
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        filterContentForSearchText(searchText)
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
            dropDown1.dataSource = countryNames
        }
        
        dropDown1.show()
        
    }
    
    
    
    
    
    @IBAction func didTapOnTitileSelectBtnAction(_ sender: Any) {
        titledropDown.show()
    }
    
    
    @IBAction func didTapOnFlyerProgramBtnAction(_ sender: Any) {
        flyerdropDown.show()
    }
    
    
    
}


extension AddDeatilsOfTravellerTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
    
    func setAttributedText(str1:String,str2:String)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 14)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppCalenderDateSelectColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 10)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        titlelbl.attributedText = combination
        
    }
}
