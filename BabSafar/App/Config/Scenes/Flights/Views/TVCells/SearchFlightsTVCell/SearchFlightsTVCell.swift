//
//  SearchFlightsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import DropDown

protocol SearchFlightsTVCellDelegate {
    func didTapOnFromCityBtnAction(cell: SearchFlightsTVCell)
    func didTapOnToCityBtnAction(cell: SearchFlightsTVCell)
    func didTapOnSwipeCityBtnAction(cell: SearchFlightsTVCell)
    func didTapOnDepartureBtnAction(cell: SearchFlightsTVCell)
    func didTapOnReturnBtnAction(cell: SearchFlightsTVCell)
    func didTapOnReturnToOnewayBtnAction(cell: SearchFlightsTVCell)
    func addEconomyBtnAction(cell: SearchFlightsTVCell)
    func moreOptionBtnAction(cell: SearchFlightsTVCell)
    func didTapOnairlineBtnAction(cell: SearchFlightsTVCell)
    func didTapOntimeReturnJourneyBtnAction(cell: SearchFlightsTVCell)
    func didTapOntimeOutwardJourneyBtnAction(cell: SearchFlightsTVCell)
    func didTapOnReturnJurneyRadioButton(cell: SearchFlightsTVCell)
    func didTapOnDirectFlightRadioButton(cell: SearchFlightsTVCell)
    func didTapOnSearchFlightBtnAction(cell: SearchFlightsTVCell)
    func addTraverllersBtnAction(cell: SearchFlightsTVCell)
    func addClassBtnAction(cell: SearchFlightsTVCell)
    func didTapOnCloseReturnView(cell: SearchFlightsTVCell)
    
}


class SearchFlightsTVCell: TableViewCell, SelectCityViewModelProtocal {
    func ShowCityListMulticity(response: [SelectCityModel]) {
        
    }
    

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var fromCitylbl: UILabel!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var toCitylbl: UILabel!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var swipeImage: UIImageView!
    @IBOutlet weak var departureView: UIView!
    @IBOutlet weak var departurelbl: UILabel!
    @IBOutlet weak var departureDatelbl: UILabel!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var returnlbl: UILabel!
    @IBOutlet weak var returnDatelbl: UILabel!
    @IBOutlet weak var economyView: UIView!
    @IBOutlet weak var economylbl: UILabel!
    @IBOutlet weak var economyValuelbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var moreExpandView: UIView!
    @IBOutlet weak var moreExpandViewHeight: NSLayoutConstraint!
    @IBOutlet weak var moreOptionsBtn: UIButton!
    @IBOutlet weak var moreBtnHolderView: UIView!
    @IBOutlet weak var timeOutwardJourneyView: UIView!
    @IBOutlet weak var timeOutwardJourneylbl: UILabel!
    @IBOutlet weak var timeOutJourneyValuelbl: UILabel!
    @IBOutlet weak var timeReturnJourneyView: UIView!
    @IBOutlet weak var timeReturnJourneylbl: UILabel!
    @IBOutlet weak var timeReturnJourneyValuelbl: UILabel!
    @IBOutlet weak var airlineView: UIView!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var airlineValuelbl: UILabel!
    @IBOutlet weak var moreOptionImg: UIImageView!
    @IBOutlet weak var moreOptionlbl: UILabel!
    @IBOutlet weak var radio1View: UIView!
    @IBOutlet weak var radioReturnJourneylbl: UILabel!
    @IBOutlet weak var radioImg1: UIImageView!
    @IBOutlet weak var radio2View: UIView!
    @IBOutlet weak var radioDirectFlightlbl: UILabel!
    @IBOutlet weak var radioImg2: UIImageView!
    @IBOutlet weak var searchFlightsBtnView: UIView!
    @IBOutlet weak var searchFlightsBtnlbl: UILabel!
    @IBOutlet weak var searchFlightBtn: UIButton!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var addTraverllersView: UIView!
    @IBOutlet weak var addTraverllerslbl: UILabel!
    @IBOutlet weak var addTraverllersValuelbl: UILabel!
    @IBOutlet weak var addTraverllersBtn: UIButton!
    @IBOutlet weak var addClassView: UIView!
    @IBOutlet weak var addClasslbl: UILabel!
    @IBOutlet weak var addClassValuelbl: UILabel!
    @IBOutlet weak var addClassBtn: UIButton!
    @IBOutlet weak var fromcityTV: UITableView!
    @IBOutlet weak var fromcityTVHeight: NSLayoutConstraint!
    @IBOutlet weak var tocityTV: UITableView!
    @IBOutlet weak var tocityTVHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var fromCloseBtn: UIButton!
    @IBOutlet weak var toCloseBtn: UIButton!
    @IBOutlet weak var returnDateCloseBtn: UIButton!
    
    var cityViewModel: SelectCityViewModel?
    var payload = [String:Any]()
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    var cityNameArray = [String]()
    var txtbool = Bool()
    let timeOfOutwardJourneyDropdown = DropDown()
    let timeOfReturnJourneyDropdown = DropDown()
    var delegate:SearchFlightsTVCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTimeOfOutwardJourneyDropdown()
        setupTimeOfReturnJourneyDropdown()
        cityViewModel = SelectCityViewModel(self)
        
        contentView.backgroundColor = .AppHolderViewColor
        holderView.backgroundColor = .WhiteColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    var timeArray = ["12:00 AM - 06:00 AM",
                     "06:00 AM - 12:00 PM",
                     "12:00 PM - 06:00 PM",
                     "06:00 PM - 12:00 AM"]
    
    override func updateUI() {
        setupTV()
        fromcityTVHeight.constant = 0
        tocityTVHeight.constant = 0
        CallShowCityListAPI(str: "")
        timeOfOutwardJourneyDropdown.dataSource = timeArray
        timeOfReturnJourneyDropdown.dataSource = timeArray
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                fromCitylbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "Origin"
                toCitylbl.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "Destination"
                self.departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "+ Add Departure Date"
                economyValuelbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Traveller Details"
                addTraverllersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Details"
                addClassValuelbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Add Details"
                returnView.alpha = 0.5
                
                returnDatelbl.text = "+ Add Return Date"
                defaults.set("+ Add Return Date", forKey: UserDefaultsKeys.rcalRetDate)
            }else {
                fromCitylbl.text = defaults.string(forKey: UserDefaultsKeys.rfromCity) ?? "Origin"
                toCitylbl.text = defaults.string(forKey: UserDefaultsKeys.rtoCity) ?? "Destination"
                self.departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "+ Add Departure Date"
                self.returnDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "+ Add Return Date"
                economyValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "Add Traveller Details"
                addTraverllersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "Add Details"
                addClassValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Add Details"
                returnView.alpha = 1
            }
        }
        
        setuupLoadLabels(lbl: fromCitylbl, str: "Origin")
        setuupLoadLabels(lbl: toCitylbl, str: "Destination")
        setuupLoadLabels(lbl: self.departureDatelbl, str: "+ Add Departure Date")
        setuupLoadLabels(lbl: self.returnDatelbl, str: "+ Add Return Date")
        setuupLoadLabels(lbl: addTraverllersValuelbl, str: "Add Details")
        setuupLoadLabels(lbl: addClassValuelbl, str: "Add Details")
        
        if fromCitylbl.text?.isEmpty == true {
            fromTF.placeholder = "Origen"
        }
        if toCitylbl.text?.isEmpty == true {
            toTF.placeholder = "Destination"
        }
    }
    
    
    
    
    func setuupLoadLabels(lbl:UILabel,str:String) {
        if lbl.text == str {
            lbl.textColor = .SubTitleColor
        }else {
            lbl.textColor = .AppLabelColor
        }
    }
    
    func setupUI() {
        
        swipeImage.image = UIImage(named: "swipe")
        dropdownImg.image = UIImage(named: "downarrow")
        moreOptionImg.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor)
        
        
        setupViews(v: holderView, radius: 5, color: .WhiteColor)
        setupViews(v: fromView, radius: 4, color: .WhiteColor)
        setupViews(v: toView, radius: 4, color: .WhiteColor)
        setupViews(v: swipeView, radius: 20, color: .WhiteColor)
        setupViews(v: departureView, radius: 4, color: .WhiteColor)
        setupViews(v: returnView, radius: 4, color: .WhiteColor)
        //  setupViews(v: economyView, radius: 4, color: .WhiteColor)
        setupViews(v: moreExpandView, radius: 0, color: .WhiteColor)
        moreExpandView.layer.borderColor = UIColor.clear.cgColor
        setupViews(v: timeOutwardJourneyView, radius: 4, color: .WhiteColor)
        setupViews(v: timeReturnJourneyView, radius: 4, color: .WhiteColor)
        setupViews(v: airlineView, radius: 4, color: .WhiteColor)
        moreExpandViewHeight.constant = 0
        
        setupLabels(lbl: fromlbl, text: "From", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: fromCitylbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: tolbl, text: "To", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: toCitylbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: departurelbl, text: "Departure ", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: departureDatelbl, text: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "+ Add Departur Date", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: returnlbl, text: "Return ", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: returnDatelbl, text: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "+ Add Return Date", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: economylbl, text: "Travellers &  class", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: economyValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        
        
        setupLabels(lbl: timeOutwardJourneylbl, text: "Time Of Outward Journey", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: timeOutJourneyValuelbl, text: "All Times", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: timeReturnJourneylbl, text: "Time Of Return Journey", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: timeReturnJourneyValuelbl, text: "All Times", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: airlinelbl, text: "Airline", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: airlineValuelbl, text: "Airline", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: moreOptionlbl, text: "More search options", textcolor: .AppTabSelectColor, font: .LatoMedium(size: 16))
        moreBtnHolderView.backgroundColor = .clear
        //  moreBtnHolderView.addBottomBorderWithColor(color: .AppTabSelectColor, width: 1)
        
        radio1View.backgroundColor = .clear
        radio2View.backgroundColor = .clear
        radioImg1.image = UIImage(named: "uncheck")
        radioImg2.image = UIImage(named: "uncheck")
        
        setupLabels(lbl: radioReturnJourneylbl, text: "Return journey from another location", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: radioDirectFlightlbl, text: "Direct flights only", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: searchFlightsBtnlbl, text: "Search Flight", textcolor: .WhiteColor, font: .LatoSemibold(size: 20))
        setupViews(v: searchFlightsBtnView, radius: 4, color: .AppBtnColor)
        
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        searchFlightsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        
        searchFlightBtn.setTitle("", for: .normal)
        // returnView.isHidden = true
        
        
        
        fromTF.tag = 1
        fromTF.textColor = .AppLabelColor
        fromTF.font = .LatoSemibold(size: 18)
        fromTF.delegate = self
        fromTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        fromTF.setLeftPaddingPoints(35)
        
        
        
        toBtn.isUserInteractionEnabled = false
        toTF.tag = 2
        toTF.textColor = .AppLabelColor
        toTF.font = .LatoSemibold(size: 18)
        toTF.delegate = self
        toTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        toTF.setLeftPaddingPoints(35)
        
        
        //********************
        fromBtn.isUserInteractionEnabled = true
        toBtn.isUserInteractionEnabled = true
        fromTF.isHidden = false
        toTF.isHidden = false
        //********************
        
        setupViews(v: addTraverllersView, radius: 4, color: .WhiteColor)
        setupViews(v: addClassView, radius: 4, color: .WhiteColor)
        setuplabels(lbl: addTraverllerslbl, text: "Add Travellers", textcolor: .AppLabelColor, font: .LatoLight(size: 14), align: .left)
        setuplabels(lbl: addClasslbl, text: "Add Class", textcolor: .AppLabelColor, font: .LatoLight(size: 14), align: .left)
        setuplabels(lbl: addTraverllersValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        setuplabels(lbl: addClassValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        addTraverllersBtn.setTitle("", for: .normal)
        addClassBtn.setTitle("", for: .normal)
        
        fromlbl.isHidden = true
        tolbl.isHidden = true
        swipeView.isHidden = true
        fromCloseBtn.addTarget(self, action: #selector(didTapOnClearFromTextField(_:)), for: .touchUpInside)
        toCloseBtn.addTarget(self, action: #selector(didTapOnClearToTextField(_:)), for: .touchUpInside)
        returnDateCloseBtn.addTarget(self, action: #selector(didTapOnCloseReturnView(_:)), for: .touchUpInside)
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    func setupTV() {
        fromcityTV.delegate = self
        fromcityTV.dataSource = self
        fromcityTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tocityTV.delegate = self
        tocityTV.dataSource = self
        tocityTV.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    
    @objc func didTapOnClearFromTextField(_ sender:UIButton) {
        fromTF.placeholder = "Origen"
        fromTF.becomeFirstResponder()
        fromCitylbl.text = ""
    }
    
    @objc func didTapOnClearToTextField(_ sender:UIButton) {
        toTF.placeholder = "Destination"
        toTF.becomeFirstResponder()
        toCitylbl.text = ""
    }
    
    
    @objc func didTapOnCloseReturnView(_ sender:UIButton) {
        
        returnDatelbl.text = "+ Add Return Date"
        defaults.set("+ Add Return Date", forKey: UserDefaultsKeys.rcalRetDate)
        delegate?.didTapOnCloseReturnView(cell: self)
    }
    
    
    @IBAction func didTapOnFromCityBtnAction(_ sender: Any) {
        //  delegate?.didTapOnFromCityBtnAction(cell: self)
        //  fromcityTVHeight.constant = CGFloat((cityList.count * 100))
    }
    
    
    @IBAction func didTapOnToCityBtnAction(_ sender: Any) {
        //   delegate?.didTapOnToCityBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSwipeCityBtnAction(_ sender: Any) {
        delegate?.didTapOnSwipeCityBtnAction(cell: self)
    }
    
    @IBAction func didTapOnDepartureBtnAction(_ sender: Any) {
        delegate?.didTapOnDepartureBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnReturnBtnAction(_ sender: Any) {
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                defaults.set("+ Add Return Date", forKey: UserDefaultsKeys.rcalRetDate)
                delegate?.didTapOnReturnToOnewayBtnAction(cell: self)
            }else {
                delegate?.didTapOnReturnBtnAction(cell: self)
            }
        }
        
    }
    
    
    @IBAction func addEconomyBtnAction(_ sender: Any) {
        delegate?.addEconomyBtnAction(cell: self)
    }
    
    @IBAction func moreOptionBtnAction(_ sender: Any) {
        print("moreOptionBtnAction")
        delegate?.moreOptionBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOntimeOutwardJourneyBtnAction(_ sender: Any) {
        timeOfOutwardJourneyDropdown.show()
        delegate?.didTapOntimeOutwardJourneyBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOntimeReturnJourneyBtnAction(_ sender: Any) {
        timeOfReturnJourneyDropdown.show()
        delegate?.didTapOntimeReturnJourneyBtnAction(cell: self)
    }
    
    @IBAction func didTapOnairlineBtnAction(_ sender: Any) {
        delegate?.didTapOnairlineBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnReturnJurneyRadioButton(_ sender: Any) {
        delegate?.didTapOnReturnJurneyRadioButton(cell: self)
    }
    
    
    @IBAction func didTapOnDirectFlightRadioButton(_ sender: Any) {
        delegate?.didTapOnDirectFlightRadioButton(cell: self)
    }
    
    
    @IBAction func didTapOnSearchFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchFlightBtnAction(cell: self)
    }
    
    
    
    @IBAction func addTraverllersBtnAction(_ sender: Any) {
        delegate?.addTraverllersBtnAction(cell: self)
    }
    
    
    
    @IBAction func addClassBtnAction(_ sender: Any) {
        delegate?.addClassBtnAction(cell: self)
    }
    
    
    
    //MARK: - Text Filed Editing Changed
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        
        
        if textField == fromTF {
            txtbool = true
            if textField.text?.isEmpty == true {
                dropDown.hide()
            }else {
                self.fromCitylbl.text = ""
                
                CallShowCityListAPI(str: textField.text ?? "")
                dropDown.show()
            }
        }else {
            txtbool = false
            if textField.text?.isEmpty == true {
                dropDown1.hide()
            }else {
                self.toCitylbl.text = ""
                
                CallShowCityListAPI(str: textField.text ?? "")
                dropDown1.show()
            }
        }
        
        
    }
    
    
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fromTF {
            fromTF.placeholder = "Origen"
            self.fromCitylbl.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            dropDown.show()
            
        }else {
            toTF.placeholder = "Destination"
            self.toCitylbl.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            dropDown1.show()
            
        }
    }
    
    
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    
    
    func ShowCityList(response: [SelectCityModel]) {
        cityList = response
        print(cityList)
        if txtbool == true {
            fromcityTVHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                fromcityTV.reloadData()
            }
        }else {
            tocityTVHeight.constant = CGFloat(cityList.count * 80)
            DispatchQueue.main.async {[self] in
                tocityTV.reloadData()
            }
        }
        
    }
    
    
    
    
    
    //MARK: - setupTimeOfOutwardJourneyDropdown
    func setupTimeOfOutwardJourneyDropdown() {
        
        timeOfOutwardJourneyDropdown.direction = .bottom
        timeOfOutwardJourneyDropdown.backgroundColor = .WhiteColor
        timeOfOutwardJourneyDropdown.anchorView = self.timeOutwardJourneyView
        timeOfOutwardJourneyDropdown.bottomOffset = CGPoint(x: 0, y: self.timeOutwardJourneyView.frame.size.height + 10)
        timeOfOutwardJourneyDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.timeOutJourneyValuelbl.text = item
        }
        
    }
    
    
    //MARK: - setupTimeOfReturnJourneyDropdown
    func setupTimeOfReturnJourneyDropdown() {
        
        timeOfReturnJourneyDropdown.direction = .bottom
        timeOfReturnJourneyDropdown.backgroundColor = .WhiteColor
        timeOfReturnJourneyDropdown.anchorView = self.timeReturnJourneyView
        timeOfReturnJourneyDropdown.bottomOffset = CGPoint(x: 0, y: self.timeReturnJourneyView.frame.size.height + 10)
        timeOfReturnJourneyDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.timeReturnJourneyValuelbl.text = item
        }
        
    }
    
}



extension SearchFlightsTVCell:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if tableView == fromcityTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FromCityTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = cityList[indexPath.row].label
                cell.subTitlelbl.text = cityList[indexPath.row].name
                cell.id = cityList[indexPath.row].id ?? ""
                cell.cityname = cityList[indexPath.row].name ?? ""
                cell.citycode = cityList[indexPath.row].code ?? ""
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? FromCityTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = cityList[indexPath.row].label
                cell.subTitlelbl.text = cityList[indexPath.row].name
                cell.id = cityList[indexPath.row].id ?? ""
                cell.cityname = cityList[indexPath.row].name ?? ""
                cell.citycode = cityList[indexPath.row].code ?? ""
                ccell = cell
            }
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            print(cell.id)
            print(cell.citycode)
            print(cell.cityname)
            
            if tableView == fromcityTV {
                fromCitylbl.text = cityList[indexPath.row].label ?? ""
                fromCitylbl.textColor = .AppLabelColor
                fromTF.text = ""
                fromTF.placeholder = ""
                fromTF.resignFirstResponder()
                toTF.placeholder = "Destination"
                //toTF.becomeFirstResponder()
                
                if let selectedJType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if selectedJType == "circle" {
                        
                        defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.rfromCity)
                        defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.rfromlocid)
                        defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.rfromairport)
                        defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.rfromcityname)
                    }else {
                        defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.fromCity)
                        defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.fromlocid)
                        defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.fromairport)
                        defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.fromcityname)
                        
                    }
                    
                }
                fromcityTVHeight.constant = 0
            }else {
                toCitylbl.text = cityList[indexPath.row].label ?? ""
                toCitylbl.textColor = .AppLabelColor
                toTF.text = ""
                toTF.placeholder = ""
                toTF.resignFirstResponder()
                
                if let selectedJType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if selectedJType == "circle" {
                        
                        defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.rtoCity)
                        defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.rtolocid)
                        defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.rtoairport)
                        defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.rtocityname)
                    }else {
                        defaults.set(cityList[indexPath.row].label ?? "", forKey: UserDefaultsKeys.toCity)
                        defaults.set(cityList[indexPath.row].id ?? "", forKey: UserDefaultsKeys.tolocid)
                        defaults.set("\(cityList[indexPath.row].city ?? "") (\(cityList[indexPath.row].code ?? ""))", forKey: UserDefaultsKeys.toairport)
                        defaults.set(cityList[indexPath.row].city ?? "", forKey: UserDefaultsKeys.tocityname)
                        
                    }
                    
                }
                tocityTVHeight.constant = 0
            }
        }
    }
    
    
    
    
}
