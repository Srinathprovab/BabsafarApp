//
//  DashBoardVC.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit
import CoreData
import FreshchatSDK


class DashBoardVC: BaseTableVC, TopFlightDetailsViewModelDelegate, AllCountryCodeListViewModelDelegate {
    
    @IBOutlet weak var banerImage: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var banerView: UIView!
    @IBOutlet weak var selectLangView: UIView!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var langLeftImage: UIImageView!
    @IBOutlet weak var langDropdownImage: UIImageView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var dropupimg: UIImageView!
    @IBOutlet weak var moveUpBtn: UIButton!
    @IBOutlet weak var chatBtnView: UIView!
    
    
    
    var lastContentOffset: CGFloat = 0
    static var newInstance: DashBoardVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? DashBoardVC
        return vc
    }
    
    
    //MARK: - side menu initial setup
    private var sideMenuViewController: SideMenuVC!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    var payload = [String:Any]()
    var viewModel1 : FlightListViewModel?
    
    //MARK: - Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    
    var payload1 = [String:Any]()
    var topHotelvm:HotelSearchViewModel?
    
    //MARK: - LOCAL VARIABLES
    var tabNames = ["Flights","Hotels","Visa"]
    var tabNamesImages = ["flight","hotel","visa"]
    var tableRow = [TableRow]()
    var viewmodel:TopFlightDetailsViewModel?
    var vm:AllCountryCodeListViewModel?
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //        callapibool = false
    }
    
    
    //MARK: - LOADING FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        callCountryListAPI()
        chatBtnView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: Notification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(topcity(notification:)), name: Notification.Name("topcity"), object: nil)
  //      NotificationCenter.default.addObserver(self, selector: #selector(tophotel(notification:)), name: Notification.Name("tophotel"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(somthingwentwrong(notification:)), name: Notification.Name("somthingwentwrong"), object: nil)
        
    }
    
    
    func callCountryListAPI() {
        vm?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
    }
    
    
    
    
    @objc func somthingwentwrong(notification: Notification) {
        // loadView1.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        loderBool = false
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if callapibool == true {
            callApi()
        }
    }
    
    
    //MARK:  viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        viewmodel = TopFlightDetailsViewModel(self)
        //        viewModel1 = FlightListViewModel(self)
        // topHotelvm = HotelSearchViewModel(self)
        vm = AllCountryCodeListViewModel(self)
        
    }
    
    
    
    //MARK: - VIEW SETUP
    func setupUI() {
        
        hiddenView.isHidden = true
        hiddenView.backgroundColor = .AppBtnColor
        hiddenView.addCornerRadiusWithShadow(color: .lightGray, borderColor: .clear, cornerRadius: 4)
        dropupimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        banerView.isHidden = true
        //        loadView1.isHidden = true
        holderView.backgroundColor = .AppHolderViewColor
        banerImage.image = UIImage(named: "baner")
        banerImage.contentMode = .scaleAspectFill
        selectLangView.backgroundColor = .clear
        langLeftImage.image = UIImage(named: "lang")
        langDropdownImage.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        setuplabels(lbl: langLabel, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "", textcolor: .WhiteColor, font: .LatoSemibold(size: 14), align: .center)
        setupMenu()
        
        //MARK: REGISTER TABEL VIEW CELLS
        self.commonTableView.registerTVCells(["SpecialDealsTVCell",
                                              "TopCityTVCell",
                                              "EmptyTVCell",
                                              "SelectModuleTabTVCell"])
        
        
    }
    
    
    
    //MARK: - tophotel Search
    @objc func tophotel(notification: Notification) {
        
        self.tabBarController?.tabBar.isHidden = true
        loderBool = true
        defaults.set("Hotels", forKey: UserDefaultsKeys.dashboardTapSelected)
        payload.removeAll()
        payload1.removeAll()
        if let userinfo = notification.userInfo {
            
            defaults.set((userinfo["city"] as? String) ?? "", forKey: UserDefaultsKeys.locationcity)
            defaults.set((userinfo["hotel_code"] as? String) ?? "", forKey: UserDefaultsKeys.locationcityid)
            defaults.set(convertDateFormat(inputDate: userinfo["check_in"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy") , forKey: UserDefaultsKeys.checkin)
            defaults.set(convertDateFormat(inputDate: userinfo["check_out"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy") , forKey: UserDefaultsKeys.checkout)
            
            
            
            payload["city"] = (userinfo["city"] as? String) ?? ""
            payload["hotel_destination"] = (userinfo["hotel_code"] as? String) ?? ""
            payload["hotel_checkin"] = convertDateFormat(inputDate: userinfo["check_in"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
            payload["hotel_checkout"] = convertDateFormat(inputDate: userinfo["check_out"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
            payload["rooms"] = "1"
            payload["adult"] = ["1"]
            payload["child"] = ["0"]
            payload["childAge_1"] = ["0"]
            payload["nationality"] = "IN"
    
            gotoSearchHotelsResultVC()
        }
    }
    
    
    func gotoSearchHotelsResultVC(){
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.countrycode = ""
        callapibool = true
        vc.payload = self.payload
        present(vc, animated: true)
    }
    
    
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
            payload["depature"] = convertDateFormat(inputDate: userinfo["travel_date"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
            payload["return"] = convertDateFormat(inputDate: userinfo["return_date"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
            payload["out_jrn"] = "All Times"
            payload["ret_jrn"] = "All Times"
            payload["carrier"] = ""
            payload["psscarrier"] = "ALL"
            payload["search_flight"] = "Search"
            payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
            payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
            
            
            defaults.set((userinfo["trip_type"] as? String) ?? "", forKey: UserDefaultsKeys.journeyType)
            
            
            if (userinfo["trip_type"] as? String ?? "") == "oneway" {
                
                defaults.set((userinfo["from_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.fromcityname)
                defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.tocityname)
                defaults.set((userinfo["from_city_loc"] as? String) ?? "" , forKey: UserDefaultsKeys.fromairport)
                defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.toairport)
                //  viewModel1?.CallSearchFlightAPI(dictParam: payload)
                
                defaults.set((userinfo["fromFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.fromCity)
                defaults.set((userinfo["toFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.toCity)
                
                
                
            }else {
                defaults.set((userinfo["from_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.rfromcityname)
                defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.rtocityname)
                defaults.set((userinfo["from_city_loc"] as? String) ?? "" , forKey: UserDefaultsKeys.rfromairport)
                defaults.set((userinfo["to_city_loc"] as? String) ?? "" , forKey: UserDefaultsKeys.rtoairport)
                //   viewModel1?.CallRoundTRipSearchFlightAPI(dictParam: payload)
                
                defaults.set((userinfo["fromFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.rfromCity)
                defaults.set((userinfo["toFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.rtoCity)
                
            }
            
            
            gotoSearchFlightResultVC()
        }
        
    }
    
    
    
    func gotoSearchFlightResultVC() {
        loderBool = true
        self.tabBarController?.tabBar.isHidden = false
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.payload = self.payload
        callapibool = true
        self.present(vc, animated: false)
    }
    
    
    
    func callApi() {
        
        adtArray.removeAll()
        chArray.removeAll()
        adtArray.append("1")
        chArray.append("0")
        
        DispatchQueue.main.async {
            self.callTopFlightsHotelsDetailsAPI()
        }
        
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("+965", forKey: UserDefaultsKeys.mobilecountrycode)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.gotoPrivacyScreen()
            }
            defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
            defaults.set(0, forKey: UserDefaultsKeys.DashboardTapSelectedCellIndex)
            defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
            defaults.set(0, forKey: UserDefaultsKeys.journeyTypeSelectedIndex)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("EN", forKey: UserDefaultsKeys.APILanguageType)
            langLabel.text = "KWD"
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") Children | \(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") Infants | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.rselectClass)
            defaults.set("1", forKey: UserDefaultsKeys.radultCount)
            defaults.set("0", forKey: UserDefaultsKeys.rchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.rinfantsCount)
            let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "") Children | \(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "") Infants |\(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
            defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.rtravellerDetails)
            
            
            defaults.set("Economy", forKey: UserDefaultsKeys.mselectClass)
            defaults.set("1", forKey: UserDefaultsKeys.madultCount)
            defaults.set("0", forKey: UserDefaultsKeys.mchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.minfantsCount)
            let totaltraverlers3 = "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "") Children | \(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "") Infants |\(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
            defaults.set(totaltraverlers3, forKey: UserDefaultsKeys.mtravellerDetails)
            
            
            
            //Hotel default Values
            defaults.set("1", forKey: UserDefaultsKeys.roomcount)
            defaults.set("1", forKey: UserDefaultsKeys.hoteladultscount)
            defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
            defaults.set("\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Rooms,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "") Childreen", forKey: UserDefaultsKeys.selectPersons)
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        callApi()
    }
    
    
    
    //MARK: - RELOAD TABLE VIEW
    @objc func reload(notification: Notification) {
        commonTableView.reloadData()
    }
    
    
    //MARK: CALL TOP FLIGHT HOTEL DETAILS API FUNCTION
    func callTopFlightsHotelsDetailsAPI() {
        viewmodel?.callTopFlightsHotelsDetailsAPI(dictParam: [:])
    }
    
    //MARK: CALL TOP FLIGHT DETAILS IMAGES API FUNCTION
    func topFlightDetailsImages(response: TopFlightDetailsModel) {
        topFlightDetails = response.topFlightDetails ?? []
        topHotelDetails = response.topHotelDetails ?? []
        deailcodelist = response.deail_code_list ?? []
        chatBtnView.isHidden = false
        DispatchQueue.main.async {[self] in
            setupTV()
        }
        
    }
    
    
    //MARK: SETUP INITIAL TABLEVIEW CELLS
    func setupTV() {
        tableRow.removeAll()
        tableRow.append(TableRow(cellType:.SelectModuleTabTVCell))
        tableRow.append(TableRow(title:"Top International Destinations",key: "flights",cellType:.TopCityTVCell))
        tableRow.append(TableRow(title:"Top International Hotels",key: "hotels",cellType:.TopCityTVCell))
        tableRow.append(TableRow(height:10,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        tableRow.append(TableRow(cellType:.SpecialDealsTVCell))
        tableRow.append(TableRow(height:30,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    //MARK: GOTO PRIVACY SETUP SCREEN
    func gotoPrivacyScreen() {
        guard let vc = YourPrivacyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    //MARK: GOTO SEARCH FLIGHT SCREEN
    func gotoSearchFlightScreen() {
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        keyStr = "search"
        vc.isfromVc = "dashboardvc"
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: GO TO VISA ENQUIREY SCREEN
    func gotoVisaEnduiryVC() {
        guard let vc = VisaEnduiryVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: GOTO SEARCH HOTEL SCREEN
    func gotoSearchHotelsVC() {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isFromvc = "dashboardvc"
        callapibool = true
        self.present(vc, animated: true)
    }
    
    //MARK: SELECT CURRENCY TYPE
    @IBAction func selectLangButtonAction(_ sender: Any) {
        
    }
    
    override func didTapOnCurrencyBtn(cell:SelectModuleTabTVCell){
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: TAP ON FLIGHT TAB
    override func didTapOnFlightBtnAction(cell: SelectModuleTabTVCell) {
        defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
        gotoSearchFlightScreen()
    }
    
    //MARK: TAP ON HOTEL TAB
    override func didTapOnHotelBtnAction(cell: SelectModuleTabTVCell) {
        defaults.set("Hotels", forKey: UserDefaultsKeys.dashboardTapSelected)
        gotoSearchHotelsVC()
    }
    
    //MARK: TAP ON VISA TAB
    override func didTapOnVisaBtnAction(cell: SelectModuleTabTVCell) {
        defaults.set("Visa", forKey: UserDefaultsKeys.dashboardTapSelected)
        gotoVisaEnduiryVC()
    }
    
    
    override func didTapOnMenuBtn(cell:SelectModuleTabTVCell){
        NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
        self.tabBarController?.tabBar.isHidden = true
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    
    
    
    //MARK: - scrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > self.lastContentOffset {
            // scrolling down
            if self.hiddenView.alpha == 1 {
                UIView.animate(withDuration: 0.3) {
                    self.hiddenView.alpha = 0
                    self.hiddenView.isHidden = true
                }
            }
        } else if scrollView.contentOffset.y < self.lastContentOffset {
            // scrolling up
            if self.hiddenView.alpha == 0 {
                UIView.animate(withDuration: 0.3) {
                    self.hiddenView.alpha = 1
                    self.hiddenView.isHidden = false
                }
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    
    
    @IBAction func didTapOnMoveUpScreenBtn(_ sender: Any) {
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        self.hiddenView.isHidden = true
    }
    
    
    
    @IBAction func didTapOnFreshChatOpenBtnAction(_ sender: Any) {
        Freshchat.sharedInstance().showConversations(self)
    }
    
    
    
    
    //MARK: SETUP SIDE MENU
    func setupMenu(){
        
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth + 50),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK: Keep the state of the side menu (expanded or collapse) in rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            //MARK: When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
            self.tabBarController?.tabBar.isHidden = true
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
            
        }
        else {
            self.tabBarController?.tabBar.isHidden = false
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    
    
}




extension DashBoardVC: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}
