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
    
}
class SearchFlightsTVCell: TableViewCell, SelectCityViewModelProtocal {
    
    
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
    
    
    
    
    var cityViewModel: SelectCityViewModel?
    var payload = [String:Any]()
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    var pastUrls = ["Men", "Women", "Cats", "Dogs", "Children"]
    var autocompleteUrls = [String]()
    var delegate:SearchFlightsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupDropDown()
        setupDropDown1()
        cityViewModel = SelectCityViewModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    override func updateUI() {
        CallShowCityListAPI(str: "")
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                fromCitylbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "Select City"
                toCitylbl.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "Select City"
                self.departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "+ Add Departure Date"
                economyValuelbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Traveller Details"
                
                addTraverllersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Details"
                addClassValuelbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Add Details"

                
                returnView.isHidden = true
            }else {
                fromCitylbl.text = defaults.string(forKey: UserDefaultsKeys.rfromCity) ?? "Select City"
                toCitylbl.text = defaults.string(forKey: UserDefaultsKeys.rtoCity) ?? "Select City"
                self.departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "+ Add Departure Date"
                self.returnDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "+ Add Return Date"
                economyValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "Add Traveller Details"
                
                
                addTraverllersValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "Add Details"
                addClassValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Add Details"
                
                returnView.isHidden = false
            }
        }
        
    }
    
    func setupUI() {
        
        swipeImage.image = UIImage(named: "swipe")
        dropdownImg.image = UIImage(named: "downarrow")
        moreOptionImg.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor)
        
        
        setupViews(v: holderView, radius: 5, color: .WhiteColor)
        setupViews(v: fromView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: toView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: swipeView, radius: 20, color: .AppHolderViewColor)
        setupViews(v: departureView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: returnView, radius: 4, color: .AppHolderViewColor)
      //  setupViews(v: economyView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: moreExpandView, radius: 0, color: .WhiteColor)
        setupViews(v: timeOutwardJourneyView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: timeReturnJourneyView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: airlineView, radius: 4, color: .AppHolderViewColor)
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
        moreBtnHolderView.addBottomBorderWithColor(color: .AppTabSelectColor, width: 1)
        
        radio1View.backgroundColor = .clear
        radio2View.backgroundColor = .clear
        radioImg1.image = UIImage(named: "uncheck")
        radioImg2.image = UIImage(named: "uncheck")
        
        setupLabels(lbl: radioReturnJourneylbl, text: "Return journey from another location", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: radioDirectFlightlbl, text: "Direct flights only", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: searchFlightsBtnlbl, text: "Search Flight", textcolor: .WhiteColor, font: .LatoSemibold(size: 20))
        setupViews(v: searchFlightsBtnView, radius: 4, color: .AppBtnColor)
        
        
        searchFlightBtn.setTitle("", for: .normal)
        returnView.isHidden = true
        
        
        fromBtn.isUserInteractionEnabled = false
        fromTF.tag = 1
        fromTF.textColor = .AppLabelColor
        fromTF.font = .LatoSemibold(size: 18)
        fromTF.delegate = self
        fromTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        
        toBtn.isUserInteractionEnabled = false
        toTF.tag = 2
        toTF.textColor = .AppLabelColor
        toTF.font = .LatoSemibold(size: 18)
        toTF.delegate = self
        toTF.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        
        
        setupViews(v: addTraverllersView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: addClassView, radius: 4, color: .AppHolderViewColor)
        setuplabels(lbl: addTraverllerslbl, text: "Add Travellers", textcolor: .AppLabelColor, font: .LatoLight(size: 14), align: .left)
        setuplabels(lbl: addClasslbl, text: "Add Class", textcolor: .AppLabelColor, font: .LatoLight(size: 14), align: .left)
        
        setuplabels(lbl: addTraverllersValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        setuplabels(lbl: addClassValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        
        addTraverllersBtn.setTitle("", for: .normal)
        addClassBtn.setTitle("", for: .normal)
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
    
    
    
    @IBAction func didTapOnFromCityBtnAction(_ sender: Any) {
        delegate?.didTapOnFromCityBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnToCityBtnAction(_ sender: Any) {
        delegate?.didTapOnToCityBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSwipeCityBtnAction(_ sender: Any) {
        delegate?.didTapOnSwipeCityBtnAction(cell: self)
    }
    
    @IBAction func didTapOnDepartureBtnAction(_ sender: Any) {
        delegate?.didTapOnDepartureBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnReturnBtnAction(_ sender: Any) {
        delegate?.didTapOnReturnBtnAction(cell: self)
    }
    
    
    @IBAction func addEconomyBtnAction(_ sender: Any) {
        delegate?.addEconomyBtnAction(cell: self)
    }
    
    @IBAction func moreOptionBtnAction(_ sender: Any) {
        print("moreOptionBtnAction")
        delegate?.moreOptionBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOntimeOutwardJourneyBtnAction(_ sender: Any) {
        delegate?.didTapOntimeOutwardJourneyBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOntimeReturnJourneyBtnAction(_ sender: Any) {
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
            if textField.text?.isEmpty == true {
                dropDown.hide()
            }else {
                self.fromCitylbl.text = ""
                CallShowCityListAPI(str: textField.text ?? "")
                dropDown.show()
            }
        }else {
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
            
            self.fromCitylbl.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            dropDown.show()
            
        }else {
            
            self.toCitylbl.text = ""
            CallShowCityListAPI(str: textField.text ?? "")
            dropDown1.show()
            
        }
    }
    
    
    func CallShowCityListAPI(str:String) {
        BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/ajax/"
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    
    
    var cityNameArray = [String]()
    func ShowCityList(response: [SelectCityModel]) {
        cityList = response
        cityNameArray.removeAll()
        cityList.forEach { i in
            if cityNameArray.count <= 5 {
                cityNameArray.append("\(i.label ?? "")\n\(i.label ?? "")")
                cityLocId.append(i.id ?? "")
            }
            
        }
        dropDown.dataSource = cityNameArray
        dropDown1.dataSource = cityNameArray
    }
    
    
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.cellHeight = 50
        
        
        
        //      dropDown.cellNib = UINib(nibName: "MyDropDownCell", bundle: nil)
        //        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
        //            guard let cell = cell as? MyDropDownCell else { return }
        //
        //            // can use attrubted string for colored text
        //            cell.myText?.text = cityList[index].name
        //
        //        }
        
        
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.fromBtn
        dropDown.bottomOffset = CGPoint(x: 0, y: fromBtn.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            print(cityList[index].city)
            print(cityList[index].code)
            print(index)
            self?.fromTF.text = ""
            self?.fromCitylbl.text = item
            self?.toTF.becomeFirstResponder()
            
            
            if let selectedJType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if selectedJType == "circle" {
                    
                    defaults.set(cityList[index].label ?? "", forKey: UserDefaultsKeys.rfromCity)
                    defaults.set(cityList[index].id ?? "", forKey: UserDefaultsKeys.rfromlocid)
                    defaults.set("\(cityList[index].city ?? "") (\(cityList[index].code ?? ""))", forKey: UserDefaultsKeys.rfromairport)
                    
                }else {
                    defaults.set(cityList[index].label ?? "", forKey: UserDefaultsKeys.fromCity)
                    defaults.set(cityList[index].id ?? "", forKey: UserDefaultsKeys.fromlocid)
                    defaults.set("\(cityList[index].city ?? "") (\(cityList[index].code ?? ""))", forKey: UserDefaultsKeys.fromairport)
                }
                
            }
            
        }
    }
    
    
    
    func setupDropDown1() {
        
        dropDown1.direction = .bottom
        dropDown1.backgroundColor = .WhiteColor
        dropDown1.anchorView = self.toBtn
        dropDown1.bottomOffset = CGPoint(x: 0, y: toBtn.frame.size.height + 10)
        dropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            
            print(cityList[index].city)
            print(cityList[index].code)
            print(index)
            self?.toTF.text = ""
            self?.toCitylbl.text = item
            self?.toTF.resignFirstResponder()
            
            
            if let selectedJType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if selectedJType == "circle" {
                    
                    defaults.set(cityList[index].label ?? "", forKey: UserDefaultsKeys.rtoCity)
                    defaults.set(cityList[index].id ?? "", forKey: UserDefaultsKeys.rtolocid)
                    defaults.set("\(cityList[index].city ?? "") (\(cityList[index].code ?? ""))", forKey: UserDefaultsKeys.rtoairport)
                    
                }else {
                    defaults.set(cityList[index].label ?? "", forKey: UserDefaultsKeys.toCity)
                    defaults.set(cityList[index].id ?? "", forKey: UserDefaultsKeys.tolocid)
                    defaults.set("\(cityList[index].city ?? "") (\(cityList[index].code ?? ""))", forKey: UserDefaultsKeys.toairport)
                }
                
            }
            
        }
        
        
    }
    
    
    
    
    
    
    
}



