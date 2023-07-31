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
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
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
        if screenHeight < 835 {
            tableViewTopConstraint.constant = 110
        }
        
        //  callTopFlightsHotelsDetailsAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
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
        nav.titlelbl.text = "Search Hotels"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["SearchHotelTVCell",
                                         "EmptyTVCell",
                                         "TopCityTVCell"])
        
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("reload"), object: nil)
        setuptv()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        commonTableView.reloadData()
    }
    
    func setuptv() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.SearchHotelTVCell))
        tablerow.append(TableRow(height:16,cellType:.EmptyTVCell))
        //  tablerow.append(TableRow(title:"Top International Hotels",key: "hotels",cellType:.TopCityTVCell))
        
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
        
        
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationcityid)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        payload["adult"] = adtArray
        payload["child"] = chArray
        payload["childAge_1"] = ["0"]
        payload["nationality"] = countrycode
        
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
            gotoSearchHotelsResultVC()
        }
    }
    
    func gotoSearchHotelsResultVC(){
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.countrycode = self.countrycode
        callapibool = true
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
