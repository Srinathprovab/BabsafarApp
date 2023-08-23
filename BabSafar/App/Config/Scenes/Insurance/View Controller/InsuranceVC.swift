//
//  InsuranceVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class InsuranceVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var roundTripView: UIView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var roundtriplbl: UILabel!
    
    
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    
    static var newInstance: InsuranceVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? InsuranceVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Insurance"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["InsurenceSearchTVCell",
                                         "EmptyTVCell"])
        commonTableView.isScrollEnabled = false
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.layer.borderWidth = 1
        commonTableView.layer.borderColor = UIColor.AppBorderColor.cgColor
        onewayTap()
        
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.InsurenceSearchTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    
    func onewayTap() {
        defaults.set("oneway", forKey: UserDefaultsKeys.InsurenceJourneyType)
        onewayView.backgroundColor = UIColor.IttenarySelectedColor
        roundTripView.backgroundColor = HexColor("#F1F1F1")
        onewaylbl.textColor = .WhiteColor
        roundtriplbl.textColor = .titleLabelColor
        DispatchQueue.main.async {[self] in
            setuptv()
        }
    }
    
    func roundtripTap() {
        defaults.set("circle", forKey: UserDefaultsKeys.InsurenceJourneyType)
        onewayView.backgroundColor = HexColor("#F1F1F1")
        roundTripView.backgroundColor = UIColor.IttenarySelectedColor
        onewaylbl.textColor = .titleLabelColor
        roundtriplbl.textColor = .WhiteColor
        DispatchQueue.main.async {[self] in
            setuptv()
        }
    }
    
    @IBAction func didTapOnOneWayBtnAction(_ sender: Any) {
        onewayTap()
    }
    
    @IBAction func didTapOnRoundTripBtnAction(_ sender: Any) {
        roundtripTap()
    }
    
    
    //MARK: - didTapOnDepartureDateBtnAction InsurenceSearchTVCell
    override func didTapOnDepartureDateBtnAction(cell: InsurenceSearchTVCell) {
        gotoCalenderVC(key: "dep", titleStr: "Departure Date")
    }
    
    override func didTapOnReturnDateBtnAction(cell: InsurenceSearchTVCell) {
        gotoCalenderVC(key: "ret", titleStr: "Ruturn Date")
    }
    
    func gotoCalenderVC(key:String,titleStr:String) {
        dateSelectKey = key
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = titleStr
        callapibool = true
        self.present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnAddPassengersBtnAction InsurenceSearchTVCell
    override func didTapOnAddPassengersBtnAction(cell: InsurenceSearchTVCell) {
        gotoTravellerEconomyVC(str: "insurence")
    }
    
    func gotoTravellerEconomyVC(str:String) {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keyString = str
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnSearchInsurenceBtnAction InsurenceSearchTVCell
    override func didTapOnSearchInsurenceBtnAction(cell: InsurenceSearchTVCell) {
        
        
        if let cell = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? InsurenceSearchTVCell {
            
            
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
                if journeyType == "oneway" {
                    
                    
                    payload.removeAll()
                    payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType)
                    payload["adult"] = defaults.string(forKey: UserDefaultsKeys.iadultCount)
                    payload["child"] = defaults.string(forKey: UserDefaultsKeys.ichildCount)
                    payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
                    payload["from"] = defaults.string(forKey: UserDefaultsKeys.ifromCity)
                    payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.ifromlocid)
                    payload["to"] = defaults.string(forKey: UserDefaultsKeys.itoCity)
                    payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.itolocid)
                    payload["departure_date"] = defaults.string(forKey: UserDefaultsKeys.icalDepDate)
                    payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
                    payload["arrival_date"] = defaults.string(forKey: UserDefaultsKeys.icalDepDate)
                    
                    if cell.fromTF.text == "" {
                        showToast(message: "Select From City")
                    }else if cell.toTF.text == "" {
                        showToast(message: "Select To City")
                    }else if cell.depDatelbl.text == "+ Add Date" {
                        showToast(message: "Select Departure Date")
                    }else if checkDepartureAndReturnDates1(payload, p1: "departure_date") == false {
                        showToast(message: "Invalid Date")
                    }else {
                        gotoInsurenceResultVC(input: payload)
                    }
                }else {
                    
                    payload.removeAll()
                    payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType)
                    payload["adult"] = defaults.string(forKey: UserDefaultsKeys.iradultCount)
                    payload["child"] = defaults.string(forKey: UserDefaultsKeys.irchildCount)
                    payload["infant"] = defaults.string(forKey: UserDefaultsKeys.irinfantsCount)
                    payload["from"] = defaults.string(forKey: UserDefaultsKeys.irfromCity)
                    payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.irfromlocid)
                    payload["to"] = defaults.string(forKey: UserDefaultsKeys.irtoCity)
                    payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.irtolocid)
                    payload["departure_date"] = defaults.string(forKey: UserDefaultsKeys.ircalDepDate)
                    payload["arrival_date"] = defaults.string(forKey: UserDefaultsKeys.ircalRetDate)
                    payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
                    
                    
                    if cell.fromTF.text == "" {
                        showToast(message: "Select From City")
                    }else if cell.toTF.text == "" {
                        showToast(message: "Select To City")
                    }else if cell.depDatelbl.text == "+ Add Date" {
                        showToast(message: "Select Departure Date")
                    }else if checkDepartureAndReturnDates(payload, p1: "departure_date", p2: "arrival_date") == false {
                        showToast(message: "Invalid Date")
                    }else {
                        gotoInsurenceResultVC(input: payload)
                    }
                }
            }
            
            
        }
    }
    
    func gotoInsurenceResultVC(input:[String:Any]) {
        guard let vc = InsurenceResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.payload = input
        self.present(vc, animated: true)
    }
    
    
}


extension InsuranceVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)

        
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            setuptv()
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
