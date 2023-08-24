//
//  PersonalDetailsVC.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit

class PersonalDetailsVC: BaseTableVC, InsurancePreprocessBookingViewModelDelegate {
    
    @IBOutlet var holderView: UIView!
    
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var positionsCount = 1
    var searchTextArray = [String]()
    var countryCode = String()
    var nationalityCode = String()
    var billingCountryCode = String()
    var callpaymentbool = true
    var vm:InsurancePreprocessBookingViewModel?
    var totalFare = String()
    var baseFare = String()
    var tax = String()
    
    static var newInstance: PersonalDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PersonalDetailsVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.getTravellerCount()
        }
        addObserver()
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = InsurancePreprocessBookingViewModel(self)
    }
    
    
    func setupUI() {
        
        
        commonTableView.registerTVCells(["AddDeatilsOfTravellerTVCell",
                                         "EmptyTVCell",
                                         "TravellerDetailsTVCell",
                                         "ContactInformationTVCell",
                                         "InsurenceFareSummaryTVCell",
                                         "InsurenceFlightDetailsTVCell"])
        
        setupTV()
    }
    
    
    
    func setupTV() {
        tablerow.removeAll()
        passengertypeArray.removeAll()
        
        tablerow.append(TableRow(cellType:.InsurenceFlightDetailsTVCell))
        tablerow.append(TableRow(height:20, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1")",
                                 cellType:.TravellerDetailsTVCell))
        
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
        tablerow.append(TableRow(title:baseFare,
                                 subTitle: tax,
                                 buttonTitle: totalFare,
                                 cellType:.InsurenceFareSummaryTVCell))
        
        tablerow.append(TableRow(height:50, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
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
    
    
    
    
    //MARK: - doneTimePicker cancelTimePicker  InsurenceFlightDetailsTVCell
    override func doneTimePicker(cell: InsurenceFlightDetailsTVCell) {
        self.view.endEditing(true)
    }
    
    
    override func cancelTimePicker(cell: InsurenceFlightDetailsTVCell) {
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - didTapOnCountryCodeBtn
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        self.nationalityCode = cell.nationalityCode
        self.countryCode = cell.billingCountryCode
        self.billingCountryCode = cell.billingCountryCode
    }
    
    override func editingTextField(tf:UITextField){
        
        if tf.tag == 1 {
            payemail = tf.text ?? ""
        }else {
            paymobile = tf.text ?? ""
        }
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnSubmitButtonAction(_ sender: Any) {
        submitBtnTap()
    }
    
    
    
}


extension PersonalDetailsVC {
    
    func callAPI() {
        payload["search_id"] = isearchid
        payload["plan_code"] = iplancode
        payload["booking_source"] = ibookingsource
        payload["plan_details"] = iplandetails
        
        vm?.CALL_MOBILE_PRE_PROCESS_BOOKING_API(dictParam: payload)
    }
    
    func insurencePaymentshow(response: InsurancePreprocessBookingModel) {
        holderView.isHidden = false
        searchInputs = response.search_params
        totalFare = "\(response.total_fare?.rounded() ?? 0.0)"
        baseFare = "\(response.base_fare?.rounded() ?? 0.0)"
        tax = "\(response.tax?.rounded() ?? 0.0)"
        
        DispatchQueue.main.async {
            self.setupTV()
        }
    }
    
}


extension PersonalDetailsVC {
    
    func getTravellerCount() {
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.iadultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.ichildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.iinfantsCount) ?? "0") ?? 0
                
            }else{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.iradultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.irchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.irinfantsCount) ?? "0") ?? 0
            }
        }
        
        
    }
    
    
}


extension PersonalDetailsVC {
    func submitBtnTap(){
        checkTravellerDetailsFields()
        checkFlightDetailsFields()
    }
    
    
    
    func checkTravellerDetailsFields() {
        
        payload.removeAll()
       
        
        var textfilldshouldmorethan3lettersBool = true
        // Assuming you have a positionsCount variable that holds the number of cells in the table view
        let positionsCount = commonTableView.numberOfRows(inSection: 0)
        
        for position in 0..<positionsCount {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfTravellerTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                if cell.fnameTF.text?.isEmpty == true{
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    
                }else if ((cell.fnameTF.text?.count ?? 0) <= 3) {
                    // Textfield is empty
                    showToast(message: "Enter More Than 3 Chars")
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    textfilldshouldmorethan3lettersBool = false
                    callpaymentbool = false
                }else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else if ((cell.lnameTF.text?.count ?? 0) <= 3) {
                    // Textfield is empty
                    showToast(message: "Enter More Than 3 Chars")
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    textfilldshouldmorethan3lettersBool = false
                   
                }else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
                if cell.dobTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.dobView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
                if cell.passportnoTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
                if cell.passportIssuingCountryTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
                if cell.passportExpireDateTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                    callpaymentbool = true
                }
                
                
            }
            
            
            
            
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let middlenameArray = travelerArray.compactMap({$0.middlename})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let genderArray = travelerArray.compactMap({$0.gender})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        let nationalityArray = travelerArray.compactMap({$0.nationality})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
        let frequentFlyrNoArray = travelerArray.compactMap({$0.frequentFlyrNo})
        let mealNameArray = travelerArray.compactMap({$0.meal})
        let specialAssicintenceArray = travelerArray.compactMap({$0.specialAssicintence})
        
        
    }
    
    
    func checkFlightDetailsFields() {
        
        if let cell = commonTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? InsurenceFlightDetailsTVCell {
            
            if cell.pnrTF.text?.isEmpty == true {
                // Textfield is empty
                cell.pnrView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
                
            } else {
                // Textfield is not empty
                callpaymentbool = true
            }
            
            if cell.depAirlinelbl.text == "Select Airline"{
                // Textfield is empty
                cell.depView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
                
            } else {
                // Textfield is not empty
                callpaymentbool = true
            }
            
            if cell.arrivalAirlinelbl.text == "Select Airline"{
                // Textfield is empty
                cell.arrivalView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
                
            } else {
                // Textfield is not empty
                callpaymentbool = true
            }
            
            
            if cell.depTimeTF.text?.isEmpty == true {
                // Textfield is empty
                cell.depTimeView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
                
            } else {
                // Textfield is not empty
                callpaymentbool = true
            }
            
            
            if cell.arrivalTimeTF.text?.isEmpty == true {
                // Textfield is empty
                cell.arrivalTimeView.layer.borderColor = UIColor.red.cgColor
                callpaymentbool = false
                
            } else {
                // Textfield is not empty
                callpaymentbool = true
            }
            
            
        }
    }
}



extension PersonalDetailsVC {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            setupTV()
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
    
    
}