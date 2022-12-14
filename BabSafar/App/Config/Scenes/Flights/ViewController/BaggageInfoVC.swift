//
//  BaggageInfoVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class BaggageInfoVC: BaseTableVC, FlightDetailsViewModelProtocal, FDViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var itineraryView: UIView!
    @IBOutlet weak var itinerarylbl: UILabel!
    @IBOutlet weak var itineraryBtn: UIButton!
    @IBOutlet weak var fareRulesView: UIView!
    @IBOutlet weak var fareRuleslbl: UILabel!
    @IBOutlet weak var fareRulesBtn: UIButton!
    @IBOutlet weak var baggageInfoView: UIView!
    @IBOutlet weak var baggageInfolbl: UILabel!
    @IBOutlet weak var baggageInfoBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    static var newInstance: BaggageInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BaggageInfoVC
        return vc
    }
    var isVCFrom = String()
    var tablerow = [TableRow]()
    var viewmodel : FlightDetailsViewModel?
    var viewmodel1 : FDViewModel?
    var payload = [String:Any]()
    var fdetails = [FDFlightDetails]()
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        callApi()
    }
    
    func callApi() {
        callGetFlightDetailsAPI()
    }
    
    
    func setupTVCells() {
        commonTableView.isHidden = false
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "oneway" {
                setupItineraryOneWayTVCell()
            }else if selectedTab == "roundtrip" {
                setupItineraryRoundTripTVCell()
            }else {
                setupItineraryMultiTripTVCell()
            }
        }
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        callApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        // viewmodel = FlightDetailsViewModel(self)
        viewmodel1 = FDViewModel(self)
        
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupViews(v: holderView, radius: 8, color: .WhiteColor)
        setupViews(v: buttonsView, radius: 0, color: .WhiteColor)
        setupViews(v: itineraryView, radius: 25, color: .AppTabSelectColor)
        setupViews(v: baggageInfoView, radius: 25, color: .WhiteColor)
        setupViews(v: fareRulesView, radius: 25, color: .WhiteColor)
        setupLabels(lbl: itinerarylbl, text: "Itinerary", textcolor: .WhiteColor, font: .LatoMedium(size: 14))
        setupLabels(lbl: fareRuleslbl, text: "Fare Rules", textcolor: .AppLabelColor, font: .LatoMedium(size: 14))
        setupLabels(lbl: baggageInfolbl, text: "Baggage Info", textcolor: .AppLabelColor, font: .LatoMedium(size: 14))
        
        closeBtn.setTitle("", for: .normal)
        itineraryBtn.setTitle("", for: .normal)
        fareRulesBtn.setTitle("", for: .normal)
        baggageInfoBtn.setTitle("", for: .normal)
        
        commonTableView.isHidden = true
        commonTableView.registerTVCells(["ItineraryTVCell",
                                         "FareRulesTVCell",
                                         "BaggageInfoTVCell",
                                         "BookNowButtonsTVCell",
                                         "EmptyTVCell",
                                         "ItineraryAddTVCell",
                                        "CancellationFeesTVCell",
                                        "basefareTVCell",
                                         "NoteTVCell"])
    }
    
    //one way ---------------------------------------------
    func setupItineraryOneWayTVCell() {
        
        tablerow.removeAll()
        
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.ItineraryAddTVCell))
        }
        
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func setupFareRulesOneWayTVCell() {
        
        tablerow.removeAll()
      //  tablerow.append(TableRow(cellType:.FareRulesTVCell))
        tablerow.append(TableRow(cellType:.CancellationFeesTVCell))
        tablerow.append(TableRow(cellType:.basefareTVCell))
        tablerow.append(TableRow(cellType:.NoteTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupBaggageInfoOneWayTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.BaggageInfoTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    //round trip ------------------------------------------------------
    func setupItineraryRoundTripTVCell() {
        
        tablerow.removeAll()
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.ItineraryAddTVCell))
        }
        
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupFareRulesRoundTripTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.CancellationFeesTVCell))
        tablerow.append(TableRow(cellType:.basefareTVCell))
        tablerow.append(TableRow(cellType:.NoteTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupBaggageInfoRoundTripTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.BaggageInfoTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    //multicity ---------------------------------------------
    
    func setupItineraryMultiTripTVCell() {
        
        tablerow.removeAll()
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.ItineraryAddTVCell))
        }
        
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupFareRulesMultiTripTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.FareRulesTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupBaggageInfoMultiTripTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.BaggageInfoTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func didTapOnitIneraryBtn(_ sender: Any) {
        scrollToFirstRow()
        itinerarylbl.textColor = .WhiteColor
        itineraryView.backgroundColor = .AppTabSelectColor
        fareRuleslbl.textColor = .AppLabelColor
        fareRulesView.backgroundColor = .WhiteColor
        baggageInfolbl.textColor = .AppLabelColor
        baggageInfoView.backgroundColor = .WhiteColor
        
        
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "oneway" {
                setupItineraryOneWayTVCell()
            }else if selectedTab == "roundtrip" {
                setupItineraryRoundTripTVCell()
            }else {
                setupItineraryMultiTripTVCell()
            }
        }
        
    }
    
    
    @IBAction func didTapOnitFareRulesBtn(_ sender: Any) {
        scrollToFirstRow()
        itinerarylbl.textColor = .AppLabelColor
        itineraryView.backgroundColor = .WhiteColor
        fareRuleslbl.textColor = .WhiteColor
        fareRulesView.backgroundColor = .AppTabSelectColor
        baggageInfolbl.textColor = .AppLabelColor
        baggageInfoView.backgroundColor = .WhiteColor
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "oneway" {
                setupFareRulesOneWayTVCell()
            }else if selectedTab == "roundtrip" {
                setupFareRulesRoundTripTVCell()
            }else {
                setupFareRulesMultiTripTVCell()
            }
        }
    }
    
    @IBAction func didTapOnitBaggageInfoBtn(_ sender: Any) {
        scrollToFirstRow()
        itinerarylbl.textColor = .AppLabelColor
        itineraryView.backgroundColor = .WhiteColor
        fareRuleslbl.textColor = .AppLabelColor
        fareRulesView.backgroundColor = .WhiteColor
        baggageInfolbl.textColor = .WhiteColor
        baggageInfoView.backgroundColor = .AppTabSelectColor
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "oneway" {
                setupBaggageInfoOneWayTVCell()
            }else if selectedTab == "roundtrip" {
                setupBaggageInfoRoundTripTVCell()
            }else {
                setupBaggageInfoMultiTripTVCell()
            }
        }
        
    }
    
    
    @IBAction func didTapOnitCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    func callGetFlightDetailsAPI() {
        BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/"
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResultindex"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsource) ?? "0"
        
        viewmodel1?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
        
    }
    
    
    func flightDetails(response: FDModel) {
        print(" ===== flightDetails ===== ")
        fd = response.flightDetails ?? []
        fareRulehtml = response.fareRulehtml?.htmlToString ?? ""
        totalprice = "\(response.priceDetails?.api_currency ?? "") : \(response.priceDetails?.grand_total ?? "")"
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
    }
    
    
    func flightDetails(response: FlightDetailsModel) {
        // print(response)
    }
    
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.commonTableView.scrollToRow(at: indexPath, at: .top, animated: true)
      }
    
}


extension BaggageInfoVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("BookNowButtonsTVCell", owner: self, options: nil)?.first as! BookNowButtonsTVCell
        myFooter.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        myFooter.kwdlbl.text = totalprice
        if self.isVCFrom == "BookingDetailsVC" {
            myFooter.holderView.isHidden = true
        }
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}


