//
//  HotelBookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit
import CoreData
import MessageUI


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
    
    
    var callpaymenthotelbool = Bool()
    var fnameCharBool = true
    var lnameCharBool = true
    var hoteltotalprice = ""
    var hotelSearchData :HSearchData?
    var kwdprice = String()
    var mobile = String()
    var email = String()
    var passengercontact = String()
    var countryCode = String()
    var nationalityCode = String()
    var price = String()
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
        
        addObserver()
        
        if screenHeight < 835 {
            navHeight.constant = 90
        }
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
        
        TimerManager.shared.delegate = self
        
    }
    
    
    
    //MARK: - CALL MOBILE BOOKING API
    func callAPI() {
        
        payload.removeAll()
        TimerManager.shared.sessionStop()
        
        let selectedrRateKeyArrayString = "[\"" + selectedrRateKeyArray.joined(separator: "\",\"") + "\"]"
        
        payload["rateKey"] = selectedrRateKeyArrayString
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
        
        userspecification = response.data?.user_specification ?? []
        prebookingcancellationpolicy = response.data?.pre_booking_cancellation_policy
        hotelSearchData = response.data?.search_data
        hbookingDetails = response.data?.hotel_details
        roompaxesdetails = response.data?.room_paxes_details ?? []
        grandTotal = "\(response.data?.currency_obj?.to_currency ?? ""):\(response.data?.total_price ?? "")"
        bookingsource = response.data?.booking_source ?? ""
        token = response.data?.token ?? ""
        price = "\(response.data?.total_price ?? "")"
        hoteltotalprice = "\(response.data?.hotel_total_price ?? 0.0)"
        
        setAttributedTextnew(str1: "\(response.data?.currency_obj?.to_currency ?? "")",
                             str2: "\(response.data?.total_price ?? "")",
                             lbl: bookNowlbl,
                             str1font: .LatoBold(size: 12),
                             str2font: .LatoBold(size: 18),
                             str1Color: .WhiteColor,
                             str2Color: .WhiteColor)
        
        
        //   let totalSeconds = abs(response.session_expiry_details?.session_start_time ?? 0)
        TimerManager.shared.setTotalTime(900)
        TimerManager.shared.startTimer()
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
        
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
                                         "NewHotelPriceSummeryTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "HotelDetailsTVCell",
                                         "UserSpecificationTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "AddDeatilsOfGuestTVCell",
                                         "SpecialRequestTVCell"])
        
        
        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") ?? 0
        childCount = Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") ?? 0
    }
    
    
    func setuptv() {
        
        sessionTimerView.isHidden = false
        
        tablerow.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        tablerow.append(TableRow(title:hbookingDetails?.name,
                                 subTitle: hbookingDetails?.address,
                                 text: convertDateFormat(inputDate: hbookingDetails?.checkIn ?? "", f1: "yyyy-MM-dd", f2: "dd MMM yyyy"),
                                 buttonTitle:"\(adultsCount + childCount)",
                                 image:hbookingDetails?.image,
                                 tempText: convertDateFormat(inputDate: hbookingDetails?.checkOut ?? "", f1: "yyyy-MM-dd", f2: "dd MMM yyyy"),
                                 tempInfo: "\(roompaxesdetails?[0].no_of_rooms ?? 0)",
                                 cellType:.HotelDetailsTVCell))
        
        
        
        
        
        passengertypeArray.removeAll()
        tablerow.append(TableRow(height:20, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Guest Details",cellType:.TotalNoofTravellerTVCell))
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
        
        tablerow.append(TableRow(cellType:.UserSpecificationTVCell))
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(height:10, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        
        
        tablerow.append(TableRow(title:hbookingDetails?.name,
                                 subTitle: hbookingDetails?.address,
                                 price: hoteltotalprice,
                                 text: convertDateFormat(inputDate: hbookingDetails?.checkIn ?? "", f1: "yyyy-MM-dd", f2: "dd MMM yyyy"),
                                 headerText: "Room:\(roompaxesdetails?.first?.no_of_rooms ?? 0) \(roompaxesdetails?.first?.room_name ?? "")",
                                 buttonTitle:convertDateFormat(inputDate: hbookingDetails?.checkOut ?? "", f1: "yyyy-MM-dd", f2: "dd MMM yyyy"),
                                 tempText: "\(hotelSearchData?.no_of_nights ?? 0)",
                                 TotalQuestions: "\(roompaxesdetails?.first?.no_of_adults ?? 0)",
                                 cellType:.NewHotelPriceSummeryTVCell,
                                 questionBase: "\(roompaxesdetails?.first?.no_of_children ?? 0)"))
        
        tablerow.append(TableRow(cellType:.SpecialRequestTVCell))
        tablerow.append(TableRow(height:50, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func timerDidFinish() {
        gotoPopupScreen()
    }
    
    func updateTimer() {
        let totalTime = TimerManager.shared.getTotalTime()
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
        vc.modalPresentationStyle = .fullScreen
        vc.isVcFrom = "BookingDetailsVC"
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
        billingCountryCode = cell.isoCountryCode
    }
    
    //MARK: - editingTextField
    override func editingTextField(tf:UITextField){
        
        if tf.tag == 1 {
            payemail = tf.text ?? ""
        }else {
            paymobile = tf.text ?? ""
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
        billingCountryCode = cell.isoCountryCode
    }
    
    
    
    //MARK: - did Tap On T&C Action
    
    
    
    func contactDetals(response: ContactUsModel) {
        
    }
    
    func aboutusDetails(response: AboutUsModel) {
        
    }
    
    
    
    //MARK: - Load URLS of T&C And Privacy Policy
    
    
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        
        payload.removeAll()
        
        
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                callpaymenthotelbool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                callpaymenthotelbool = false
            }
            
           
            
            
            // Continue checking other fields
        }
        
        
        let positionsCount = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfGuestTVCell {
                
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                    
                } else {
                    
                    callpaymenthotelbool = true
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                } else {
                    callpaymenthotelbool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    
                    callpaymenthotelbool = true
                }
                
            }
            
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        //    let laedGuestArray = travelerArray.compactMap({$0.laedpassenger})
        
        
        
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let passengertypeString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        //   let laedGuesString = "[\"" + laedGuestArray.joined(separator: "\",\"") + "\"]"
        
        
        payload.removeAll()
        payload["booking_source"] = bookingsource
        payload["promo_code"] = ""
        payload["token"] = token
        payload["redeem_points_post"] = "0"
        payload["reducing_amount"] = "0"
        payload["reward_usable"] = "0"
        payload["reward_earned"] = "0"
        payload["billing_email"] = payemail
        payload["passenger_contact"] = paymobile
        payload["first_name"] = firstnameString
        payload["last_name"] = lastNameString
        payload["name_title"] = mrtitleString
        //      payload["lead_guest"] = laedGuesString
        payload["billing_country"] = billingCountryCode
        payload["country_code"] = self.countryCode
        payload["passenger_type"] = passengertypeString
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
            
            
            
            
            print(jsonStringData)
            
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
        
        if callpaymenthotelbool == false {
            showToast(message: "Add Details")
        }else if fnameCharBool == false {
            showToast(message: "First Name Should More Than 3 Chars")
        } else if lnameCharBool == false {
            showToast(message: "Last Name Should More Than 3 Chars")
        }else if payemail == "" {
            showToast(message: "Enter Email Id")
        } else if paymobile == "" {
            showToast(message: "Enter Mobile Number")
        }else if billingCountryCode == "" {
            showToast(message: "Enter Country Code")
        }  else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            vm?.CALL_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API(dictParam: payload)
        }
        
        
    }
    
    func hotelMobilePreBookingDetails(response: HotelPreBookingModel) {
        
        if response.status == 0 {
            showToast(message: response.msg ?? "")
        }else {
            guard let vc = PaymentGatewayVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.payload = payload
            vc.grandTotalamount = grandTotal
            vc.grand_total_Price = price
            vc.tmpFlightPreBookingId = response.data?.post_data?.appreference ?? ""
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
    
    
    //MARK: - SpecialRequestTVCell didTapOnTAndCAction
    override func didTapOnTAndCAction(cell: SpecialRequestTVCell) {
//        payload.removeAll()
//        BASE_URL = ""
//        payload["id"] = "3"
//        moreDeatilsViewModel?.CALL_GET_TERMSANDCONDITION_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/cms")
    }
    
    func termsandcobditionDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    
    //MARK: - SpecialRequestTVCell didTapOnPrivacyPolicyAction
    override func didTapOnPrivacyPolicyAction(cell: SpecialRequestTVCell) {
//        payload.removeAll()
//        BASE_URL = ""
//        payload["id"] = "4"
//        moreDeatilsViewModel?.CALL_GET_PRIVICYPOLICY_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/cms")
    }
    
    
    func privacyPolicyDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
        BASE_URL = BASE_URL1
    }
    
    
    func gotoAboutUsVC(title:String,desc:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.titleString = title
        vc.key1 = "webviewhide"
        vc.desc = desc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    //MARK: - didTapOnforMoreInfo HotelDetailsTVCell
    override func didTapOnforMoreInfo(cell: HotelDetailsTVCell) {
        openMailComposer(emailstr: "babsafar.support@johnmenzies.aero")
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



extension AddContactAndGuestDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAPI()
        }
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
    
    @objc func stopTimer() {
        gotoPopupScreen()
    }
    
    @objc func updatetimer(notificatio:UNNotification) {
        
        let totalTime = TimerManager.shared.getTotalTime()
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        setuplabels(lbl: sessonlbl, text: "Your Session Expires In : \(formattedTime)", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        
    }
    
    
}



//MARK: - MFMailComposeViewControllerDelegate
extension AddContactAndGuestDetailsVC:MFMailComposeViewControllerDelegate{
    
    func openMailComposer(emailstr:String) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients([emailstr]) // Replace with the recipient's email address
            
            // You can also set a subject and body for the email if needed
            mailComposeViewController.setSubject("Subject")
            mailComposeViewController.setMessageBody("Hello, here's my message.", isHTML: false)
            
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            // Handle the case where the device cannot send email
            let alertController = UIAlertController(title: "Error", message: "Your device cannot send email.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
