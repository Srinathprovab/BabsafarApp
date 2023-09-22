//
//  ModifySearchFlightVC.swift
//  BabSafar
//
//  Created by FCI on 01/03/23.
//

import UIKit

class ModifySearchFlightVC: BaseTableVC {
    
    
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
    
    
    static var newInstance: ModifySearchFlightVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchFlightVC
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
    var directFlightBool = true
    var selectArray = [String]()
    var selectArray1 = [String]()
    var moreoptionBool = true
    var calDepDate: String!
    var calRetDate: String!
    var key = ""
    var fromdataArray = [[String:Any]]()
  
    
    override func viewWillAppear(_ animated: Bool) {
        //  CallShowCityListAPI(str: "")
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("calreloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(fromSelectCityVC), name: NSNotification.Name("fromSelectCityVC"), object: nil)
        
        setupIntialUI()
        
       
        if key == "edit" {
            setupIntialUI()
        }else {
            setupRoundTrip()
            DispatchQueue.main.async {
                self.gotoCalenderVC(key: "ret", titleStr: "Ruturn Date", isvc: "modify")
            }
        }
        
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
          //  setupRoundTrip()
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
        setupIntialUI()
    }
    
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
        
    }
    
    func setupUI() {
        
        
        
        view.backgroundColor = .black.withAlphaComponent(0.4)
        holderView.backgroundColor = .black.withAlphaComponent(0.4)
        
        //  leftArrowImg.image = UIImage(named: "leftarrow")
        backBtnView.backgroundColor = .clear
        //  setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupViews(v: buttonsHolderView, radius: 25, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .AppTabSelectColor)
        setupViews(v: roundTripView, radius: 18, color: .AppHolderViewColor)
        setupViews(v: multiCityView, radius: 18, color: .AppHolderViewColor)
        
        setuplabels(lbl:titlelbl,text: "Modify Search", textcolor: .WhiteColor, font: .LatoMedium(size: 20), align: .center)
        setuplabels(lbl:oneWaylbl,text: "One Way", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl:roundTriplbl,text: "Round Trip", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl:multiCitylbl,text: "Multi City", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        multiCityView.isHidden = true
        commonTableView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 10)
        
        if screenHeight > 835 {
            commonTableView.isScrollEnabled = false
        }
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
        tablerow.append(TableRow(title:"Search Flights",bgColor:.AppBtnColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
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
        defaults.set(oldjournyType, forKey: UserDefaultsKeys.journeyType)
        dismiss(animated: true)
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
    
    
    override func didTapOnReturnToOnewayBtnAction(cell: SearchFlightsTVCell){
        setupRoundTrip()
        
        gotoCalenderVC(key: "ret", titleStr: "Ruturn Date", isvc: "modify")
    }
    
    override func didTapOnCloseReturnView(cell: SearchFlightsTVCell){
        setupOneWay()
    }
    
    override func didTapOnDepartureBtnAction(cell: SearchFlightsTVCell) {
        gotoCalenderVC(key: "dep", titleStr: "Departure Date", isvc: "modify")
    }
    
    override func didTapOnReturnBtnAction(cell: SearchFlightsTVCell) {
        gotoCalenderVC(key: "ret", titleStr: "Ruturn Date", isvc: "modify")
    }
    
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
    
    
    func gotoCalenderVC(key:String,titleStr:String,isvc:String) {
        dateSelectKey = key
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = titleStr
        vc.isvcfrom = isvc
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
        gotoCalenderVC(key: "dep", titleStr: "Departure Date", isvc: "modify")
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
                payload["psscarrier"] = "ALL"
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
                payload["adult"] = defaults.string(forKey:UserDefaultsKeys.radultCount)
                payload["child"] = defaults.string(forKey:UserDefaultsKeys.rchildCount)
                payload["infant"] = defaults.string(forKey:UserDefaultsKeys.rinfantsCount)
                payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.rselectClass)
                payload["sector_type"] = "international"
                //    payload["from"] = defaults.string(forKey:UserDefaultsKeys.rfromCity)
                //                payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.rfromlocid)
                //                payload["to"] = defaults.string(forKey:UserDefaultsKeys.rtoCity)
                //                payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.rtolocid)
                
                payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
                payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
                payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
                payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
                
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
                payload["return"] = defaults.string(forKey:UserDefaultsKeys.rcalRetDate)
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["carrier"] = ""
                payload["psscarrier"] = "ALL"
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
                }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == nil{
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == nil{
                    showToast(message: "Please Select Return Date")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == defaults.string(forKey:UserDefaultsKeys.rcalRetDate) {
                    showToast(message: "Please Select Different Dates")
                }
                else if defaults.string(forKey:UserDefaultsKeys.rtravellerDetails) == nil {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.rselectClass) == nil {
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
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1"
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0"
        payload["infant"] = defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0"
        payload["checkbox-group"] = "on"
        payload["search_flight"] = "Search"
        payload["direct_flight"] = "1"
        payload["psscarrier"] = "ALL"
        payload["remngwd"] = defaults.string(forKey: UserDefaultsKeys.mselectClass)
        payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.mselectClass)
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
    
    
    
    
}


