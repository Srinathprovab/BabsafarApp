//
//  TravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import CoreData

class BookingDetailsVC: BaseTableVC, AllCountryCodeListViewModelDelegate, MBViewModelDelegate {
    
    
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var navheight: NSLayoutConstraint!
    
    
    static var newInstance: BookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    var viewmodel:AllCountryCodeListViewModel?
    var countryCode = String()
    var email = String()
    var mobile = String()
    var showMoreBool = true
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var mbviewmodel:MBViewModel?
    var accesskeytp = String()
    var accesskey = String()
    var bookingsource = String()
    var tmpFlightPreBookingId = String()
    var activepaymentoptions = String()
    var totalPrice = Double()
    var appreference = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let seconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.fetchCoreDataValues()
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.callGetCointryListAPI()
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    self.callMobilePreProcessingBookingAPI()
                }
            }
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(addAdultsDetails(notification:)), name: NSNotification.Name("addAdultsDetails"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    
    //MARK: -call Mobile Pre Processing Booking API
    func callMobilePreProcessingBookingAPI() {
        
        payload.removeAll()
        BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/"
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? 0
        mbviewmodel?.CALLPREPROCESSINGBOOKINGAPI(dictParam: payload)
    }
    
    
    
    func mobilepreprocessbookingDetails(response: MBModel) {
        
        print("====== mobilepreprocessbookingDetails ===== \n \(response)")
        
        accesskey = response.pre_booking_params?.access_key ?? ""
        accesskeytp = response.access_key_tp ?? ""
        bookingsource = response.booking_source ?? ""
        tmpFlightPreBookingId = response.pre_booking_params?.transaction_id ?? ""
        activepaymentoptions = response.active_payment_options?[0] ?? ""
        totalPrice = response.total_price?.rounded() ?? 0.0
        appreference = response.pre_booking_params?.transaction_id ?? ""
        
        print("accesskeytp  \(accesskeytp)")
        print("bookingsource  \(bookingsource)")
        print("tmpFlightPreBookingId  \(tmpFlightPreBookingId)")
        print("activepaymentoptions  \(activepaymentoptions)")
        print("totalPrice  \(totalPrice)")
        print("appreference  \(appreference)")
        
        
        response.flight_data?.forEach({ i in
            MBfd = i.flight_details?.details
            
            Adults_Base_Price = i.adults_Base_Price ?? ""
            Adults_Tax_Price = i.adults_Tax_Price ?? ""
            Childs_Base_Price = i.childs_Base_Price ?? ""
            Childs_Tax_Price = i.childs_Tax_Price ?? ""
            Infants_Base_Price = i.infants_Base_Price ?? ""
            Infants_Tax_Price = i.infants_Tax_Price ?? ""
            
        })
        
        DispatchQueue.main.async {
            self.setupTV()
        }
    }
    
    
    //MARK: - Call Get Cointry List API
    func callGetCointryListAPI() {
        BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"
        viewmodel?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    //MARK:  GetCountryList Response
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
        
        DispatchQueue.main.async {
            self.commonTableView.reloadData()
        }
    }
    
    
    //MARK: - addAdultsDetails
    @objc func addAdultsDetails(notification:NSNotification) {
        setupTV()
    }
    
    
    //MARK: - reload commonTableView
    @objc func reload(notification:NSNotification) {
        commonTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
        viewmodel = AllCountryCodeListViewModel(self)
        mbviewmodel = MBViewModel(self)
    }
    
    
    func setupUI() {
        
        navBar.titlelbl.text = "Booking Details"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        if screenHeight > 835 {
            navheight.constant = 140
        }else {
            navheight.constant = 100
        }
        
        commonTableView.backgroundColor = .AppBorderColor
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TDetailsLoginTVCell","EmptyTVCell","ContactInformationTVCell","TravelInsuranceTVCell","PriceSummaryTVCell","AddTravellerTVCell","FlightDetailsTVCell","SearchFlightResultTVCell","MultiCityTripFlightResultTVCell","FlightDetailsTitleTVCell","ViewFlightDetailsBtnTVCell"])
        
    }
    
    
    
    func setupTV() {
        
        tablerow.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.userLoggedIn) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        
        tablerow.append(TableRow(cellType:.FlightDetailsTitleTVCell))
        MBfd?.forEach({ i in
            tablerow.append(TableRow(moreData:i,cellType:.FlightDetailsTVCell))
        })
        tablerow.append(TableRow(cellType:.ViewFlightDetailsBtnTVCell))
        
        tablerow.append(TableRow(cellType:.AddTravellerTVCell))
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(cellType:.TravelInsuranceTVCell))
        tablerow.append(TableRow(cellType:.PriceSummaryTVCell))
        tablerow.append(TableRow(height:50, bgColor:.AppBorderColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnLoginBtn(cell:TDetailsLoginTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
    }
    
    //MARK: - didTapOnCountryCodeBtn
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        self.countryCode = cell.countryCodeLbl.text ?? ""
    }
    
    //MARK: - editingTextField
    override func editingTextField(tf:UITextField){
        
        if tf.tag == 1 {
            self.email = tf.text ?? ""
        }else {
            self.mobile = tf.text ?? ""
        }
    }
    
    
    //MARK: - didTapOnInsureSkipButton TravelInsuranceTVCell
    override func didTapOnInsureSkipButton(cell: TravelInsuranceTVCell) {
        print("didTapOnInsureSkipButton")
    }
    
    
    
    //MARK: - didTapOnPABtn TravelInsuranceTVCell
    override func didTapOnPABtn(cell: TravelInsuranceTVCell) {
        print("didTapOnPABtn")
    }
    
    
    
    //MARK: - didTapOnTCBtn TravelInsuranceTVCell
    override func didTapOnTCBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTCBtn")
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
    func gotoAddTravellerOrGuestVC(str:String) {
        defaults.set(str, forKey: UserDefaultsKeys.travellerTitle)
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "add"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnAddAdultBtn
    override func didTapOnAddAdultBtn(cell: AddTravellerTVCell) {
        gotoAddTravellerOrGuestVC(str: "Adult")
    }
    
    //MARK: - didTapOnAddChildBtn
    override func didTapOnAddChildBtn(cell: AddTravellerTVCell) {
        gotoAddTravellerOrGuestVC(str: "Children")
    }
    
    //MARK: - didTapOnAddInfantaBtn
    override func didTapOnAddInfantaBtn(cell: AddTravellerTVCell) {
        gotoAddTravellerOrGuestVC(str: "Infantas")
    }
    
    
    //MARK: - didTapOnEditTraveller
    override func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell){
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "edit"
        vc.id = cell.travellerId
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnViewFlightsDetailsBtn
    override func didTapOnViewFlightDetailsButton(cell: ViewFlightDetailsBtnTVCell) {
        dismiss(animated: true)
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
        self.countryCode = cell.countryCodeLbl.text ?? ""
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchCoreDataValues() {
        
        fnameArray.removeAll()
        mnameArray.removeAll()
        lnameArray.removeAll()
        dobArray.removeAll()
        passportNoArray.removeAll()
        countryCodeArray.removeAll()
        passportexpiryArray.removeAll()
        passportissuingcountryArray.removeAll()
        
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            print(result)
            for data in result as! [NSManagedObject]{
                print("fname ====== >\((data.value(forKey: "fname") as? String) ?? "")")
                
                title2Array.append(data.value(forKey: "title2") as! String)
                fnameArray.append(data.value(forKey: "fname") as! String)
                lnameArray.append(data.value(forKey: "lname") as! String)
                dobArray.append(data.value(forKey: "dob") as! String)
                passportNoArray.append(data.value(forKey: "passportno") as! String)
                passportissuingcountryArray.append(data.value(forKey: "passportissuingcountry") as! String)
                passportnationalityArray.append(data.value(forKey: "nationality") as! String)
                passportexpiryArray.append(convertDateFormat(inputDate: data.value(forKey: "passportexpirydate") as! String, f1: "yyyy-MM-dd", f2: "dd-MM-yyyy"))

            
            }
            
            details = result
            
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
        } catch {
            print("Failed")
        }
    }
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String) {
        
        print("DELETING COREDATA OBJECT")
        print(index)
        print(id)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        request.predicate = NSPredicate(format: "id = %@", "\(id)")
        request.returnsObjectsAsFaults = false
        
        
        if details.count > 0 {
            
            
            do {
                let objects = try context.fetch(request)
                for object in details {
                    context.delete(object as! NSManagedObject)
                }
            } catch {
                print ("There was an error")
            }
        }
        
        
        do {
            try context.save()
        } catch {
            print ("There was an error")
        }
        
        
        DispatchQueue.main.async {[self] in
            
            fetchCoreDataValues()
            commonTableView.reloadData()
        }
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
    
    
    
    
    
    
    //MARK: - didTapOnBookNowBtn
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        payload.removeAll()
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        payload["access_key"] = accesskey
        payload["access_key_tp"] = accesskeytp
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
        payload["passenger_type"] = ["adult"]
        payload["lead_passenger"] = ["1"]
        payload["gender"] = ["1"]
        payload["name_title"] = ["1"]
        payload["first_name"] = fnameArray
        payload["middle_name"] = [""]
        payload["last_name"] = lnameArray
        payload["date_of_birth"] = ["11-12-1990"]
        payload["passenger_nationality"] = passportnationalityArray
        payload["passenger_passport_number"] = passportNoArray
        payload["passenger_passport_issuing_country"] = passportissuingcountryArray
        payload["passenger_passport_expiry"] = passportexpiryArray
        payload["Frequent"] = [["Select"]]
        payload["ff_no"] = [[""]]
        payload["address2"] = "ecity"
        payload["billing_address_1"] = "hjfggh"
        payload["billing_state"] = "karnataka"
        payload["billing_city"] = "Bangalore"
        payload["billing_zipcode"] = "560100"
        payload["billing_email"] = self.email
        payload["passenger_contact"] = self.mobile
        payload["billing_country"] = "IN"
        payload["country_mobile_code"] = self.countryCode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["payment_method"] = activepaymentoptions
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
//    passenger_request:{"search_id":"4960","tmp_flight_pre_booking_id":"BAS-F-TP-1208-3487","access_key":"47c6730924a4909fb69c4297cda5d0a7*_*1*_*b6xf2SiL4Xdo1grW","access_key_tp":"b0657ccdc3fcabfa49778380dc59d994*_*5*_*Qtr3d17ajys3pWdW","insurance_policy_type":"0","insurance_policy_option":"0","insurance_policy_cover_type":"0","insurance_policy_duration":"0","isInsurance":"0","selectedResult":"0_4_0","redeem_points_post":"1","booking_source":"YToxOntpOjA7czoxNjoiUFRCU0lEMDAwMDAwMDAxNiI7fQ==","promocode_val":"","promocode_code":"","mealsAmount":"0","baggageAmount":"0","passenger_type":["Adult"],"lead_passenger":["1"],"gender":["1"],"passenger_nationality":["92"],"name_title":["1"],"first_name":["Check"],"middle_name":[""],"last_name":["Test"],"date_of_birth":["13-04-1945"],"passenger_passport_number":["POIL7675"],"passenger_passport_issuing_country":["92"],"passenger_passport_expiry":["04-12-2028"],"Frequent":[["Select"]],"ff_no":[[""]],"address2":"ECITY","billing_address_1":"hjfggh","billing_state":"Karnataka","billing_city":"Bangalore","billing_zipcode":"560100","billing_email":"ghfgh@ghhj.hjhj","passenger_contact":"8965231470","billing_country":"IN","country_mobile_code":"+91","insurance":"1","tc":"on","booking_step":"book","payment_method":"PNHB1","selectedCurrency":"AED","user_id":"0"}
//

        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
            
            if details.count > 0 {
                print(jsonStringData)
                
                //MARK:  Call mobile process passenger Details API
                BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/"
                payload1["passenger_request"] = jsonStringData
                mbviewmodel?.CALL_PRE_PROCESS_PASSENGER_DETAIL_API(dictParam: payload1)
            }else {
                showToast(message: "Enter Traveller Details")
            }
            
            
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    //MARK: mobile process passenger Details
    func mobileprocesspassengerDetails(response: MBPModel) {
        print(" ====== mobileprocesspassengerDetails ======= \n \(response)")
        payload.removeAll()
        BASE_URL = ""
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["app_reference"] = response.data?.post_data?.app_reference
        payload["promocode_val"] = response.data?.post_data?.promocode_val
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        mbviewmodel?.Call_mobile_pre_booking_API(dictParam: payload, url: response.data?.post_data?.url ?? "")
    }
    
    
    
    func mobilePreBookingModelDetails(response: MobilePreBookingModel) {
        print(" ====== mobilePreBookingModelDetails ======= \n \(response)")
        
        BASE_URL = ""
        payload["search_id"] = response.data?.search_id
        payload["app_reference"] = response.data?.app_reference
        payload["promocode_val"] = response.data?.promocode_val
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        mbviewmodel?.Call_mobile_send_to_payment_API(dictParam: payload, url: response.data?.form_url ?? "")
    }
    
    func mobileprepaymentconfirmationDetails(response: MobilePrePaymentModel) {
        print(" ====== mobileprepaymentconfirmationDetails ======= \n \(response)")
        
        BASE_URL = ""
        mbviewmodel?.Call_mobile_pre_payment_confirmation_API(dictParam: [:], url: response.url ?? "")
    }
    
    func mobilesendtopaymentDetails(response: MobilePrePaymentModel) {
        print(" ====== mobilesendtopaymentDetails ======= \n \(response)")
        BASE_URL = ""
        mbviewmodel?.Call_mobile_secure_booking_API(dictParam: [:], url: response.url ?? "")
    }
    
    func mobilesecurebookingDetails(response: MobilePrePaymentModel) {
        print(" ====== mobilesecurebookingDetails ======= \n \(response)")
        BASE_URL = ""
        mbviewmodel?.Call_Get_voucher_Details_API(dictParam: [:], url: response.url ?? "")
    }
    
    
    func vocherdetails(response: VocherModel) {
        print(" ====== vocherdetails ======= \n \(response)")
        
        //        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .overCurrentContext
        //        present(vc, animated: true)
    }
    
    
    
    
    
}


extension BookingDetailsVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("BookNowButtonsTVCell", owner: self, options: nil)?.first as! BookNowButtonsTVCell
        myFooter.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        myFooter.kwdlbl.text = totalprice
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
