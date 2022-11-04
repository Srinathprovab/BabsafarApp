//
//  BaggageInfoVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class BaggageInfoVC: BaseTableVC, FlightDetailsViewModelProtocal {
    
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
    var flightdetails : Flight_details?
    var viewmodel : FlightDetailsViewModel?
    var payload = [String:Any]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "oneway" {
                setupItineraryOneWayTVCell()
            }else if selectedTab == "roundtrip" {
                setupItineraryRoundTripTVCell()
            }else {
                setupItineraryMultiTripTVCell()
            }
        }
        
        
        
        print(flightdetails)
        
        callGetFlightDetailsAPI()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = FlightDetailsViewModel(self)
        
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
        
        commonTableView.registerTVCells(["ItineraryTVCell","FareRulesTVCell","BaggageInfoTVCell","BookNowButtonsTVCell","EmptyTVCell"])
    }
    
    //one way ---------------------------------------------
    func setupItineraryOneWayTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(title:"Bellary to Bangalore(5 hrs)",cellType:.ItineraryTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func setupFareRulesOneWayTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.FareRulesTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
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
        tablerow.append(TableRow(title:"Bellary to Bangalore(2 hrs)",cellType:.ItineraryTVCell))
        tablerow.append(TableRow(title:"Bangalore to Delhi (3 25m)",cellType:.ItineraryTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupFareRulesRoundTripTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.FareRulesTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
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
        tablerow.append(TableRow(title:"Bellary to Bangalore(2 hrs)",cellType:.ItineraryTVCell))
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
    
    @objc func didTapOnKWDBtn(_ sender: UIButton) {
        print("didTapOnKWDBtn")
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
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        viewmodel?.getFlightDetails(dictParam: payload)
    }
    
    
    func flightDetails(response: FlightDetailsModel) {
        print(response)
    }
    
}


extension BaggageInfoVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("BookNowButtonsTVCell", owner: self, options: nil)?.first as! BookNowButtonsTVCell
        myFooter.kwdBtn.addTarget(self, action: #selector(didTapOnKWDBtn(_:)), for: .touchUpInside)
        myFooter.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        
        if self.isVCFrom == "BookingDetailsVC" {
            myFooter.holderView.isHidden = true
        }
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
