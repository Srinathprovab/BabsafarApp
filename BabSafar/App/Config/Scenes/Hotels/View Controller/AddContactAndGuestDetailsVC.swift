//
//  HotelBookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit
import CoreData

class AddContactAndGuestDetailsVC: BaseTableVC, HotelMBViewModelDelegate, AboutusViewModelDelegate {
    
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var sessionTimerView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
    var kwdprice = String()
    var mobile = String()
    var email = String()
    var passengercontact = String()
    var countryCode = String()
    var nationalityCode = String()
    var billingCountryCode = String()
    
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
    
    var childCount = Int()
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
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
    }
    
    //MARK: - reload commonTableView
    @objc func reload(notification:NSNotification) {
        commonTableView.reloadData()
    }
    
    
    //MARK: - CALL MOBILE BOOKING API
    func callAPI() {
        
        payload.removeAll()
        
        payload["rateKey"] = rateKeyArray
        payload["search_id"] = hsearchid
        payload["booking_source"] = hbookingsource
        payload["token"] = htoken
        payload["token_key"] = htokenkey
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm?.CALL_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: payload)
        
    }
    
    func hotelMobileBookingDetails(response: HotelMBModel) {
        print(" ====== hotelMobileBookingDetails ==== \(response)")
        
        childCount = Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") ?? 0
        holderView.isHidden = false
        hbookingDetails = response.data?.hotel_details
        roompaxesdetails = response.data?.room_paxes_details ?? []
        
        bookingsource = response.data?.booking_source ?? ""
        token = response.data?.token ?? ""
        
        
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
        
        DispatchQueue.main.async {[self] in
            fetchCoreDataValues()
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
        setuplabels(lbl: titlelbl, text: "Your Session Expires In : ", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
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
                                         "HotelDetailsTVCell"])
        
        
    }
    
    
    
    func setuptv() {
        
        sessionTimerView.isHidden = false
        startTimer()
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
        
        
        
        
        
        tablerow.append(TableRow(cellType:.AddAdultTravellerTVCell))
        if childCount != 0 {
            tablerow.append(TableRow(cellType:.AddChildTravellerTVCell))
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
    
    //    override func didTapOnEditAdultBtn(cell:AddTravellerTVCell){
    //        gotoAddTravellerOrGuestVC(str: "hoteladultedit")
    //    }
    //    override func didTapOnEditChildtBtn(cell:AddTravellerTVCell){
    //        gotoAddTravellerOrGuestVC(str: "hotelchildedit")
    //    }
    
    func gotoAddTravellerOrGuestVC(str:String) {
        defaults.set(str, forKey: UserDefaultsKeys.travellerTitle)
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    //MARK: - Timer functions
    
    func sessionStop() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    func startTimer() {
        self.totalTime = 1400
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        self.subtitlelbl.text = self.timeFormatted(self.totalTime) // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                sessionStop()
                gotoPopupScreen()
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
        self.billingCountryCode = cell.billingCountryCode
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
        self.billingCountryCode = cell.billingCountryCode
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
        
        //        fnameA.removeAll()
        //        passengertypeA.removeAll()
        //        title2A.removeAll()
        //        mnameA.removeAll()
        //        dobA.removeAll()
        //        passportNoA.removeAll()
        //        countryCodeA.removeAll()
        //        genderA.removeAll()
        //        lnameA.removeAll()
        //        passportexpiryA.removeAll()
        //        passportissuingcountryA.removeAll()
        //        middleNameA.removeAll()
        //        leadPassengerA.removeAll()
        //
        //        passengerA.forEach { i in
        //            fnameA.append(i.firstName)
        //            passengertypeA.append(i.passengerType)
        //            title2A.append(i.title2Code)
        //            mnameA.append(i.middleName)
        //            dobA.append(i.dateOfBirth)
        //            passportNoA.append(i.passportNumber)
        //            countryCodeA.append(i.countryCode)
        //            genderA.append(i.gender)
        //            passportexpiryA.append(i.passportExpiryDate)
        //            passportissuingcountryA.append(i.passportIssuingCountry)
        //            middleNameA.append(i.middleName)
        //            lnameA.append(i.lastName)
        //            leadPassengerA.append(i.isLeadPassenger)
        //        }
        
        
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
        payload["first_name"] = fnameA
        payload["last_name"] = lnameA
        payload["name_title"] = title2A
        payload["billing_country"] = billingCountryCode
        payload["country_code"] = self.countryCode
        payload["passenger_type"] = "AD"
        payload["user_id"] = "0"
        
        
        
        if fnameA.count != Int(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1"){
            showToast(message: "Select Guest Details")
            
        }else if self.email == "" {
            showToast(message: "Enter Email Address")
        }else if self.email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if self.mobile == "" {
            showToast(message: "Enter Mobile No")
        }else if self.mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Mobile No")
        }else if self.countryCode == "" {
            showToast(message: "Enter Country Code")
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
    
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchCoreDataValues() {
        
        fnameA.removeAll()
        passengertypeA.removeAll()
        title2A.removeAll()
        dobA.removeAll()
        passportNoA.removeAll()
        genderA.removeAll()
        lnameA.removeAll()
        passportexpiryA.removeAll()
        passportissuingcountryA.removeAll()
        middleNameA.removeAll()
        leadPassengerA.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            
            details = result
            print(details)
            
            for data in result as! [NSManagedObject]{
                
                fnameA.append((data.value(forKey: "fname") as? String) ?? "")
                passengertypeA.append((data.value(forKey: "passengerType") as? String) ?? "")
                title2A.append((data.value(forKey: "title2") as? String) ?? "")
                dobA.append((data.value(forKey: "dob") as? String) ?? "")
                passportNoA.append((data.value(forKey: "passportno") as? String) ?? "")
                genderA.append((data.value(forKey: "gender") as? String) ?? "")
                lnameA.append((data.value(forKey: "lname") as? String) ?? "")
                passportexpiryA.append((data.value(forKey: "passportexpirydate") as? String) ?? "")
                passportissuingcountryA.append((data.value(forKey: "passportissuingcountry") as? String) ?? "")
                middleNameA.append("")
                leadPassengerA.append("1")
                
                
            }
            
            DispatchQueue.main.async {[self] in
                setuptv()
            }
        } catch {
            print("Failed")
        }
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
