//
//  ModifySearchFastTrackVC.swift
//  BabSafar
//
//  Created by FCI on 06/09/23.
//

import UIKit

class ModifySearchFastTrackVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var quickbookingView: UIView!
    @IBOutlet weak var exploreView: UIView!
    @IBOutlet weak var quickbookinglbl: UILabel!
    @IBOutlet weak var explorelbl: UILabel!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    
    static var newInstance: ModifySearchFastTrackVC? {
        let storyboard = UIStoryboard(name: Storyboard.FastTrack.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchFastTrackVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        holderView.backgroundColor = .clear
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        
        
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Fasttrack"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["FasttrackSearchTVCell",
                                         "EmptyTVCell",
                                         "ExploreTVCell"])
        commonTableView.isScrollEnabled = false
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.layer.borderWidth = 1
        commonTableView.layer.borderColor = UIColor.AppBorderColor.cgColor
        quick()
        
    }
    
    
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: false)
    }
    
    
    
    func quick() {
        defaults.set("quick", forKey: UserDefaultsKeys.fasttrackJournyType)
        quickbookingView.backgroundColor = HexColor("#D7B912")
        exploreView.backgroundColor = HexColor("#F1F1F1")
        quickbookinglbl.textColor = .AppLabelColor
        explorelbl.textColor = .titleLabelColor
        tvheight.constant = 420
        DispatchQueue.main.async {[self] in
            setuptv()
        }
    }
    
    func explore() {
        defaults.set("explore", forKey: UserDefaultsKeys.fasttrackJournyType)
        quickbookingView.backgroundColor = HexColor("#F1F1F1")
        exploreView.backgroundColor = HexColor("#D7B912")
        quickbookinglbl.textColor = .titleLabelColor
        explorelbl.textColor = .AppLabelColor
        tvheight.constant = 192
        DispatchQueue.main.async {[self] in
            setupExploreTVCell()
        }
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.FasttrackSearchTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupExploreTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.ExploreTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @IBAction func didTapOnQuickBtnAction(_ sender: Any) {
        quick()
    }
    
    @IBAction func didTapOnExploreBtnAction(_ sender: Any) {
        explore()
    }
    
    
    //MARK: - didTapOnDepartureDateBtnAction FasttrackSearchTVCell
    override func didTapOnDepartureDateBtnAction(cell: FasttrackSearchTVCell) {
        gotoCalenderVC(key: "dep", titleStr: "Departure Date")
    }
    
    override func didTapOnReturnDateBtnAction(cell: FasttrackSearchTVCell) {
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
    
    
    //MARK: - didTapOnAddPassengersBtnAction FasttrackSearchTVCell
    override func didTapOnAddPassengersBtnAction(cell: FasttrackSearchTVCell) {
        gotoTravellerEconomyVC(str: "fasttrack")
    }
    
    func gotoTravellerEconomyVC(str:String) {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keyString = str
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnSearchInsurenceBtnAction FasttrackSearchTVCell
    override func didTapOnSearchInsurenceBtnAction(cell: FasttrackSearchTVCell) {
        
        
        payload.removeAll()
        payload["airport_fst_code"] = "1"
        payload["from"] = defaults.string(forKey: UserDefaultsKeys.frfromCity)
        payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.frfromlocid)
        payload["from_fst_code"] = defaults.string(forKey: UserDefaultsKeys.fromfstcode)
        payload["to"] = defaults.string(forKey: UserDefaultsKeys.frtoCity)
        payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.frtolocid)
        payload["to_fst_code"] = defaults.string(forKey: UserDefaultsKeys.tofstcode)
        payload["departure_date"] = defaults.string(forKey: UserDefaultsKeys.frcalDepDate)
        payload["arrival_date"] = defaults.string(forKey: UserDefaultsKeys.frcalRetDate)
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.fradultCount)
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.frchildCount)
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
            gotoFasttrackResultVC(input: payload)
        }
    }
    
    func gotoFasttrackResultVC(input:[String:Any]) {
        guard let vc = FasttrackResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.payload = input
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnSearchBtnAction ExploreTVCell
    override func didTapOnSearchBtnAction(cell: ExploreTVCell) {
        
        payload.removeAll()
        
        payload["airport"] = cell.airport
        payload["airport_fst_code"] = cell.airport_fst_code
        payload["airport_loc_id"] = cell.airport_loc_id
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["search_source"] = "postman"
        
        if cell.searchTF.text?.isEmpty == true {
            showToast(message: "Please Select Airport")
        }else {
            gotoFasttrackResultVC(input: payload)
        }
        
    }
    
    
    
    
}


extension ModifySearchFastTrackVC {
    
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
