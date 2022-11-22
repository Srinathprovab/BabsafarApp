//
//  SearchFlightsVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire

class SearchFlightsVC: BaseTableVC,FlightListModelProtocal {
    
    
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
    
    
    static var newInstance: SearchFlightsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightsVC
        return vc
    }
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
    var checkBool1 = true
    var selectArray = [String]()
    var selectArray1 = [String]()
    var FlightList :[[J_flight_list]]?
    var RTFlightList :[[RTJ_flight_list]]?
    var MCJflightlist :[MCJ_flight_list]?
   
    var moreoptionBool = true
    
    
    
    override func viewWillAppear(_ animated: Bool) {
      //  CallShowCityListAPI(str: "")
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
      
        if let selectedJType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedJType == "multicity" {
                setupMulticity()
            }else if selectedJType == "circle" {
                setupRoundTrip()
            }else {
                setupOneWay()
            }
            
        }
    }
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
        viewModel = FlightListViewModel(self)
    }
    
    func setupUI() {
        
        view.backgroundColor = .white
        holderView.backgroundColor = .clear
        commonTableView.backgroundColor = .clear
        
        leftArrowImg.image = UIImage(named: "leftarrow")
        setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupViews(v: buttonsHolderView, radius: 25, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .AppTabSelectColor)
        setupViews(v: roundTripView, radius: 18, color: .AppHolderViewColor)
        setupViews(v: multiCityView, radius: 18, color: .AppHolderViewColor)
        
        setupLabels(lbl:titlelbl,text: "Search Flights", textcolor: .WhiteColor, font: .LatoMedium(size: 20))
        setupLabels(lbl:oneWaylbl,text: "One Way", textcolor: .WhiteColor, font: .LatoRegular(size: 14))
        setupLabels(lbl:roundTriplbl,text: "Round Trip", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl:multiCitylbl,text: "Multi City", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
        commonTableView.registerTVCells(["SearchFlightsTVCell","EmptyTVCell","TopAirlinesTVCell","MultiCityTVCell","CheckBoxTVCell","ButtonTVCell","checkOptionsTVCell"])
        
    }
    
    func setupTV() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.SearchFlightsTVCell))
        tablerow.append(TableRow(title:"Top airlines",cellType:.TopAirlinesTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupMultiCityTV() {
        tablerow.removeAll()
        
        commonTableView.layer.borderWidth = 1
        commonTableView.layer.borderColor = UIColor.AppBorderColor.cgColor
        commonTableView.layer.cornerRadius = 5
        commonTableView.clipsToBounds = true
        
        tablerow.append(TableRow(cellType:.MultiCityTVCell))
        tablerow.append(TableRow(title:"Return Journey From Another Location",key: "multicity",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Direct Flights Only",key: "multicity",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Search Flights",cellType:.ButtonTVCell))
        
        //        tablerow.append(TableRow(title:"Top airlines",cellType:.TopAirlinesTVCell))
        //        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
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
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
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
    }
    
    @IBAction func multiCityBtnAction(_ sender: Any) {
        setupMulticity()
    }
    
    
    func setupOneWay(){
        
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        
        oneWayView.backgroundColor = .AppTabSelectColor
        oneWaylbl.textColor = .WhiteColor
        roundTripView.backgroundColor = .AppHolderViewColor
        roundTriplbl.textColor = .AppLabelColor
        multiCityView.backgroundColor = .AppHolderViewColor
        multiCitylbl.textColor = .AppLabelColor
        setupTV()
    }
    
    func setupRoundTrip(){
        
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        oneWayView.backgroundColor = .AppHolderViewColor
        oneWaylbl.textColor = .AppLabelColor
        roundTripView.backgroundColor = .AppTabSelectColor
        roundTriplbl.textColor = .WhiteColor
        multiCityView.backgroundColor = .AppHolderViewColor
        multiCitylbl.textColor = .AppLabelColor
        setupTV()
    }
    
    func setupMulticity(){
        
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        oneWayView.backgroundColor = .AppHolderViewColor
        oneWaylbl.textColor = .AppLabelColor
        roundTripView.backgroundColor = .AppHolderViewColor
        roundTriplbl.textColor = .AppLabelColor
        multiCityView.backgroundColor = .AppTabSelectColor
        multiCitylbl.textColor = .WhiteColor
        setupMultiCityTV()
    }
    
    
    override func didTapOnSwipeCityBtnAction(cell: SearchFlightsTVCell) {
        c1 = cell.fromCitylbl.text ?? ""
        c2 = cell.toCitylbl.text ?? ""
        cell.fromCitylbl.text = c2
        cell.toCitylbl.text = c1
        
        defaults.set(cell.fromCitylbl.text ?? "", forKey: UserDefaultsKeys.fromCity)
        defaults.set(cell.toCitylbl.text ?? "", forKey: UserDefaultsKeys.toCity)
    }
    
    override func didTapOnDepartureBtnAction(cell: SearchFlightsTVCell) {
        gotoCalenderVC(key: "dep", titleStr: "Departure Date")
        
    }
    
    override func didTapOnReturnBtnAction(cell: SearchFlightsTVCell) {
        gotoCalenderVC(key: "ret", titleStr: "Ruturn Date")
    }
    
    override func didTapOnFromCityBtnAction(cell: SearchFlightsTVCell) {
        gotoSelectFromCityVC(titleStr: "From")
    }
    
    override func didTapOnToCityBtnAction(cell: SearchFlightsTVCell){
        gotoSelectFromCityVC(titleStr: "To")
    }
    
    
    override func addEconomyBtnAction(cell: SearchFlightsTVCell) {
        gotoTravellerEconomyVC()
    }
    
    override func addEconomyBtnAction(cell: MultiCityTVCell) {
        gotoTravellerEconomyVC()
    }
    
    
    func gotoTravellerEconomyVC() {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keyString = "flights"
        self.present(vc, animated: true)
    }
    
    
    func gotoSelectFromCityVC(titleStr:String) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = titleStr
        self.present(vc, animated: true)
    }
    
    
    func gotoCalenderVC(key:String,titleStr:String) {
        dateSelectKey = key
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = titleStr
        self.present(vc, animated: true)
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
        
        if checkBool1 == true {
            selectArray.append("Direct flights only")
            cell.radioImg2.image = UIImage(named: "check")
            checkBool1 = false
        }else {
            selectArray.remove(at: selectArray.firstIndex(of: "Direct flights only") as Any as! Int)
            cell.radioImg2.image = UIImage(named: "uncheck")
            checkBool1 = true
        }
        
        defaults.set(selectArray.joined(separator:","), forKey: UserDefaultsKeys.select)
    }
    
    override func didTapOnFromCityBtn(cell: MultiCityTVCell) {
        gotoSelectFromCityVC(titleStr: "From")
    }
    
    override func didTapOnToCityBtn(cell: MultiCityTVCell) {
        gotoSelectFromCityVC(titleStr: "To")
    }
    
    override func didTapOnDateBtn(cell: MultiCityTVCell) {
        gotoCalenderVC(key: "dep", titleStr: "Departure Date")
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
    
    
    
    
    override func didTapOnSearchFlightBtnAction(cell: SearchFlightsTVCell) {
        payload.removeAll()
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                if defaults.string(forKey:UserDefaultsKeys.fromCity) == nil {
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == nil {
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil {
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == nil {
                    showToast(message: "Add Traveller")
                }else{
                    
                    BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"
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
                    payload["psscarrier"] = "ALL"
                    payload["search_flight"] = "Search"
                    payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
                    
                    viewModel?.CallSearchFlightAPI(dictParam: payload)
                    
                }
                
            }else if journeyType == "circle"{
                
                
                if defaults.string(forKey:UserDefaultsKeys.rfromCity) == nil {
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.rtoCity) == nil {
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == nil {
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == nil {
                    showToast(message: "Please Select Return Date")
                }else if defaults.string(forKey:UserDefaultsKeys.rtravellerDetails) == nil {
                    showToast(message: "Add Traveller")
                }else{
                    
                    BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"
                    payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
                    payload["adult"] = defaults.string(forKey:UserDefaultsKeys.radultCount)
                    payload["child"] = defaults.string(forKey:UserDefaultsKeys.rchildCount)
                    payload["infant"] = defaults.string(forKey:UserDefaultsKeys.rinfantsCount)
                    payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.rselectClass)
                    payload["sector_type"] = "international"
                    payload["from"] = defaults.string(forKey:UserDefaultsKeys.rfromCity)
                    payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.rfromlocid)
                    payload["to"] = defaults.string(forKey:UserDefaultsKeys.rtoCity)
                    payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.rtolocid)
                    payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
                    payload["return"] = defaults.string(forKey:UserDefaultsKeys.rcalRetDate)
                    payload["out_jrn"] = "All Times"
                    payload["ret_jrn"] = "All Times"
                    payload["carrier"] = ""
                    payload["psscarrier"] = "ALL"
                    payload["search_flight"] = "Search"
                    payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
    
                    viewModel?.CallRoundTRipSearchFlightAPI(dictParam: payload)
                
                }
                
                
            }else {
                
                
            }
        }
    }
    
    
    func flightList(response: FlightSearchModel) {
        if response.status == 1 {
            FlightList = response.data?.j_flight_list
            defaults.set(response.data?.search_id, forKey: UserDefaultsKeys.searchid)
            gotoSearchFlightResultVC()
        }
    }
    
    
    func roundTripflightList(response: RoundTripModel) {
        if response.status == 1 {
            RTFlightList = response.data?.j_flight_list
            defaults.set(response.data?.search_id, forKey: UserDefaultsKeys.searchid)
            gotoSearchFlightResultVC()
        }
    }
    
    func gotoSearchFlightResultVC() {
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.FlightList = self.FlightList
        vc.RTFlightList = self.RTFlightList
        vc.MCJflightlist = self.MCJflightlist
        self.present(vc, animated: true)
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
      
        
        payload["sector_type"] = "international"
        payload["trip_type"] = "multicity"
        payload["from"] = fromCityArray
        payload["from_loc_id"] = fromlocidArray
        payload["to"] = toCityArray
        payload["to_loc_id"] = tolocidArray
        payload["depature"] = depatureDatesArray
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.madultCount)
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.mchildCount)
        payload["infant"] = defaults.string(forKey: UserDefaultsKeys.minfantsCount)
        payload["checkbox-group"] = "on"
        payload["search_flight"] = "Search"
        payload["carrier"] = ""
        payload["psscarrier"] = "ALL"
        payload["remngwd"] = defaults.string(forKey: UserDefaultsKeys.mselectClass)
        payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.mselectClass)
        payload["user_id"] = "0"
        
        do {
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            
            payload1["search_params"] = theJSONText
            payload1["user_id"] = "0"
            
            
            BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"
            viewModel?.CallMulticityTripSearchFlightAPI(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    
    func multiTripflightList(response: MulticityModel) {
        print("====== MulticityModel response ========")
        print(response.data?.search_id)
        
        if response.status == 1 {
            self.MCJflightlist = response.data?.j_flight_list
            defaults.set(response.data?.search_id, forKey: UserDefaultsKeys.searchid)
            gotoSearchFlightResultVC()
        }
    }
    
    
    
    
    
   
}
