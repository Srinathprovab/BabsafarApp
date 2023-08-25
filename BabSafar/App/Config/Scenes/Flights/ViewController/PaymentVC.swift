//
//  PaymentVC.swift
//  AlghanimTravelApp
//
//  Created by MA673 on 02/09/22.
//

import UIKit
import CoreData

class PaymentVC: BaseTableVC, MBViewModelDelegate, MobileSecureBookingViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navheight: NSLayoutConstraint!
    
    static var newInstance: PaymentVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PaymentVC
        return vc
    }
    
    var tabelrow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var tmpFlightPreBookingId = String()
    var accesskey = String()
    var accesskeytp = String()
    var bookingsource = String()
    var email = String()
    var mobile = String()
    var countryCode = String()
    var activepaymentoptions1 = String()
    var mbviewmodel:MBViewModel?
    var viewmodel1:MobileSecureBookingViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        activepaymentoptions1 = ""
        print(tmpFlightPreBookingId)
        print(accesskey)
        print(accesskeytp)
        print(bookingsource)
        print(email)
        print(mobile)
        print(countryCode)
        if screenHeight < 835 {
            navheight.constant = 90
        }
    }
    
    //MARK: - nointernet
    
    @objc func reloadscreen(){
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        mbviewmodel = MBViewModel(self)
        viewmodel1 = MobileSecureBookingViewModel(self)
    }
    
    
    func setupUI() {
        
        nav.titlelbl.text = "Payment"
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["PaymentOptionTVCell","EmptyTVCell","LabelTVCell","ImgBanerTVCell","ButtonTVCell"])
        commonTableView.isScrollEnabled = false
        commonTableView.allowsMultipleSelection = false
        setupTvcells()
    }
    
    
    func setupTvcells() {
        tabelrow.removeAll()
        
        tabelrow.append(TableRow(title:"Select Payment Method",cellType:.LabelTVCell))
        tabelrow.append(TableRow(title:"KNET",key:"payment",image: "op1",cellType:.PaymentOptionTVCell))
        tabelrow.append(TableRow(title:"AMERICAN EXPRESS",key:"payment",image: "op2",cellType:.PaymentOptionTVCell))
        tabelrow.append(TableRow(title:"VISA/MASTERCARD",key:"payment",image: "op3",cellType:.PaymentOptionTVCell))
        tabelrow.append(TableRow(title:"SADAD ACCOUNT",key:"payment",image: "op4",cellType:.PaymentOptionTVCell))
        tabelrow.append(TableRow(title:"PAYPAL EXPRESS CHECKOUT",key:"payment",image: "op5",cellType:.PaymentOptionTVCell))
        tabelrow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tabelrow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tabelrow.append(TableRow(title:"Continue",key: "pay",cellType:.ButtonTVCell))
        tabelrow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tabelrow
        commonTableView.reloadData()
    }
    
    
    
    @objc func dismisVC(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    
    override func didTapOnSelectPaymentOptionBtn(cell: PaymentOptionTVCell) {
        print(cell.titlelbl.text)
        cell.selected()
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        
        payload.removeAll()
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        payload["access_key"] = accesskey
        payload["access_key_tp"] =  accesskeytp
        payload["insurance_policy_type"] = "0"
        payload["insurance_policy_option"] = "0"
        payload["insurance_policy_cover_type"] = "0"
        payload["insurance_policy_duration"] = "0"
        payload["isInsurance"] = "0"
        payload["redeem_points_post"] = "1"
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["booking_source"] = bookingsource
        payload["promocode_val"] = ""
        payload["promocode_code"] = ""
        payload["mealsAmount"] = "0"
        payload["baggageAmount"] = "0"
        //    payload["passenger_type"] = ["Adult"]
        payload["lead_passenger"] = ["1"]
        payload["gender"] = ["1"]
        payload["name_title"] = ["1"]
        payload["first_name"] = fnameArray
        payload["middle_name"] = [""]
        payload["last_name"] = lnameArray
        payload["date_of_birth"] = dobArray
        payload["passenger_nationality"] = ["IN"]
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
        payload["billing_country"] = "IN"
        payload["billing_email"] = self.email
        payload["passenger_contact"] = self.mobile
        payload["country_mobile_code"] = self.countryCode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["payment_method"] = activepaymentoptions1
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
            
            
            if self.activepaymentoptions1 == "" {
                showToast(message: "Please Select Payment Type")
            }else {
                
                print(jsonStringData)
                
                //MARK:  Call mobile process passenger Details API
                DispatchQueue.main.async {[self] in
                 //   BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/"
                    payload1["passenger_request"] = jsonStringData
                    mbviewmodel?.CALL_MOBILE_PROCESS_PASSENGER_DETAIL_API(dictParam: payload1)
                }
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    //MARK: mobile process passenger Details
    func mobileprocesspassengerDetails(response: MBPModel) {
        payload.removeAll()
        BASE_URL = ""
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["app_reference"] = response.data?.post_data?.app_reference
        payload["promocode_val"] = response.data?.post_data?.promocode_val
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        DispatchQueue.main.async {[self] in
            mbviewmodel?.Call_mobile_pre_booking_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/mobile_pre_booking")
        }
    }
    
    
    
    func mobilePreBookingModelDetails(response: MobilePreBookingModel) {
        
        BASE_URL = ""
        payload["search_id"] = response.data?.search_id
        payload["app_reference"] = response.data?.app_reference
        payload["promocode_val"] = response.data?.promocode_val
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        DispatchQueue.main.async {[self] in
            mbviewmodel?.Call_mobile_pre_payment_confirmation_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/mobile_pre_payment_confirmation")
        }
    }
    
    func mobileprepaymentconfirmationDetails(response: MobilePrePaymentModel) {
        
        
        DispatchQueue.main.async {[self] in
            BASE_URL = ""
            mbviewmodel?.Call_mobile_send_to_payment_API(dictParam: [:], url: response.url ?? "")
        }
    }
    
    func mobilesendtopaymentDetails(response: MobilePrePaymentModel) {
        
        DispatchQueue.main.async {[self] in
            BASE_URL = ""
            self.viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: response.url ?? "")
        }
    }
    
    
    func mobilesecurebookingDetails(response: MobilePrePaymentModel) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = response.url ?? ""
        present(vc, animated: true)
    }
    
    func mobolePaymentDetails(response: MobilePaymentModel) {
        
    }
    
    func mobilepreprocessbookingDetails(response: MBModel) {
        
    }
    
}


extension PaymentVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentOptionTVCell {
            print(cell.titlelbl.text)
            activepaymentoptions1 = cell.titlelbl.text ?? ""
            cell.selected()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentOptionTVCell {
            cell.unselected()
        }
    }
}
