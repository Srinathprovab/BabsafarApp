//
//  ViewFlightDetailsVC.swift
//  BabSafar
//
//  Created by FCI on 13/02/23.
//

import UIKit

class ViewFlightDetailsVC: BaseTableVC, FDViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    static var newInstance: ViewFlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewFlightDetailsVC
        return vc
    }
    var isVCFrom = String()
    var tablerow = [TableRow]()
    var viewmodel : FlightDetailsViewModel?
    var viewmodel1 : FDViewModel?
    var payload = [String:Any]()
    var fdetails = [FDFlightDetails]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkFDBool()
    }
    
    func checkFDBool(){
        if fdbool == true {
            holderView.isHidden = true
            self.view.backgroundColor = .WhiteColor
            callGetFlightDetailsAPI()
        }else {
            self.view.backgroundColor = .black.withAlphaComponent(0.5)
            setupItineraryOneWayTVCell()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel1 = FDViewModel(self)
        
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .WhiteColor
        setupViews(v: holderView, radius: 8, color: .WhiteColor)
        closeBtn.setTitle("", for: .normal)
        defaults.set(0, forKey: UserDefaultsKeys.itinerarySelectedIndex)
        commonTableView.registerTVCells(["ItineraryTVCell",
                                         "FareRulesTVCell",
                                         "BaggageInfoTVCell",
                                         "BookNowButtonsTVCell",
                                         "EmptyTVCell",
                                         "ItineraryAddTVCell",
                                         "CancellationFeesTVCell",
                                         "basefareTVCell",
                                         "NoteTVCell",
                                         "FareBreakdownTVCell",
                                         "FareBreakdownTitleTVCell",
                                         "TitleLblTVCell"])
        
        
    }
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    @IBAction func didTapOnitCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension ViewFlightDetailsVC {
    
    
    func callGetFlightDetailsAPI() {
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResultindex"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey) ?? "0"
        
        viewmodel1?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
        
    }
    
    
    func flightDetails(response: FDModel) {
        holderView.isHidden = false
        fd = response.flightDetails ?? []
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        DispatchQueue.main.async {[self] in
            setupItineraryOneWayTVCell()
        }
    }
    
    
    func setupItineraryOneWayTVCell() {
        tablerow.removeAll()
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.ItineraryAddTVCell))
        }
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
}


extension ViewFlightDetailsVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            checkFDBool()
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
