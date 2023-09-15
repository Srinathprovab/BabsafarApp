//
//  VisaEnduiryVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class VisaEnduiryVC: BaseTableVC, AllCountryCodeListViewModelDelegate, VisaEnquireyViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    var optionsArray = ["aaaaaa","bbbbb","ccccc"]
    
    var countryCode = String()
    var payload = [String:Any]()
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var visaDestination = String()
    var country = String()
    var noOfPassengers = String()
    var tablerow = [TableRow]()
    var dateoftravel = String()
    var residency = String()
    var nationalityName = String()
    var nationalityCode = String()
    var residencyName = String()
    var residencyCode = String()
    var destinatioName = String()
    var destinatioCode = String()
    var remark = String()
    var viewmodel:AllCountryCodeListViewModel?
    var viewmodel1:VisaEnquireyViewModel?
    
    static var newInstance: VisaEnduiryVC? {
        let storyboard = UIStoryboard(name: Storyboard.Visa.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? VisaEnduiryVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.callGetCointryListAPI()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadvisavc), name: Notification.Name("reloadvisavc"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    @objc func reloadvisavc() {
        
        noOfPassengers = defaults.string(forKey: UserDefaultsKeys.visatravellerDetails) ?? ""
        commonTableView.reloadData()
    }
    
    
    //MARK: - Call Get Cointry List API
    func callGetCointryListAPI() {
        viewmodel?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    //MARK:  GetCountryList Response
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
        
        DispatchQueue.main.async {[self] in
            setuptv()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = AllCountryCodeListViewModel(self)
        viewmodel1 = VisaEnquireyViewModel(self)
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Visa Enquiry"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["LabelTVCell",
                                         "TextfieldTVCell",
                                         "ButtonTVCell",
                                         "DropDownTVCell",
                                         "EmptyTVCell",
                                         "TextViewTVCell",
                                         "VisaEnduiryTVCell"])
        
        
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        
        
        tablerow.append(TableRow(cellType:.VisaEnduiryTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf:UITextField) {
        print(tf.text)
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 11:
            email = tf.text ?? ""
            break
            
        case 12:
            mobile = tf.text ?? ""
            break
            
        case 4:
            remark = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    
    
    override func donedatePicker(cell:VisaEnduiryTVCell){
        dateoftravel = cell.dateOfTravelTF.text ?? ""
        self.view.endEditing(true)
    }
    override func cancelDatePicker(cell:VisaEnduiryTVCell){
        self.view.endEditing(true)
    }
    
    
    override func didTapOnCountryCodeBtn(cell:VisaEnduiryTVCell){
        countryCode = cell.countryCodelbl.text ?? ""
    }
    
    override func didTapOnNationalityBtn(cell:VisaEnduiryTVCell){
        nationalityCode = cell.cityCode
        nationalityName = cell.cityName
    }
    
    override func didTapOnResidencyBtn(cell:VisaEnduiryTVCell){
        residencyName = cell.cityName
        residencyCode = cell.cityCode
    }
    
    override func didTapOnDestionationBtn(cell:VisaEnduiryTVCell){
        destinatioName = cell.cityName
        destinatioCode = cell.cityCode
    }
    
    override func didTapOnNoOfPassengersBtn(cell:VisaEnduiryTVCell){
        goToTravellerEconomyVC()
    }
    
    func goToTravellerEconomyVC() {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keyString = "visa"
        self.present(vc, animated: true)
    }
    
    override func didTapOnSubmitEnquireBtn(cell:VisaEnduiryTVCell){
        if fname == "" {
            showToast(message: "Enter First Name")
        }else if lname == "" {
            showToast(message: "Enter Email ID")
        }else if email == "" {
            showToast(message: "Enter Email ID")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email ID")
        }else if countryCode == "" {
            showToast(message: "Select Country Code")
        }else if mobile == "" {
            showToast(message: "Enter Phone Number")
        }else if mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Phone Number")
        }else if dateoftravel == "" {
            showToast(message: "Select Date of Travel")
        }else if nationalityName == "" {
            showToast(message: "Enter Nationality")
        }else if residencyName == "" {
            showToast(message: "Enter Residency")
        }else if destinatioName == "" {
            showToast(message: "Enter Designation")
        }else if noOfPassengers == "" {
            showToast(message: "Add No Of Passengers")
        }else {
            defaults.set("", forKey: UserDefaultsKeys.visatravellerDetails)
            callAPI()
        }
    }
    
    
    func callAPI() {
        payload["first_name"] = fname
        payload["last_name"] = lname
        payload["email"] = email
        payload["phone_number"] = mobile
        payload["destination"] = destinatioCode
        payload["nationality"] = nationalityCode
        payload["residency"] = residencyCode
        payload["travel_date"] = dateoftravel
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.visaadultCount) ?? "1"
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.visachildCount) ?? "0"
        payload["infant"] = defaults.string(forKey: UserDefaultsKeys.visainfantsCount) ?? "0"
        payload["remark"] = remark
        viewmodel1?.CALL_VISA_ENQUIRY_API(dictParam: payload)
    }
    
    func visaenquirySucessDetails(response: VisaEnquireyModel) {
        if response.status == 1 {
            showToast(message: response.msg ?? "")
            
            let seconds = 3.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
//                setuptv()
                
                dismiss(animated: true)
            }
            
        }else {
            showToast(message: response.msg ?? "")
        }
    }
    
    
    func goToNextScreen() {
        guard let vc = VisaEnduirySucessVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
