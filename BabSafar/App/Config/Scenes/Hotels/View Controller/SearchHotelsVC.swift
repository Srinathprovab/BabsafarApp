//
//  SearchHotelsVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class SearchHotelsVC: BaseTableVC, TopFlightDetailsViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    var tablerow = [TableRow]()
    static var newInstance: SearchHotelsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchHotelsVC
        return vc
    }
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var viewModel:HotelSearchViewModel?
    var viewmodel1:TopFlightDetailsViewModel?
    var isFromvc = String()
    var countrycode = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        setInitalValues()
        
    }
    
    
    
    func setInitalValues() {
        
        adtArray.removeAll()
        chArray.removeAll()
        
        adtArray.append("2")
        chArray.append("0")
        
        defaults.set("1", forKey: UserDefaultsKeys.roomcount)
        defaults.set("2", forKey: UserDefaultsKeys.hoteladultscount)
        defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
        
        defaults.set("Rooms \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""),Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "")", forKey: UserDefaultsKeys.selectPersons)
        
    }
    
    
  
    
    //MARK: CALL TOP FLIGHT HOTEL DETAILS API FUNCTION
    func callTopFlightsHotelsDetailsAPI() {
        viewmodel1?.callTopFlightsHotelsDetailsAPI(dictParam: [:])
    }
    
    
    func topFlightDetailsImages(response: TopFlightDetailsModel) {
        loderBool = false
        topFlightDetails = response.topFlightDetails ?? []
        topHotelDetails = response.topHotelDetails ?? []
        deailcodelist = response.deail_code_list ?? []
        
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel1 = TopFlightDetailsViewModel(self)
    }
    
    
    func setupUI() {
        if screenHeight < 835 {
            navHeight.constant = 280
        }
        nav.titlelbl.text = "Search Hotels"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.layer.borderWidth = 1
        commonTableView.layer.borderColor = UIColor.AppBorderColor.cgColor
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["SearchHotelTVCell",
                                         "EmptyTVCell",
                                         "TopCityTVCell"])
        
        
        setuptv()
    }
    
    
    func setuptv() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.SearchHotelTVCell))
        tablerow.append(TableRow(height:16,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        callapibool = true
        if isFromvc == "dashboardvc" {
            dismiss(animated: true)
        }else {
            guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            vc.selectedIndex = 0
            self.present(vc, animated: false)
        }
    }
    
    
    
    override func didTapOnSearchHotelCityBtn(cell:SearchHotelTVCell){
        gotoFromCitySearchVC()
    }
    
    override func didTapOnCheckinBtn(cell: SearchHotelTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnCheckoutBtn(cell: SearchHotelTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnAddRoomsAndGuestBtn(cell: SearchHotelTVCell) {
        gotoAddAdultEconomyVC()
    }
    
    override func didTapOnSearchHotelBtn(cell: SearchHotelTVCell) {
        NotificationCenter.default.post(name: NSNotification.Name("resetallFilters"), object: nil)
        payload.removeAll()
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationcityid)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        
        payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        payload["adult"] = adtArray
        payload["child"] = chArray
        
        for roomIndex in 0..<totalRooms {
            if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                var childAges: [String] = Array(repeating: "0", count: numChildren)
                
                if numChildren > 2 {
                    childAges.append("0")
                }
                
                payload["childAge_\(roomIndex + 1)"] = childAges
            }
        }
        
        
        payload["nationality"] = countrycode
        payload["language"] = "english"
        payload["search_source"] = "postman"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "Add City" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil{
            showToast(message: "Enter Hotel or City ")
        }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Add Check In Date" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Add Check Out Date" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }else if defaults.string(forKey: UserDefaultsKeys.roomcount) == "" {
            showToast(message: "Add Rooms For Booking")
        }else if self.countrycode.isEmpty == true {
            showToast(message: "Please Select Nationality.")
        }else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false {
            showToast(message: "Invalid Date")
        }else {
            
            
            do{
                
                let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
                
                print(jsonStringData)
                
                
            }catch{
                print(error.localizedDescription)
            }
            
            gotoSearchHotelsResultVC()
            
        }
    }
    
    func gotoSearchHotelsResultVC(){
        loderBool = true
        callapibool = true
        defaults.set(false, forKey: "hoteltfilteronce")
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.countrycode = self.countrycode
        vc.payload = self.payload
        present(vc, animated: true)
    }
    
    
    func gotoFromCitySearchVC() {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    func gotoAddAdultEconomyVC() {
        //        guard let vc = AddRoomsGuestsVC.newInstance.self else {return}
        guard let vc = AddRoomsVCViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    func gotoCalenderVC() {
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func didTapOnSelectCountryCodeList(cell:SearchHotelTVCell){
        self.countrycode = cell.countryCode
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        // gotoSearchHotelsResultVC()
    }
    
    
}

extension SearchHotelsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reloadTV"), object: nil)
        
    }
    
    
    @objc func reload() {
        setuptv()
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
