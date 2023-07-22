//
//  DropDownTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import DropDown


protocol DropDownTVCellDelegate {
    func didTapOnDropDownBtn(cell:DropDownTVCell)
    func didTapOnAddNoOfPassengerAction(cell:DropDownTVCell)
    func editingTextField(tf:UITextField)
}

class DropDownTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownlbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var dropdownBtn: UIButton!
    @IBOutlet weak var countrycodeTF: UITextField!
    
    
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [All_country_code_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    
    
    var delegate:DropDownTVCellDelegate?
    var optionArray = [String]()
    let dropDown = DropDown()
    var nationality:String?
    var nationalitycode = String()
    var issuingCountry:String?
    var issuingCountrycode = String()
    var countryNameArray = [String]()
    
    
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
      //  dropdownlbl.text = cellInfo?.subTitle
        //        dropdownlbl.text = cellInfo?.text
        dropdownImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        dropdownBtn.tag = cellInfo?.characterLimit ?? 0
        
        
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
        
        
        switch cellInfo?.key1 {
        case "editnationality":
            dropdownlbl.text = edit_nationalityname
            dropdownlbl.textColor = .AppLabelColor
            break
        case "editissuingcountry":
            dropdownlbl.text = edit_issuingCountryname
            dropdownlbl.textColor = .AppLabelColor
            break
        default:
            break
        }
        
        
        
        
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        dropdownView.backgroundColor = .WhiteColor
        dropdownView.layer.cornerRadius = 4
        dropdownView.clipsToBounds = true
        dropdownView.layer.borderColor = UIColor.AppBorderColor.cgColor
        dropdownView.layer.borderWidth = 1
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 14)
        
        dropdownlbl.textColor = HexColor("#CECECE")
        dropdownlbl.font = UIFont.LatoMedium(size: 18)
        dropdownBtn.setTitle("", for: .normal)
        dropdownBtn.isHidden = true
        dropdownlbl.isHidden = true
        setuptf(tf: countrycodeTF, tag1: 3, leftpadding: 20, font: .LatoRegular(size: 16), placeholder: "+355")
        
        
        setupDropDown()
       
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
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
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
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
    
    
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.dropdownBtn
        dropDown.bottomOffset = CGPoint(x: 0, y: dropdownView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.issuingCountry = self?.countryNames[index] ?? ""
            self?.issuingCountrycode = self?.countrycodesArray[index] ?? ""
            self?.nationalitycode = self?.isocountrycodeArray[index] ?? ""
           
            
            self?.countrycodeTF.text = self?.countryNames[index] ?? ""
            self?.countrycodeTF.resignFirstResponder()
            self?.delegate?.didTapOnDropDownBtn(cell: self!)
            

//            if self?.cellInfo?.key == "noofpassenger" {
//                self?.delegate?.didTapOnAddNoOfPassengerAction(cell: self!)
//            }else {
//                self?.delegate?.didTapOnDropDownBtn(cell: self!)
//            }
           
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
    
    
    @IBAction func didTapOnDropDownBtn(_ sender: Any) {
        if self.titlelbl.text == "Date Of Travel" {
            dropDown.hide()
        }else {
            dropDown.show()
        }
        
        //   delegate?.didTapOnDropDownBtn(cell: self)
    }
    
}
