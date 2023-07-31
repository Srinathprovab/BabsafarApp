//
//  TravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import CoreData
import FreshchatSDK
import MFSDK



class BookingDetailsVC: BaseTableVC, AllCountryCodeListViewModelDelegate, MBViewModelDelegate, MobileSecureBookingViewModelDelegate, AboutusViewModelDelegate, ProfileDetailsViewModelDelegate, TravellerDeleteViewModelDelegate, TimerManagerDelegate {
   
    
    func travellerDeletedSucess(response: AddTravellerModel) {
        
    }
    
    
    func updateProfileDetails(response: ProfileDetailsModel) {
        
    }
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var navheight: NSLayoutConstraint!
    @IBOutlet weak var BookNowBtnView: UIView!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var sessionTimerView: UIView!
    @IBOutlet weak var sessonlbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var chatBtnView: UIView!
    @IBOutlet weak var dropupimg: UIImageView!
    
    var lastContentOffset: CGFloat = 0
    static var newInstance: BookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    var countryCode = String()
    var nationalityCode = String()
    
    var showMoreBool = true
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var checkBool = false
    var accesskeytp = String()
    var accesskey = String()
    var bookingsource = String()
    var tmpFlightPreBookingId = String()
    var activepaymentoptions = String()
    var totalPrice = Double()
    var appreference = String()
    var totalPrice1 = String()
    
    
    var moreDeatilsViewModel:AboutusViewModel?
    var mbviewmodel:MBViewModel?
    var viewmodel1:MobileSecureBookingViewModel?
    var viewmodel:AllCountryCodeListViewModel?
    var travellerViewModel:TravellerViewModel?
    var profileDetilsVM:ProfileDetailsViewModel?
    var deleteTreavelerVM : TravellerDeleteViewModel?
    var billingCountryCode = String()
    var billingCountryName = String()
    
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var mbRefundable = String()
    var timer: Timer?
    var totalTime = 1
    
    var fnameA = [String]()
    var passengertypeA = [String]()
    var title2A = [String]()
    var mnameA = [String]()
    var lnameA = [String]()
    var dobA = [String]()
    var passportNoA = [String]()
    var countryCodeA = [String]()
    var genderA = [String]()
    var passportexpiryA = [String]()
    var passportissuingcountryA = [String]()
    var middleNameA = [String]()
    var leadPassengerA = [String]()
    var passengerType = String()
    var positionsCount = 0
    var passengertypeArray = [String]()
    var searchTextArray = [String]()
    
    var grand_total_Price = String()
    
   
    
    
    //MARK: -  LOADING FUNCTIONS
    
    
    override func viewWillDisappear(_ animated: Bool) {
        BASE_URL = BASE_URL1
        loderBool = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        chatBtnView.isHidden = true
        hiddenView.isHidden = true
        travelerArray.removeAll()
        searchTextArray.removeAll()
        
        
        countryCode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? ""
        billingCountryCode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? ""
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        
        if screenHeight < 835 {
            navheight.constant = 90
        }
        bookNowlbl.text = totalPrice1
        tablerow.removeAll()
        checkOptionCountArray.removeAll()
        
        NotificationCenter.default.addObserver(self, selector: #selector(contaddTraveller), name: Notification.Name("contaddTraveller"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addAdultsDetails(notification:)), name: NSNotification.Name("addAdultsDetails"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAfterLogin), name: NSNotification.Name("reloadAfterLogin"), object: nil)
        
        
        if callapibool == true {
            holderView.isHidden = true
            callAllAPIS()
        }
        
        
       
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
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        // setupTV()
        self.view.backgroundColor = .WhiteColor
        TimerManager.shared.delegate = self
        
        viewmodel = AllCountryCodeListViewModel(self)
        mbviewmodel = MBViewModel(self)
        viewmodel1 = MobileSecureBookingViewModel(self)
        moreDeatilsViewModel = AboutusViewModel(self)
        profileDetilsVM = ProfileDetailsViewModel(self)
        deleteTreavelerVM = TravellerDeleteViewModel(self)
        
        
    }
    
    
    @objc func contaddTraveller() {
        showToast(message: "Cont Adddddddddd")
    }
    
    //MARK: - reloadAfterLogin
    @objc func reloadAfterLogin() {
        callProfileDetailsAPI()
    }
    
    //MARK: - call Profile Details API
    func callProfileDetailsAPI() {
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        profileDetilsVM?.CallGetProileDetails_API(dictParam: payload)
    }
    
    
    func getProfileDetails(response: ProfileDetailsModel) {
        pdetails = response.data
        
        defaults.set(response.data?.email, forKey: UserDefaultsKeys.useremail)
        defaults.set(response.data?.phone, forKey: UserDefaultsKeys.usermobile)
        
        
        DispatchQueue.main.async {[self] in
            callAllAPIS()
        }
    }
    
    let seconds = 0.1
    func callAllAPIS() {
        MBfd?.removeAll()
        TimerManager.shared.sessionStop()
        
        DispatchQueue.main.async {
            self.callMobilePreProcessingBookingAPI()
        }
        
        
        
    }
    
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        callAllAPIS()
    }
    
    
    //MARK: -call Mobile Pre Processing Booking API
    func callMobilePreProcessingBookingAPI() {
        
        payload.removeAll()
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? 0
        payload["traceId"] = defaults.string(forKey: UserDefaultsKeys.traceId) ?? 0
        mbviewmodel?.CALLPREPROCESSINGBOOKINGAPI(dictParam: payload)
    }
    
    var totalAmountforBooking = String()
    func mobilepreprocessbookingDetails(response: MBModel) {
        
        //        chatBtnView.isHidden = false
        holderView.isHidden = false
        
        accesskey = response.pre_booking_params?.access_key ?? ""
        accesskeytp = response.access_key_tp ?? ""
        bookingsource = response.booking_source ?? ""
        tmpFlightPreBookingId = response.pre_booking_params?.transaction_id ?? ""
        activepaymentoptions = response.active_payment_options?[0] ?? ""
        totalPrice = response.total_price?.rounded() ?? 0.0
        appreference = response.pre_booking_params?.transaction_id ?? ""
        
        
        totalAmountforBooking = response.flight_data?[0].totalPrice ?? "0.0"
        mbSummery = response.flight_data?[0].flight_details?.summery ?? []
        
        
        let i = response.pre_booking_params?.priceDetails
        Adults_Base_Price = String(i?.adultsBasePrice ?? "0.0")
        Adults_Tax_Price = String(i?.adultsTaxPrice ?? "0.0")
        Childs_Base_Price = String(i?.childBasePrice ?? "0.0")
        Childs_Tax_Price = String(i?.childTaxPrice ?? "0.0")
        Infants_Base_Price = String(i?.infantBasePrice ?? "0.0")
        Infants_Tax_Price = String(i?.infantTaxPrice ?? "0.0")
        AdultsTotalPrice = i?.adultsTotalPrice ?? "0"
        ChildTotalPrice = i?.childTotalPrice ?? "0"
        InfantTotalPrice = i?.infantTotalPrice ?? "0"
        sub_total_adult = i?.sub_total_adult ?? "0"
        sub_total_child = i?.sub_total_child ?? "0"
        sub_total_infant = i?.sub_total_infant ?? "0"
        
        bookNowlbl.text = "\(i?.api_currency ?? "")\(i?.grand_total ?? "")"
        grand_total_Price = i?.grand_total ?? ""
        
       // let totalSeconds = abs(response.session_expiry_details?.session_start_time ?? 0)
        TimerManager.shared.totalTime = 900
        TimerManager.shared.startTimer()
        
        DispatchQueue.main.async {
            self.setupTV()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.seconds) {
            self.callGetCointryListAPI()
        }
        
    }
    
    
    //MARK: - Call Get Cointry List API
    func callGetCointryListAPI() {
        viewmodel?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    //MARK:  GetCountryList Response
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
    }
    
    
    //MARK: - addAdultsDetails
    @objc func addAdultsDetails(notification:NSNotification) {
        setupTV()
    }
    
    
    //MARK: - reload commonTableView
    @objc func reload(notification:NSNotification) {
        //  fetchCoreDataValues()
        //  setupTV()
    }
    
    
    func setupUI() {
        
        navBar.titlelbl.text = "Booking Details"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        if screenHeight < 835 {
            navheight.constant = 100
        }
        
        BookNowBtnView.backgroundColor = .AppBtnColor
        setuplabels(lbl: bookNowlbl, text: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):", textcolor: .WhiteColor, font: .LatoBold(size: 18), align: .left)
        setuplabels(lbl: kwdlbl, text: "Proceed To Pay", textcolor: .WhiteColor, font: .LatoBold(size: 18), align: .right)
        bookNowBtn.setTitle("", for: .normal)
        sessionTimerView.isHidden = true
        sessionTimerView.backgroundColor = .WhiteColor
        sessionTimerView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        dropupimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "EmptyTVCell",
                                         "ContactInformationTVCell",
                                         "TravelInsuranceTVCell",
                                         "PriceSummaryTVCell",
                                         "SearchFlightResultTVCell",
                                         "ViewFlightDetailsBtnTVCell",
                                         "UsePromoCodesTVCell",
                                         "AddDeatilsOfTravellerTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "BookFlightDetailsTVCell"])
        
        
    }
    
    
    
    func setupTV() {
        sessionTimerView.isHidden = false
        tablerow.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        tablerow.append(TableRow(title:self.mbRefundable,subTitle: "",moreData: mbSummery,cellType:.BookFlightDetailsTVCell))
        
        
        passengertypeArray.removeAll()
        tablerow.append(TableRow(height:20, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.TotalNoofTravellerTVCell))
        for i in 1...adultsCount {
            positionsCount += 1
            passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfTravellerTVCell)
            searchTextArray.append("Adult \(i)")
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                passengertypeArray.append("Child")
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
                searchTextArray.append("Child \(i)")
            }
        }
        
        if infantsCount != 0 {
            for i in 1...infantsCount {
                positionsCount += 1
                passengertypeArray.append("Infant")
                tablerow.append(TableRow(title:"Infant \(i)",key:"infant",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
                searchTextArray.append("Infant \(i)")
            }
        }
        
        
        passengertypeArray = passengertypeArray.unique()
        
        
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(cellType:.UsePromoCodesTVCell))
        tablerow.append(TableRow(cellType:.PriceSummaryTVCell))
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:50, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
    
    func gotoPopupScreen() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnLoginBtn
    
    override func didTapOnLoginBtn(cell:TDetailsLoginTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isVcFrom = "BookingDetailsVC"
        self.present(vc, animated: true)
        
    }
    
    //MARK: - didTapOnCountryCodeBtn
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        self.nationalityCode = cell.nationalityCode
        self.countryCode = cell.billingCountryCode
        self.billingCountryCode = cell.billingCountryCode
    }
    
    //MARK: - editingTextField
    override func editingTextField(tf:UITextField){
        
        if tf.tag == 1 {
            payemail = tf.text ?? ""
        }else {
            paymobile = tf.text ?? ""
        }
    }
    
    
    //MARK: - didTapOnInsureSkipButton TravelInsuranceTVCell
    override func didTapOnInsureSkipButton(cell: TravelInsuranceTVCell) {
    }
    
    
    
    //MARK: - didTapOnPABtn TravelInsuranceTVCell
    override func didTapOnPABtn(cell: TravelInsuranceTVCell) {
    }
    
    
    
    //MARK: - didTapOnTCBtn TravelInsuranceTVCell
    override func didTapOnTCBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTCBtn")
    }
    
    //MARK: - didTapOnTCBtn TravelInsuranceTVCell =====
    override func didTapOnviewFlifgtDetailsBtn(cell: BookFlightDetailsTVCell) {
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    //MARK: - didTapOnTDBtn TravelInsuranceTVCell
    override func didTapOnTDBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTDBtn")
    }
    
    
    
    //MARK: - didTapOnTC1Btn TravelInsuranceTVCell
    override func didTapOnTC1Btn(cell: TravelInsuranceTVCell) {
        print("didTapOnTC1Btn")
    }
    
    
    //MARK: - didTapOnTD1Btn TravelInsuranceTVCell
    override func didTapOnTD1Btn(cell: TravelInsuranceTVCell) {
        print("didTapOnTD1Btn")
    }
    
    //MARK: - didTapOnShowMoreBtn TravelInsuranceTVCell
    override func didTapOnShowMoreBtn(cell: TravelInsuranceTVCell) {
        if showMoreBool == true {
            cell.showMorelbl.text = "- Show Less"
            cell.optionView.isHidden = false
            cell.optionViewHeight.constant = 100
            showMoreBool = false
        }else {
            cell.showMorelbl.text = "+ Show More"
            cell.optionView.isHidden = true
            cell.optionViewHeight.constant = 0
            showMoreBool = true
        }
        
    }
    
    
    //MARK: - didTapOnYesInsureBtn TravelInsuranceTVCell
    override func didTapOnYesInsureBtn(cell: TravelInsuranceTVCell) {
        cell.radioImg1.image = UIImage(named: "radioSelected")
        cell.radioImg2.image = UIImage(named: "radioUnselected")
    }
    
    
    //MARK: - didTapOnNoInsureBtn TravelInsuranceTVCell
    override func didTapOnNoInsureBtn(cell: TravelInsuranceTVCell) {
        cell.radioImg1.image = UIImage(named: "radioUnselected")
        cell.radioImg2.image = UIImage(named: "radioSelected")
    }
    
    
    //MARK: - didTapOnRemoveTravelInsuranceBtn
    override func didTapOnRemoveTravelInsuranceBtn(cell: PriceSummaryTVCell) {
        print("didTapOnRemoveTravelInsuranceBtn")
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
    
    
    //MARK: - didTapOnEditTraveller
    override func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell){
        gotoAddTravellerOrGuestVC(str: "", key1: "edit", passType: "", id1: cell.travellerId)
    }
    
    
    //MARK: - did Tap On delete Traveller BtnAction
    override func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell){
        commonTableView.reloadData()
    }
    
    func callDeleteOriginAPI(origin1:String) {
        payload.removeAll()
        payload["origin"] = origin1
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        deleteTreavelerVM?.CALL_DELETE_TRAVELLER_DETAILS(dictParam: payload)
    }
    
    
    
    
    //MARK: - didTapOnViewFlightsDetailsBtn
    override func didTapOnViewFlightDetailsButton(cell: ViewFlightDetailsBtnTVCell) {
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnFlightsDetails
    override func didTapOnFlightsDetails(cell:SearchFlightResultTVCell){
        guard let vc = BaggageInfoVC.newInstance.self else {return}
        vc.isVCFrom = "BookingDetailsVC"
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnDropDownBtn
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        self.nationalityCode = cell.nationalityCode
        self.countryCode = cell.billingCountryCode
        self.billingCountryCode = cell.billingCountryCode
    }
    

    //MARK: - DELETING COREDATA OBJECT
    func deleteAllRecords() {
        
        if details.count > 0 {
            for object in details as! [NSManagedObject] {
                context.delete(object )
            }
        }
        
        
        do {
            try context.save()
        } catch {
            print ("There was an error")
        }
        
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
    
    
    
    //MARK: - didTapOnBookNowBtn
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
        loderBool = true
        payload.removeAll()
        payload1.removeAll()
        
        
        
        var callpaymentbool = true
        var matchingCells: [AddDeatilsOfTravellerTVCell] = []
        var fnameCharBool = true
        var lnameCharBool = true
       
        // Replace with the desired search texts
        
        for case let cell as AddDeatilsOfTravellerTVCell in commonTableView.visibleCells {
            if let cellText = cell.titlelbl.text, searchTextArray.contains(cellText) {
                matchingCells.append(cell)
            }
        }
        
        for cell in matchingCells {
            
            if cell.titleTF.text?.isEmpty == true {
                // Textfield is empty
                cell.titleView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
                
            } else {
                // Textfield is not empty
            }
            
            if cell.fnameTF.text?.isEmpty == true {
                // Textfield is empty
                cell.fnameView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
            }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                cell.fnameView.layer.borderColor = UIColor.red.cgColor
                fnameCharBool = false
            }else {
                fnameCharBool = true
            }
            
            if cell.lnameTF.text?.isEmpty == true {
                // Textfield is empty
                cell.lnameView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
            }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                cell.lnameView.layer.borderColor = UIColor.red.cgColor
                lnameCharBool = false
            } else {
                // Textfield is not empty
                lnameCharBool = true
            }
            
            
            if cell.dobTF.text?.isEmpty == true {
                // Textfield is empty
                cell.dobView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
            } else {
                // Textfield is not empty
            }
            
            
            if cell.nationalityTF.text?.isEmpty == true {
                // Textfield is empty
                cell.nationalityView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
            } else {
                // Textfield is not empty
            }
            
            
            
            if cell.passportnoTF.text?.isEmpty == true {
                // Textfield is empty
                cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
            } else {
                // Textfield is not empty
            }
            
            
            if cell.passportIssuingCountryTF.text?.isEmpty == true {
                // Textfield is empty
                cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
            } else {
                // Textfield is not empty
            }
            
            
            if cell.passportExpireDateTF.text?.isEmpty == true {
                // Textfield is empty
                cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
            } else {
                // Textfield is not empty
            }
            
            
            
        }
        
        
        
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        //    let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let genderArray = travelerArray.compactMap({$0.gender})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        let nationalityArray = travelerArray.compactMap({$0.nationality})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
        
        
        
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        payload["access_key"] = accesskey
        payload["access_key_tp"] =  accesskeytp
        payload["insurance_policy_type"] = "0"
        payload["insurance_policy_option"] = "0"
        payload["insurance_policy_cover_type"] = "0"
        payload["insurance_policy_duration"] = "0"
        payload["isInsurance"] = "0"
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["redeem_points_post"] = "1"
        payload["booking_source"] = bookingsource
        payload["promocode_val"] = ""
        payload["promocode_code"] = ""
        payload["mealsAmount"] = "0"
        payload["baggageAmount"] = "0"
        
        payload["passenger_type"] = passengertypeArray
        //   payload["lead_passenger"] = laedpassengerArray
        //  payload["gender"] = genderArray
        payload["passenger_nationality"] = nationalityArray
        payload["name_title"] = mrtitleArray
        payload["first_name"] = firstnameArray
        //     payload["middle_name"] = middlenameArray
        payload["last_name"] = lastNameArray
        payload["date_of_birth"] = dobArray
        payload["passenger_passport_number"] = passportnoArray
        payload["passenger_passport_issuing_country"] = passportIssuingCountryArray
        payload["passenger_passport_expiry"] = passportExpireDateArray
        payload["Frequent"] = [["Select"]]
        payload["ff_no"] = [[""]]
        payload["address2"] = "ecity"
        payload["billing_address_1"] = "DA"
        payload["billing_state"] = "ASDAS"
        payload["billing_city"] = "sdfsd"
        payload["billing_zipcode"] = "sdf"
        
        payload["billing_email"] = payemail
        payload["passenger_contact"] = paymobile
        payload["billing_country"] = self.billingCountryCode
        payload["country_mobile_code"] = self.countryCode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["payment_method"] = activepaymentoptions
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
            
            if callpaymentbool == false {
                showToast(message: "Add Details")
            }else if fnameCharBool == false {
                showToast(message: "First Name Should More Than 3 Chars")
            }else if lnameCharBool == false {
                showToast(message: "Last Name Should More Than 3 Chars")
            }else if payemail == "" {
                showToast(message: "Enter Email Address")
            }else if payemail.isValidEmail() == false {
                showToast(message: "Enter Valid Email Addreess")
            }else if paymobile == "" {
                showToast(message: "Enter Mobile No")
            }else if paymobile.isValidMobileNumber() == false {
                showToast(message: "Enter Valid Mobile No")
            }
            else if self.countryCode == "" {
                showToast(message: "Enter Country Code")
            }else if checkTermsAndCondationStatus == false {
                showToast(message: "Please Accept T&C and Privacy Policy")
            }else {
               
                
//                guard let vc = StartSendPaymentVC.newInstance.self else {return}
//                vc.modalPresentationStyle = .fullScreen
//                vc.payload = payload
//                vc.grandTotalamount = self.totalPrice1
//                vc.grand_total_Price = self.grand_total_Price
//                present(vc, animated: true)
            
            }
            
            
        }catch{
            print(error.localizedDescription)
        }
    }
    

    func gotoPaymentVC() {
        
        guard let vc = PaymentVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.tmpFlightPreBookingId = self.tmpFlightPreBookingId
        vc.accesskey = self.accesskey
        vc.accesskeytp = self.accesskeytp
        vc.bookingsource = self.bookingsource
        vc.email = payemail
        vc.mobile = paymobile
        vc.countryCode = self.countryCode
        present(vc, animated: true)
    }
    
    
    //MARK: mobile process passenger Details
    func mobileprocesspassengerDetails(response: MBPModel) {
        payload.removeAll()
        BASE_URL = ""
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["app_reference"] = response.data?.post_data?.app_reference
        payload["promocode_val"] = response.data?.post_data?.promocode_val
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            mbviewmodel?.Call_mobile_pre_booking_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/mobile_pre_booking")
        }
        
        
    }
    
    
    
    func mobilePreBookingModelDetails(response: MobilePreBookingModel) {
        
        BASE_URL = ""
        payload["search_id"] = response.data?.search_id
        payload["app_reference"] = response.data?.app_reference
        payload["promocode_val"] = response.data?.promocode_val
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            mbviewmodel?.Call_mobile_pre_payment_confirmation_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/mobile_pre_payment_confirmation")
        }
    }
    
    func mobileprepaymentconfirmationDetails(response: MobilePrePaymentModel) {
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            BASE_URL = ""
            mbviewmodel?.Call_mobile_send_to_payment_API(dictParam: [:], url: response.url ?? "")
        }
        
    }
    
    func mobilesendtopaymentDetails(response: MobilePrePaymentModel) {
        
        
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            DispatchQueue.main.async {
                BASE_URL = ""
                self.viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: response.url ?? "")
            }
        }
        
    }
    
    
    func mobilesecurebookingDetails(response: MobilePrePaymentModel) {
        loderBool = false
        if response.status == false {
            showToast(message: response.message ?? "")
        }else {
            guard let vc = LoadWebViewVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.urlString = response.url ?? ""
            vc.isVcFrom = "Booking"
            present(vc, animated: true)
        }
        
        
    }
    
    func mobolePaymentDetails(response: MobilePaymentModel) {
        
    }
    
    
    @IBAction func didTapOnMoveToTopTapBtn(_ sender: Any) {
        //        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        //        self.hiddenView.isHidden = true
    }
    
    
    @IBAction func didTapOnShowChatWindowBtn(_ sender: Any) {
        Freshchat.sharedInstance().showConversations(self)
    }
    
    
    
    //MARK: - AddDeatilsOfTravellerTVCell Delegate Methods
    
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {
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
    
    
    override func tfeditingChanged(tf:UITextField) {
        print(tf.tag)
    }
    
    
    
    override func donedatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
}


