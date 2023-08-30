//
//  SearchHotelTVCell.swift
//  BabSafar
//
//  Created by FCI on 25/01/23.
//

import UIKit
import DropDown
import IQKeyboardManager

protocol SearchHotelTVCellDelegate {
    func didTapOnCheckinBtn(cell:SearchHotelTVCell)
    func didTapOnCheckoutBtn(cell:SearchHotelTVCell)
    func didTapOnAddRoomsAndGuestBtn(cell:SearchHotelTVCell)
    func didTapOnSearchHotelBtn(cell:SearchHotelTVCell)
    func didTapOnSearchHotelCityBtn(cell:SearchHotelTVCell)
    func didTapOnSelectCountryCodeList(cell:SearchHotelTVCell)
    func editingTextField(tf:UITextField)
    
    
}

class SearchHotelTVCell: TableViewCell, HotelCitySearchViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var locationCityView: UIView!
    @IBOutlet weak var locationCityTitlelbl: UILabel!
    @IBOutlet weak var locationCitylbl: UILabel!
    @IBOutlet weak var checkinView: UIView!
    @IBOutlet weak var checkinTitlelbl: UILabel!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkinBtn: UIButton!
    @IBOutlet weak var checkoutView: UIView!
    @IBOutlet weak var checkoutTitlelbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var addRoomsBtnView: UIView!
    @IBOutlet weak var addRoomsTitlelbl: UILabel!
    @IBOutlet weak var addRoomsValuelbl: UILabel!
    @IBOutlet weak var addRoomsBtn: UIButton!
    @IBOutlet weak var searchHotelsBtnView: UIView!
    @IBOutlet weak var searchHotellbl: UILabel!
    @IBOutlet weak var searchHotelBtn: UIButton!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var searchHotelCityBtn: UIButton!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var nationalitylbl: UILabel!
    @IBOutlet weak var nationalityValuelbl: UILabel!
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var hotelSearchTV: UITableView!
    @IBOutlet weak var hotelSearchTVHeight: NSLayoutConstraint!
    @IBOutlet weak var nationalityTf: UITextField!
    
    
    var isSearchBool = Bool()
    var searchText = String()
    var filterdcountrylist = [All_country_code_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var originArray = [String]()
    var isocountrycodeArray = [String]()
    
    var dropDown = DropDown()
    var ndropDown = DropDown()
    var cityViewModel: HotelCitySearchViewModel?
    var payload = [String:Any]()
    var cityNameArray = [String]()
    var hotelList = [HotelCityListModel]()
    var delegate:SearchHotelTVCellDelegate?
    var clist = [All_country_code_list]()
    var cname = [String]()
    var countryCode = String()
    var cnameArray = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 100 // Adjust this value as needed
        cityViewModel = HotelCitySearchViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        hotelSearchTVHeight.constant = 0
        filterdcountrylist = countrylist
        loadCountryNamesAndCode()
        
        NotificationCenter.default.addObserver(self, selector: #selector(hotelrooms), name: Notification.Name("hotelrooms"), object: nil)
    }
    
    @objc func hotelrooms() {
        setupUI()
    }
    
    
    
    func setupUI() {
        
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 10)
        locationCityView.backgroundColor = HexColor("#FCFCFC")
        locationCityView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        checkoutView.backgroundColor = HexColor("#FCFCFC")
        checkoutView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        checkinView.backgroundColor = HexColor("#FCFCFC")
        checkinView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        addRoomsBtnView.backgroundColor = HexColor("#FCFCFC")
        addRoomsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        searchHotelsBtnView.backgroundColor = HexColor("#EC441E")
        searchHotelsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        setuplabels(lbl: locationCityTitlelbl, text: "Location/City", textcolor: .AppLabelColor, font: .LatoLight(size: 12), align: .left)
        setuplabels(lbl: locationCitylbl, text: defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "Add City", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: checkinTitlelbl, text: "Check-In", textcolor: .AppLabelColor, font: .LatoLight(size: 12), align: .left)
        setuplabels(lbl: checkinlbl, text: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Add Check In Date", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: checkoutTitlelbl, text: "Check - Out", textcolor: .AppLabelColor, font: .LatoLight(size: 12), align: .left)
        setuplabels(lbl: checkoutlbl, text: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Add Check Out Date", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: addRoomsTitlelbl, text: "Rooms & Guests", textcolor: .AppLabelColor, font: .LatoLight(size: 12), align: .left)
        setuplabels(lbl: addRoomsValuelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "")", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: searchHotellbl, text: "Search Hotels", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
        checkinBtn.setTitle("", for: .normal)
        checkoutBtn.setTitle("", for: .normal)
        addRoomsBtn.setTitle("", for: .normal)
        searchHotelBtn.setTitle("", for: .normal)
        
        checkinBtn.addTarget(self, action: #selector(didTapOnCheckinBtn(_:)), for: .touchUpInside)
        checkoutBtn.addTarget(self, action: #selector(didTapOnCheckoutBtn(_:)), for: .touchUpInside)
        addRoomsBtn.addTarget(self, action: #selector(didTapOnAddRoomsAndGuestBtn(_:)), for: .touchUpInside)
        searchHotelBtn.addTarget(self, action: #selector(didTapOnSearchHotelBtn(_:)), for: .touchUpInside)
        
        cityTF.textColor = .AppLabelColor
        cityTF.font = .LatoSemibold(size: 18)
        cityTF.delegate = self
        cityTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        cityTF.isHidden = false
        
        
        searchHotelCityBtn.setTitle("", for: .normal)
        searchHotelCityBtn.addTarget(self, action: #selector(didTapOnSearchHotelCityBtn(_:)), for: .touchUpInside)
        searchHotelCityBtn.isHidden = true
        
        setupInitialsInput(lbl: locationCitylbl, str: "Add City")
        setupInitialsInput(lbl: checkinlbl, str: "Add Check In Date")
        setupInitialsInput(lbl: checkoutlbl, str: "Add Check Out Date")
        
        nationalityView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        nationalityView.backgroundColor = HexColor("#FCFCFC")
        setuplabels(lbl: nationalitylbl, text: "Nationality", textcolor: .AppLabelColor, font: .LatoLight(size: 12), align: .left)
        setuplabels(lbl: nationalityValuelbl, text: "Select Nationality", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        nationalityBtn.setTitle("", for: .normal)
        nationalityBtn.addTarget(self, action: #selector(didTapOnNatinalityButtonAction(_:)), for: .touchUpInside)
        
        
        setupnationalityDropDown()
        setuptf(tf: nationalityTf, tag1: 3, leftpadding: 20, font: .LatoRegular(size: 16), placeholder: "")
        nationalityBtn.isHidden = true
        nationalityTf.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        nationalityTf.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        
        setupTV()
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
    
    
    func setupTV() {
        hotelSearchTV.delegate = self
        hotelSearchTV.dataSource = self
        hotelSearchTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    func setupInitialsInput(lbl:UILabel,str:String){
        if lbl.text == str {
            lbl.textColor = .SubTitleColor
        }else {
            lbl.textColor = .AppLabelColor
        }
        
    }
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        // locationCitylbl.text = ""
    }
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        if textField.text?.isEmpty == true {
            hotelSearchTVHeight.constant = 0
        }else {
            self.locationCitylbl.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            
        }
        
    }
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallHotelCitySearchAPI(dictParam: payload)
    }
    
    
    func hotelCitySearchResult(response: [HotelCityListModel]) {
        hotelList = response
        updateHeight(height: 80)
    }
    
    func updateHeight(height:Int) {
        hotelSearchTVHeight.constant = CGFloat(hotelList.count * height)
        DispatchQueue.main.async {[self] in
            hotelSearchTV.reloadData()
        }
    }
    
    
    
    @objc func didTapOnSearchHotelCityBtn(_ sender:UIButton){
        delegate?.didTapOnSearchHotelCityBtn(cell: self)
    }
    
    
    @objc func didTapOnCheckinBtn(_ sender:UIButton){
        delegate?.didTapOnCheckinBtn(cell: self)
    }
    
    @objc func didTapOnCheckoutBtn(_ sender:UIButton){
        delegate?.didTapOnCheckoutBtn(cell: self)
    }
    
    @objc func didTapOnAddRoomsAndGuestBtn(_ sender:UIButton){
        delegate?.didTapOnAddRoomsAndGuestBtn(cell: self)
    }
    
    @objc func didTapOnSearchHotelBtn(_ sender:UIButton){
        delegate?.didTapOnSearchHotelBtn(cell: self)
    }
    
    
    @objc func didTapOnNatinalityButtonAction(_ sender:UIButton) {
        ndropDown.show()
    }
    
    
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    
    @objc func searchTextBegin(textField: UITextField) {
        if textField == nationalityTf {
            nationalityValuelbl.text = ""
            nationalityTf.text = ""
            filterdcountrylist.removeAll()
            filterdcountrylist = countrylist
            loadCountryNamesAndCode()
            ndropDown.show()
        }
        
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        if textField == nationalityTf {
            searchText = textField.text ?? ""
            if searchText == "" {
                isSearchBool = false
                filterContentForSearchText(searchText)
            }else {
                isSearchBool = true
                filterContentForSearchText(searchText)
            }
        }
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        print(filterdcountrylist)
        
        loadCountryNamesAndCode()
        ndropDown.show()
        
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
            ndropDown.dataSource = countryNames
        }
    }
    
    func setupnationalityDropDown() {
        
        ndropDown.direction = .bottom
        ndropDown.cellHeight = 50
        ndropDown.backgroundColor = .WhiteColor
        ndropDown.anchorView = self.nationalityTf
        ndropDown.bottomOffset = CGPoint(x: 0, y: nationalityTf.frame.size.height + 10)
        ndropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            print(item)
            self?.nationalityValuelbl.text = self?.countryNames[index] ?? ""
            self?.countryCode = self?.isocountrycodeArray[index] ?? ""
            self?.nationalityTf.text = ""
            self?.nationalityTf.resignFirstResponder()
            self?.delegate?.didTapOnSelectCountryCodeList(cell: self!)
        }
    }
    
    
}

extension SearchHotelTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hotelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = hotelList[indexPath.row].value
            cell.subTitlelbl.text = hotelList[indexPath.row].label
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            //cityTF.resignFirstResponder()
            cityTF.text = ""
            locationCitylbl.text = hotelList[indexPath.row].value ?? ""
            locationCitylbl.textColor = .AppLabelColor
            
            defaults.set(hotelList[indexPath.row].value ?? "", forKey: UserDefaultsKeys.locationcity)
            defaults.set(hotelList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.locationcityid)
            defaults.set(hotelList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.locationcityname)
            
            updateHeight(height: 0)
        }
    }
    
    
}
