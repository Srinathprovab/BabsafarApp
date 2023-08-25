//
//  HotelBookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit
import CoreData

class AddContactAndGuestDetailsVC: BaseTableVC, HotelMBViewModelDelegate, AboutusViewModelDelegate, TimerManagerDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var sessionTimerView: UIView!
    @IBOutlet weak var sessonlbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    var kwdprice = String()
    var mobile = String()
    var email = String()
    var passengercontact = String()
    var countryCode = String()
    var nationalityCode = String()
    var billingCountryCode = String()
    
    var timer: Timer?
    var totalTime = 1
    var tablerow = [TableRow]()
    var checkBool = true
    var hbookingDetails:HMBHotel_Details?
    var roompaxesdetails:[Room_paxes_details]?
    var payload = [String:Any]()
    var bookingsource = String()
    var token = String()
    var vm:HotelMBViewModel?
    var moreDeatilsViewModel:AboutusViewModel?
    
    var adultsCount = Int()
    var childCount = Int()
    
    var fnameA = [String]()
    var passengertypeA = [String]()
    var title2A = [String]()
    var mnameA = [String]()
    var lnameA = [String]()
    
    var passengerType = String()
    var positionsCount = 0
    var passengertypeArray = [String]()
    var searchTextArray = [String]()
    
    
    static var newInstance: AddContactAndGuestDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddContactAndGuestDetailsVC
        return vc
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        BASE_URL = BASE_URL1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if screenHeight < 835 {
            navHeight.constant = 90
        }
        NotificationCenter.default.addObserver(self, selector: #selector(addAdultsDetails(notification:)), name: NSNotification.Name("addAdultsDetails"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatetimer), name: NSNotification.Name("updatetimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name("sessionStop"), object: nil)
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
        
        TimerManager.shared.delegate = self
        
    }
    
    
    @objc func stopTimer() {
        gotoPopupScreen()
    }
    
    @objc func updatetimer(notificatio:UNNotification) {
        
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        setuplabels(lbl: sessonlbl, text: "Your Session Expires In : \(formattedTime)", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        
    }
    
    //MARK: - reload commonTableView
    @objc func reload(notification:NSNotification) {
        commonTableView.reloadData()
    }
    
    
    //MARK: - CALL MOBILE BOOKING API
    func callAPI() {
        
        payload.removeAll()
        TimerManager.shared.sessionStop()
        
        payload["rateKey"] = selectedrRateKeyArray
        payload["search_id"] = hsearchid
        payload["booking_source"] = hbookingsource
        payload["token"] = htoken
        payload["token_key"] = htokenkey
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm?.CALL_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: payload)
        
    }
    
    func hotelMobileBookingDetails(response: HotelMBModel) {
        
        childCount = Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") ?? 0
        holderView.isHidden = false
        hbookingDetails = response.data?.hotel_details
        roompaxesdetails = response.data?.room_paxes_details ?? []
        
        bookingsource = response.data?.booking_source ?? ""
        token = response.data?.token ?? ""
        
        //   let totalSeconds = abs(response.session_expiry_details?.session_start_time ?? 0)
        TimerManager.shared.totalTime = 900
        TimerManager.shared.startTimer()
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
        
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @objc func addAdultsDetails(notification:NSNotification) {
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = HotelMBViewModel(self)
        moreDeatilsViewModel = AboutusViewModel(self)
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Booking Confirmed"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        bookNowView.backgroundColor = .AppBtnColor
        
        setuplabels(lbl: bookNowlbl, text: kwdprice, textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .left)
        setuplabels(lbl: kwdlbl, text: "Pay Now", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .right)
        bookNowBtn.setTitle("", for: .normal)
        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        sessionTimerView.isHidden = true
        sessionTimerView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        
        
        sessionTimerView.backgroundColor = .AppHolderViewColor
        holderView.backgroundColor = .AppHolderViewColor
        commonTableView.backgroundColor = .AppHolderViewColor
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "EmptyTVCell",
                                         "AddAdultTravellerTVCell",
                                         "AddChildTravellerTVCell",
                                         "ContactInformationTVCell",
                                         "AddTravellerTVCell",
                                         "HotelPriceSummaryTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "HotelDetailsTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "AddDeatilsOfGuestTVCell"])
        
        
        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1") ?? 0
        childCount = Int(defaults.string(forKey: UserDefaultsKeys.hchildCount) ?? "0") ?? 0
    }
    
    
    
    func setuptv() {
        
        sessionTimerView.isHidden = false
        
        tablerow.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.userLoggedIn) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        tablerow.append(TableRow(title:hbookingDetails?.name,
                                 subTitle: hbookingDetails?.address,
                                 text: hbookingDetails?.checkIn,
                                 buttonTitle:"\(roompaxesdetails?[0].no_of_adults ?? 0)", image:hbookingDetails?.image,
                                 tempText: hbookingDetails?.checkOut,
                                 tempInfo: "\(roompaxesdetails?[0].no_of_rooms ?? 0)",
                                 cellType:.HotelDetailsTVCell))
        
        
        
        
        
        passengertypeArray.removeAll()
        tablerow.append(TableRow(height:20, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.TotalNoofTravellerTVCell))
        for i in 1...adultsCount {
            positionsCount += 1
            passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfGuestTVCell)
            searchTextArray.append("Adult \(i)")
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                passengertypeArray.append("Child")
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfGuestTVCell))
                searchTextArray.append("Child \(i)")
            }
        }
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(height:10, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Price Summary",
                                 subTitle: "\(roompaxesdetails?.first?.room_name ?? "")",
                                 price: "\(roompaxesdetails?.first?.currency ?? ""):\(roompaxesdetails?.first?.net ?? "")",
                                 key: "\(roompaxesdetails?.first?.currency ?? ""):00000",
                                 text: "\(roompaxesdetails?.first?.no_of_adults ?? 0)",
                                 headerText: "\(roompaxesdetails?.first?.currency ?? ""):00000",
                                 buttonTitle: "Refundable000",
                                 tempText: "\(roompaxesdetails?.first?.no_of_children ?? 0)",
                                 cellType:.HotelPriceSummaryTVCell))
        tablerow.append(TableRow(height:10, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:50, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func timerDidFinish() {
        gotoPopupScreen()
    }
    
    func updateTimer() {
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        setuplabels(lbl: sessonlbl, text: "Your Session Expires In : \(formattedTime)", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
    }
   
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    override func didTapOnLoginBtn(cell:TDetailsLoginTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
    }
    
    override func didTapOnAddAdultBtn(cell:AddTravellerTVCell){
        gotoAddTravellerOrGuestVC(str: "hoteladult")
    }
    override func didTapOnAddChildBtn(cell:AddTravellerTVCell){
        gotoAddTravellerOrGuestVC(str: "hotelchild")
    }
    
    
    func gotoAddTravellerOrGuestVC(str:String) {
        defaults.set(str, forKey: UserDefaultsKeys.travellerTitle)
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    
    func gotoPopupScreen() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    
    
    
    //MARK: - didTapOnCountryCodeBtn
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        self.nationalityCode = cell.nationalityCode
        self.countryCode = cell.countryCodeLbl.text ?? ""
        self.billingCountryCode = cell.isoCountryCode
        print("self.billingCountryCode \(self.billingCountryCode)")
    }
    
    //MARK: - editingTextField
    override func editingTextField(tf:UITextField){
        
        if tf.tag == 1 {
            self.email = tf.text ?? ""
        }else {
            self.mobile = tf.text ?? ""
        }
    }
    
    
    //MARK: - gotoAddTravellerOrGuestVC
    func gotoAddTravellerOrGuestVC(str:String,key1:String,passType:String,id1:String) {
        defaults.set(str, forKey: UserDefaultsKeys.travellerTitle)
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = key1
        vc.passengerType = passType
        vc.id = id1
        self.present(vc, animated: true)
    }
    
    
    
    override func didTapOnAddAdultBtn(cell: AddAdultTravellerTVCell) {
        gotoAddTravellerOrGuestVC(str: "Adult", key1: "add", passType: "1", id1: "")
    }
    
    
    
    override func didTapOnAddChildBtn(cell: AddChildTravellerTVCell) {
        gotoAddTravellerOrGuestVC(str: "Children", key1: "add", passType: "2", id1: "")
    }
    
    
    
    //MARK: - didTapOnDropDownBtn
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        self.nationalityCode = cell.nationalityCode
        self.countryCode = cell.countryCodeLbl.text ?? ""
        self.billingCountryCode = cell.isoCountryCode
        print("self.billingCountryCode \(self.billingCountryCode)")
    }
    
    
    
    //MARK: - did Tap On T&C Action
    
    override func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {
        payload.removeAll()
        BASE_URL = ""
        payload["id"] = "3"
        moreDeatilsViewModel?.CALL_GET_TERMSANDCONDITION_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/cms")
    }
    
    func termsandcobditionDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    func contactDetals(response: ContactUsModel) {
        
    }
    
    func aboutusDetails(response: AboutUsModel) {
        
    }
    
    //MARK: - did Tap On Privacy Policy Action
    override func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {
        payload.removeAll()
        BASE_URL = ""
        payload["id"] = "4"
        moreDeatilsViewModel?.CALL_GET_PRIVICYPOLICY_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/cms")
    }
    
    
    func privacyPolicyDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    
    
    //MARK: - Load URLS of T&C And Privacy Policy
    
    func gotoAboutUsVC(title:String,desc:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.titleString = title
        vc.key1 = "webviewhide"
        vc.desc = desc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        
        payload.removeAll()
        
        var callpaymenthotelbool = true
        var matchingCells: [AddDeatilsOfGuestTVCell] = []
        // Replace with the desired search texts
        
        for case let cell as AddDeatilsOfGuestTVCell in commonTableView.visibleCells {
            if let cellText = cell.titlelbl.text, searchTextArray.contains(cellText) {
                matchingCells.append(cell)
            }
        }
        
        for cell in matchingCells {
            
            if cell.titleTF.text?.isEmpty == true {
                // Textfield is empty
                cell.titleView.layer.borderColor = UIColor.red.cgColor
                callpaymenthotelbool = false
                
            } else {
                // Textfield is not empty
            }
            
            if cell.fnameTF.text?.isEmpty == true {
                // Textfield is empty
                cell.fnameView.layer.borderColor = UIColor.red.cgColor
                callpaymenthotelbool = false
            } else {
                // Textfield is not empty
            }
            
            if cell.lnameTF.text?.isEmpty == true {
                // Textfield is empty
                cell.lnameView.layer.borderColor = UIColor.red.cgColor
                callpaymenthotelbool = false
            } else {
                // Textfield is not empty
            }
            
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        
        
        
        payload.removeAll()
        payload["booking_source"] = bookingsource
        payload["promo_code"] = ""
        payload["token"] = token
        payload["redeem_points_post"] = "0"
        payload["reducing_amount"] = "0"
        payload["reward_usable"] = "0"
        payload["reward_earned"] = "0"
        payload["billing_email"] = self.email
        payload["passenger_contact"] = self.mobile
        payload["first_name"] = firstnameArray
        payload["last_name"] = lastNameArray
        payload["name_title"] = mrtitleArray
        payload["billing_country"] = billingCountryCode
        payload["country_code"] = self.countryCode
        payload["passenger_type"] = passengertypeArray
        payload["user_id"] = "0"
        
        
        
        if billingCountryCode == "" {
            showToast(message: "Enter Country Code")
        }else if callpaymenthotelbool == false{
            showToast(message: "Add Details")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            
            vm?.CALL_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API(dictParam: payload)
        }
        
        
    }
    
    func hotelMobilePreBookingDetails(response: HotelPreBookingModel) {
        
        if response.status == 0 {
            showToast(message: response.msg ?? "")
        }else {
            guard let vc = LoadWebViewVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.urlString = response.data?.post_data?.url ?? ""
            vc.isVcFrom = "Booking"
            present(vc, animated: true)
        }
    }
    
    
    
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfGuestTVCell){
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    
}

extension AddContactAndGuestDetailsVC {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            if let cell = tableView.cellForRow(at: IndexPath(item: 5, section: 0)) as? checkOptionsTVCell {
                if self.checkBool == true {
                    cell.checkImg.image = UIImage(named: "check")
                    self.checkBool = false
                }else {
                    cell.checkImg.image = UIImage(named: "uncheck")
                    self.checkBool = true
                }
                
            }
        }
        
    }
}
