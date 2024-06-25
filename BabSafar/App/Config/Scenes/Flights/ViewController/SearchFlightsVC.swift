//
//  SearchFlightsVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class SearchFlightsVC: BaseTableVC {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var leftArrowImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var buttonsHolderView: UIView!
    @IBOutlet weak var oneWayView: UIView!
    @IBOutlet weak var roundTripView: UIView!
    @IBOutlet weak var multiCityView: UIView!
    @IBOutlet weak var oneWaylbl: UILabel!
    @IBOutlet weak var roundTriplbl: UILabel!
    @IBOutlet weak var multiCitylbl: UILabel!
    
    
    //  @IBOutlet weak var frontView: UIView!
    static var newInstance: SearchFlightsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightsVC
        return vc
    }
    
    
    var airlineCode = String()
    var cellIndex = Int()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var viewModel : FlightListViewModel?
    var FlightListArray = [FlightSearchModel]()
    var tablerow = [TableRow]()
    var c1 = String()
    var c2 = String()
    var checkBoxArray = ["Return journey from another location"," Direct flights only"]
    var checkBool = true
    
    var selectArray = [String]()
    var selectArray1 = [String]()
    var moreoptionBool = true
    var calDepDate: String!
    var calRetDate: String!
    var fromdataArray = [[String:Any]]()
    
    
    
    var isfromVc = String()
    override func viewWillAppear(_ animated: Bool) {
        if isfromVc == "dashboard" {
            //  deselectAllInputs()
        }
        
        //  frontView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("calreloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(fromSelectCityVC), name: NSNotification.Name("fromSelectCityVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(topcity(notification:)), name: Notification.Name("topcity"), object: nil)
        
        setupIntialUI()
        
    }
    
    
    func deselectAllInputs() {
        defaults.set("Select City", forKey: UserDefaultsKeys.fromCity)
        defaults.set("Select City", forKey: UserDefaultsKeys.toCity)
        defaults.set("+ Add Departure Date", forKey: UserDefaultsKeys.calDepDate)
        
        
        
        defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
        defaults.set("1", forKey: UserDefaultsKeys.adultCount)
        defaults.set("0", forKey: UserDefaultsKeys.childCount)
        defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
        let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") Children | \(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") Infants | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
        defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
        
        
        
        
    }
    
    @objc func fromSelectCityVC() {
        keyStr = "select"
    }
    
    
    func setupIntialUI(){
        
        if keyStr == "select"  {
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    setupOneWay()
                }else if journeyType == "circle"{
                    setupRoundTrip()
                }else {
                    setupMulticity()
                }
            }
        }else {
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    setupOneWay()
                }else if journeyType == "circle"{
                    setupRoundTrip()
                }else {
                    setupMulticity()
                }
            }
        }
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
        //  viewModel = FlightListViewModel(self)
        
    }
    
    func setupUI() {
        
        if screenHeight > 835 {
            // commonTableView.isScrollEnabled = false
        }
        view.backgroundColor = .white
        holderView.backgroundColor = .AppHolderViewColor
        leftArrowImg.image = UIImage(named: "leftarrow")
        setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupViews(v: buttonsHolderView, radius: 25, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .WhiteColor)
        setupViews(v: roundTripView, radius: 18, color: .WhiteColor)
        setupViews(v: multiCityView, radius: 18, color: .WhiteColor)
        multiCityView.isHidden = true
        setuplabels(lbl:titlelbl,text: "Search Flights", textcolor: .WhiteColor, font: .LatoMedium(size: 20), align: .center)
        setuplabels(lbl:oneWaylbl,text: "One Way", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl:roundTriplbl,text: "Round Trip", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl:multiCitylbl,text: "Multi City", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        commonTableView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 0)
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.backgroundColor = .clear
        commonTableView.registerTVCells(["SearchFlightsTVCell",
                                         "EmptyTVCell",
                                         "TopCityTVCell",
                                         "MultiCityTVCell",
                                         "CheckBoxTVCell",
                                         "ButtonTVCell",
                                         "checkOptionsTVCell"])
        
    }
    
    func setupTV() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.SearchFlightsTVCell))
        tablerow.append(TableRow(title:"Top International Destinations",key: "flights",cellType:.TopCityTVCell))
        tablerow.append(TableRow(height:80,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupMultiCityTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.MultiCityTVCell))
        tablerow.append(TableRow(title:"Return Journey From Another Location",key: "multicity",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Direct Flights Only",key: "multicity",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Search Flights",key: "btn",bgColor:.AppBtnColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        //  tablerow.append(TableRow(title:"Top International Destinations",key: "flights",cellType:.TopCityTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        callapibool = true
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.selectedIndex = 0
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    @IBAction func oneWayBtnAction(_ sender: Any) {
        setupOneWay()
    }
    
    
    @IBAction func roundTripBtnAction(_ sender: Any) {
        setupRoundTrip()
        NotificationCenter.default.post(name: NSNotification.Name("roundtripTap"), object: nil)
    }
    
    @IBAction func multiCityBtnAction(_ sender: Any) {
        setupMulticity()
    }
    
    
    func setupOneWay(){
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        oneWayView.backgroundColor = .AppTabSelectColor
        oneWaylbl.textColor = .WhiteColor
        roundTripView.backgroundColor = .WhiteColor
        roundTriplbl.textColor = .AppLabelColor
        multiCityView.backgroundColor = .WhiteColor
        multiCitylbl.textColor = .AppLabelColor
        setupTV()
    }
    
    func setupRoundTrip(){
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        oneWayView.backgroundColor = .WhiteColor
        oneWaylbl.textColor = .AppLabelColor
        roundTripView.backgroundColor = .AppTabSelectColor
        roundTriplbl.textColor = .WhiteColor
        multiCityView.backgroundColor = .WhiteColor
        multiCitylbl.textColor = .AppLabelColor
       
        setupTV()
    }
    
    func setupMulticity(){
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        oneWayView.backgroundColor = .WhiteColor
        oneWaylbl.textColor = .AppLabelColor
        roundTripView.backgroundColor = .WhiteColor
        roundTriplbl.textColor = .AppLabelColor
        multiCityView.backgroundColor = .AppTabSelectColor
        multiCitylbl.textColor = .WhiteColor
        setupMultiCityTV()
    }
    
    
    override func didTapOnReturnToOnewayBtnAction(cell: SearchFlightsTVCell){
        setupRoundTrip()
        NotificationCenter.default.post(name: NSNotification.Name("roundtripTap"), object: nil)
    }
    
    override func didTapOnCloseReturnView(cell: SearchFlightsTVCell){
        setupOneWay()
    }
    
//    override func didTapOnDepartureBtnAction(cell: SearchFlightsTVCell) {
//        gotoCalenderVC(key: "dep", titleStr: "Departure Date")
//    }
//    
//    override func didTapOnReturnBtnAction(cell: SearchFlightsTVCell) {
//        // gotoCalenderVC(key: "ret", titleStr: "Ruturn Date")
//    }
    
    override func didTapOnFromCityBtnAction(cell: SearchFlightsTVCell) {
        gotoSelectCityVC(str: "From", tokey: "Tooo")
    }
    
    override func didTapOnToCityBtnAction(cell: SearchFlightsTVCell){
        gotoSelectCityVC(str: "To", tokey: "frommm")
    }
    
    override func addEconomyBtnAction(cell: SearchFlightsTVCell) {
        gotoTravellerEconomyVC(str: "traveller")
    }
    
    override func addEconomyBtnAction(cell: MultiCityTVCell) {
        gotoTravellerEconomyVC(str: "traveller")
    }
    
    
    func gotoTravellerEconomyVC(str:String) {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keyString = str
        self.present(vc, animated: true)
    }
    
    
    
    func gotoSelectCityVC(str:String,tokey:String) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = str
        vc.keyStr = "flight"
        vc.tokey = tokey
        self.present(vc, animated: true)
    }
    
    
    func gotoCalenderVC(key:String,titleStr:String) {
        dateSelectKey = key
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = titleStr
        callapibool = true
        self.present(vc, animated: false)
    }
    
    override func moreOptionBtnAction(cell: SearchFlightsTVCell){
        if moreoptionBool == true {
            cell.moreExpandViewHeight.constant = 200
            cell.moreOptionlbl.text = "Advanced Search Options"
            cell.moreOptionImg.image = UIImage(systemName: "minus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor)
            moreoptionBool = false
        }else {
            cell.moreExpandViewHeight.constant = 0
            cell.moreOptionlbl.text = "More search options"
            cell.moreOptionImg.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor)
            moreoptionBool = true
        }
        
        commonTableView.reloadData()
    }
    
    
    override func didTapOnReturnJurneyRadioButton(cell: SearchFlightsTVCell) {
        if checkBool == true {
            selectArray.append("Return journey from another location")
            cell.radioImg1.image = UIImage(named: "check")
            checkBool = false
        }else {
            selectArray.remove(at: selectArray.firstIndex(of: "Return journey from another location") as Any as! Int)
            cell.radioImg1.image = UIImage(named: "uncheck")
            checkBool = true
        }
        
        defaults.set(selectArray.joined(separator:","), forKey: UserDefaultsKeys.select)
    }
    
    
    override func didTapOnDirectFlightRadioButton(cell: SearchFlightsTVCell) {
        if directFlightBool == true {
            selectArray.append("Direct flights only")
            cell.radioImg2.image = UIImage(named: "check")
            directFlightBool = false
        }else {
            selectArray.remove(at: selectArray.firstIndex(of: "Direct flights only") as Any as! Int)
            cell.radioImg2.image = UIImage(named: "uncheck")
            directFlightBool = true
        }
        
        defaults.set(selectArray.joined(separator:","), forKey: UserDefaultsKeys.select)
    }
    
    override func didTapOnFromCityBtn(cell: MultiCityTVCell) {
        gotoSelectCityVC(str: "From", tokey: "Tooo")
    }
    
    override func didTapOnToCityBtn(cell: MultiCityTVCell) {
        gotoSelectCityVC(str: "To", tokey: "frommm")
    }
    
    override func didTapOnDateBtn(cell: MultiCityTVCell) {
        gotoCalenderVC(key: "dep", titleStr: "Departure Date")
    }
    
    override func addTraverllersBtnAction(cell: SearchFlightsTVCell){
        callapibool = false
        gotoTravellerEconomyVC(str: "traveller")
    }
    
    
    override func addClassBtnAction(cell: SearchFlightsTVCell){
        gotoTravellerEconomyVC(str: "class")
    }
    
    
    override func addTraverllersBtnAction(cell: MultiCityTVCell){
        gotoTravellerEconomyVC(str: "traveller")
    }
    
    override func addClassBtnAction(cell: MultiCityTVCell){
        gotoTravellerEconomyVC(str: "class")
    }
    
    
    override func didTapOnairlineBtnAction(cell: MultiCityTVCell) {
        print("didTapOnairlineBtnAction")
    }
    
    override func didTapOntimeReturnJourneyBtnAction(cell: MultiCityTVCell) {
        print("didTapOntimeReturnJourneyBtnAction")
    }
    
    override func didTapOntimeOutwardJourneyBtnAction(cell: MultiCityTVCell) {
        print("didTapOntimeOutwardJourneyBtnAction")
    }
    
    
    override func didTapOnairlineBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOnairlineBtnAction")
    }
    
    override func didTapOntimeReturnJourneyBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOntimeReturnJourneyBtnAction")
    }
    
    override func didTapOntimeOutwardJourneyBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOntimeOutwardJourneyBtnAction")
    }
    
    
    
    override func didTapOnAirlneSelectBtnAction(cell:SearchFlightsTVCell) {
        airlineCode = cell.isoCountryCode
        print(airlineCode)
    }
    
    
    override func didTapOnSearchFlightBtnAction(cell: SearchFlightsTVCell) {
        payload.removeAll()
        loderBool = true
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
                payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
                payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
                payload["infant"] = defaults.string(forKey:UserDefaultsKeys.infantsCount)
                payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.selectClass)
                payload["sector_type"] = "international"
                payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
                payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
                payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
                payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                payload["return"] = ""
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["carrier"] = ""
                payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinecode)
                payload["search_flight"] = "Search"
                payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
                payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
                
                if directFlightBool == false {
                    payload["direct_flight"] = "on"
                }
                
                
                if defaults.string(forKey:UserDefaultsKeys.fromCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.fromCity) == nil{
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.toCity) == nil{
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                    showToast(message: "Please Select Different Citys")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil{
                    showToast(message: "Please Select Departure Date")
                }
                else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                    showToast(message: "Add Class")
                }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
                    showToast(message: "Invalid Date")
                }else{
                    gotoSearchFlightResultVC(payload33: payload)
                }
                
            }else {
                
                
                payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
                payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
                payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
                payload["infant"] = defaults.string(forKey:UserDefaultsKeys.infantsCount)
                payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.selectClass)
                payload["sector_type"] = "international"
                
                payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
                payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
                payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
                payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
                
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                payload["return"] = defaults.string(forKey:UserDefaultsKeys.calRetDate)
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["carrier"] = ""
                payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinecode)
                payload["search_flight"] = "Search"
                payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
                payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
                
                if directFlightBool == false {
                    payload["direct_flight"] = "on"
                }
                
                if defaults.string(forKey:UserDefaultsKeys.fromCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.fromCity) == nil{
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "Select City" || defaults.string(forKey:UserDefaultsKeys.toCity) == nil{
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                    showToast(message: "Please Select Different Citys")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil{
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.calRetDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.calRetDate) == nil{
                    showToast(message: "Please Select Return Date")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == defaults.string(forKey:UserDefaultsKeys.calRetDate) {
                    showToast(message: "Please Select Different Dates")
                }
                else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == nil {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == nil {
                    showToast(message: "Add Class")
                }else if defaults.string(forKey:UserDefaultsKeys.fromCity) == defaults.string(forKey:UserDefaultsKeys.toCity) {
                    showToast(message: "Please Select Different Citys")
                }else if checkDepartureAndReturnDates(payload, p1: "depature", p2: "return") == false {
                    showToast(message: "Invalid Date")
                }else{
                    gotoSearchFlightResultVC(payload33: payload)
                }
                
            }
        }
        
        
    }
    
    
    
    func gotoSearchFlightResultVC(payload33:[String:Any]) {
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        defaults.set(false, forKey: "flightfilteronce")
        vc.isFromVc = "searchvc"
        callapibool = true
        vc.payload = payload33
        self.present(vc, animated: true)
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        loderBool = true
        payload.removeAll()
        payload1.removeAll()
        payload2.removeAll()
        fromdataArray.removeAll()
        
        for (index,_) in fromCityArray.enumerated() {
            
            payload2["from"] = fromCityArray[index]
            payload2["from_loc_id"] = fromlocidArray[index]
            payload2["to"] = toCityArray[index]
            payload2["to_loc_id"] = tolocidArray[index]
            payload2["depature"] = depatureDatesArray[index]
            
            fromdataArray.append(payload2)
        }
        
        
        
        payload["trip_type"] = "multicity"
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1"
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0"
        payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0"
        payload["checkbox-group"] = "on"
        payload["search_flight"] = "Search"
        payload["direct_flight"] = "1"
        payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinecode)
        payload["remngwd"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
        payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["search_source"] = "Postman"
        payload["placeDetails"] = fromdataArray
        
        
        
        
        var showToastMessage: String? = nil
        
        for cityName in fromCityArray {
            if cityName == "" {
                showToastMessage = "Please Select Origin"
                break
            }
        }
        
        if showToastMessage == nil {
            for cityName in toCityArray {
                if cityName == "" {
                    showToastMessage = "Please Select Destination"
                    break
                }
            }
        }
        
        if showToastMessage == nil {
            for date in depatureDatesArray {
                if date == "Date" {
                    showToastMessage = "Please Select Date"
                    break
                }
            }
        }
        
        
        
        if showToastMessage == nil {
            if depatureDatesArray != depatureDatesArray.sorted() {
                showToastMessage = "Please Select Dates in Ascending Order"
            } else if depatureDatesArray.count == 2 && depatureDatesArray[0] == depatureDatesArray[1] {
                showToastMessage = "Please Select Different Dates"
            }
        }
        
        
        
        if let message = showToastMessage {
            showToast(message: message)
        } else {
            do {
                let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
                print(theJSONText ?? "")
                
                payload1["search_params"] = theJSONText
                payload1["user_id"] = "0"
                
                gotoSearchFlightResultVC(payload33: payload1)
                
            }catch let error as NSError{
                print(error.description)
            }
            
        }
    }
    
    
    //MARK: - donedatePicker cancelDatePicker
    override func donedatePicker(cell:SearchFlightsTVCell){
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
            
        }else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.retdepDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.calRetDate)
        }
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:SearchFlightsTVCell){
        self.view.endEditing(true)
    }
    
    override func didTapOnSwipeCityBtnAction(cell: SearchFlightsTVCell) {
        commonTableView.reloadData()
    }
}


extension SearchFlightsVC {
    
    
    //MARK: - topcity Search
    @objc func topcity(notification: Notification) {
        payload.removeAll()
        self.tabBarController?.tabBar.isHidden = true
        loderBool = true
        defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
        if let userinfo = notification.userInfo {
            
            payload["trip_type"] = (userinfo["trip_type"] as? String) ?? ""
            payload["adult"] = "1"
            payload["child"] = "0"
            payload["infant"] = "0"
            payload["v_class"] = (userinfo["airline_class"] as? String) ?? ""
            payload["sector_type"] = "international"
            payload["from"] = (userinfo["fromFlight"] as? String) ?? ""
            payload["from_loc_id"] = (userinfo["from_city"] as? String) ?? ""
            payload["to"] = (userinfo["toFlight"] as? String) ?? ""
            payload["to_loc_id"] = (userinfo["to_city"] as? String) ?? ""
            payload["depature"] = userinfo["travel_date"] as? String ?? ""
            payload["return"] = userinfo["return_date"] as? String ?? ""
            payload["out_jrn"] = "All Times"
            payload["ret_jrn"] = "All Times"
            payload["carrier"] = ""
            payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinecode)
            payload["search_flight"] = "Search"
            payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
            payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
            
            
            defaults.set((userinfo["trip_type"] as? String) ?? "", forKey: UserDefaultsKeys.journeyType)
            
            defaults.set((userinfo["from_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.fromcityname)
            defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.tocityname)
            defaults.set((userinfo["from_city_loc"] as? String) ?? "" , forKey: UserDefaultsKeys.fromairport)
            defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.toairport)
            defaults.set((userinfo["fromFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.fromCity)
            defaults.set((userinfo["toFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.toCity)
            
            
            if (userinfo["trip_type"] as? String) == "oneway" {
                defaults.set((userinfo["travel_date"] as? String) ?? "" , forKey: UserDefaultsKeys.calDepDate)
                defaults.set((userinfo["return_date"] as? String) ?? "" , forKey: UserDefaultsKeys.calRetDate)
            }else {
                defaults.set((userinfo["travel_date"] as? String) ?? "" , forKey: UserDefaultsKeys.calDepDate)
                defaults.set((userinfo["return_date"] as? String) ?? "" , forKey: UserDefaultsKeys.calRetDate)
            }
            
            
            
            gotoSearchFlightResultVC(payload33: payload)
        }
        
    }
}
