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
    @IBOutlet weak var oneWayBtnView: UIView!
    @IBOutlet weak var oneWayBtnImage: UIImageView!
    @IBOutlet weak var oneWaylbl: UILabel!
    @IBOutlet weak var roundTripBtnView: UIView!
    @IBOutlet weak var roundTripBtnImage: UIImageView!
    @IBOutlet weak var roundTriplbl: UILabel!
    @IBOutlet weak var multiCityBtnView: UIView!
    @IBOutlet weak var multiCityBtnImage: UIImageView!
    @IBOutlet weak var multiCitylbl: UILabel!
    
    
    static var newInstance: SearchFlightsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightsVC
        return vc
    }
    var cellIndex = Int()
    var payload = [String:Any]()
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

    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
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
        
        holderView.backgroundColor = .clear
        leftArrowImg.image = UIImage(named: "leftarrow")
        oneWayBtnImage.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        roundTripBtnImage.image = UIImage(named: "roundtrip")
        multiCityBtnImage.image = UIImage(named: "multicity")
        
        setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupViews(v: buttonsHolderView, radius: 25, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .AppTabSelectColor)
        setupViews(v: roundTripView, radius: 18, color: .AppHolderViewColor)
        setupViews(v: multiCityView, radius: 18, color: .AppHolderViewColor)
        
        setupViews(v: oneWayBtnView, radius: 15, color: .WhiteColor.withAlphaComponent(0.5))
        setupViews(v: roundTripBtnView, radius: 15, color: .WhiteColor)
        setupViews(v: multiCityBtnView, radius: 15, color: .WhiteColor)
        
        
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
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.MultiCityTVCell))
        tablerow.append(TableRow(title:"Return Journey From Another Location",key: "multicity",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Direct Flights Only",key: "multicity",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Search Flights",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
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
        oneWayBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.2)
        oneWaylbl.textColor = .WhiteColor
        oneWayBtnImage.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        roundTripView.backgroundColor = .AppHolderViewColor
        roundTripBtnView.backgroundColor = .WhiteColor
        roundTriplbl.textColor = .AppLabelColor
        roundTripBtnImage.image = UIImage(named: "roundtrip")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        multiCityView.backgroundColor = .AppHolderViewColor
        multiCityBtnView.backgroundColor = .WhiteColor
        multiCitylbl.textColor = .AppLabelColor
        multiCityBtnImage.image = UIImage(named: "multicity")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        setupTV()
    }
    
    
    func setupRoundTrip(){
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        
        oneWayView.backgroundColor = .AppHolderViewColor
        oneWayBtnView.backgroundColor = .WhiteColor
        oneWaylbl.textColor = .AppLabelColor
        oneWayBtnImage.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        roundTripView.backgroundColor = .AppTabSelectColor
        roundTripBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.2)
        roundTriplbl.textColor = .WhiteColor
        roundTripBtnImage.image = UIImage(named: "roundtrip")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        multiCityView.backgroundColor = .AppHolderViewColor
        multiCityBtnView.backgroundColor = .WhiteColor
        multiCitylbl.textColor = .AppLabelColor
        multiCityBtnImage.image = UIImage(named: "multicity")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        setupTV()
    }
    
    func setupMulticity(){
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        
        oneWayView.backgroundColor = .AppHolderViewColor
        oneWayBtnView.backgroundColor = .WhiteColor
        oneWaylbl.textColor = .AppLabelColor
        oneWayBtnImage.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        roundTripView.backgroundColor = .AppHolderViewColor
        roundTripBtnView.backgroundColor = .WhiteColor
        roundTriplbl.textColor = .AppLabelColor
        roundTripBtnImage.image = UIImage(named: "roundtrip")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        multiCityView.backgroundColor = .AppTabSelectColor
        multiCityBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.2)
        multiCitylbl.textColor = .WhiteColor
        multiCityBtnImage.image = UIImage(named: "multicity")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        setupMultiCityTV()
    }
    
    override func didTapOnFromCityBtnAction(cell: SearchFlightsTVCell) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = "From"
        self.present(vc, animated: true)
    }
    
    override func didTapOnToCityBtnAction(cell: SearchFlightsTVCell){
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = "To"
        self.present(vc, animated: true)
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
        dateSelectKey = "dep"
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "Departure Date"
        self.present(vc, animated: true)
    }
    
    override func didTapOnReturnBtnAction(cell: SearchFlightsTVCell) {
        dateSelectKey = "ret"
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "Ruturn Date"
        self.present(vc, animated: true)
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
    
    
    var moreoptionBool = true
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
    
    override func didTapOnairlineBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOnairlineBtnAction")
    }
    
    override func didTapOntimeReturnJourneyBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOntimeReturnJourneyBtnAction")
    }
    
    override func didTapOntimeOutwardJourneyBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOntimeOutwardJourneyBtnAction")
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
    
    
    override func didTapOnairlineBtnAction(cell: MultiCityTVCell) {
        print("didTapOnairlineBtnAction")
    }
    
    override func didTapOntimeReturnJourneyBtnAction(cell: MultiCityTVCell) {
        print("didTapOntimeReturnJourneyBtnAction")
    }
    
    override func didTapOntimeOutwardJourneyBtnAction(cell: MultiCityTVCell) {
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
                    payload["trip_type"] = "oneway"
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
                    payload["user_id"] = "0"
                    
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
                    
                    payload["trip_type"] = "circle"
                    payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
                    payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
                    payload["infant"] = defaults.string(forKey:UserDefaultsKeys.infantsCount)
                    payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.rselectClass)
                    payload["sector_type"] = "international"
                    payload["from"] = defaults.string(forKey:UserDefaultsKeys.rfromCity)
                    payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.rfromlocid)
                    payload["to"] = defaults.string(forKey:UserDefaultsKeys.rtoCity)
                    payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.rtolocid)
                    payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
                    payload["return_date"] = defaults.string(forKey:UserDefaultsKeys.rcalRetDate)
                    payload["out_jrn"] = "All Times"
                    payload["ret_jrn"] = "All Times"
                    payload["carrier"] = ""
                    payload["psscarrier"] = "ALL"
                    payload["search_flight"] = "Search"
                    payload["user_id"] = "0"
                    
                    viewModel?.CallRoundTRipSearchFlightAPI(dictParam: payload)
                    
                }
                
                
            }else {
                
            }
        }
    }
    
    
    
    
    func flightList(response: FlightSearchModel) {
        if response.status == 1 {
            FlightList = response.data?.j_flight_list
            gotoSearchFlightResultVC()
        }
    }
    
    
    func roundTripflightList(response: RoundTripModel) {
        if response.status == 1 {
            RTFlightList = response.data?.j_flight_list
            gotoSearchFlightResultVC()
        }
    }
    
    
    
    func gotoSearchFlightResultVC() {
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.FlightList = self.FlightList
        vc.RTFlightList = self.RTFlightList
        self.present(vc, animated: true)
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        gotoSearchFlightResultVC()
    }
    
}
