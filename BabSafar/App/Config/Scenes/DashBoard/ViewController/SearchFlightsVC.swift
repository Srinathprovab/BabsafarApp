//
//  SearchFlightsVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

class SearchFlightsVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var leftArrowImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var buttonsHolderView: UIView!
    @IBOutlet weak var oneWayView: UIView!
    @IBOutlet weak var roundTripView: UIView!
    @IBOutlet weak var multiCityView: UIView!
    @IBOutlet weak var oneWayBtnView: UIView!
    @IBOutlet weak var oneWayBtnImage: UIImageView!
    @IBOutlet weak var oneWaylbl: UILabel!
    @IBOutlet weak var roundTripBtnView: UIView!
    @IBOutlet weak var roundTripBtnImage: UIImageView!
    @IBOutlet weak var roundTriplbl: UILabel!
    @IBOutlet weak var multiCityBtnView: UIView!
    @IBOutlet weak var multiCityBtnImage: UIImageView!
    @IBOutlet weak var multiCitylbl: UILabel!
    
    
    static var newInstance: SearchFlightsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightsVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var c1 = String()
    var c2 = String()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .clear
        leftArrowImg.image = UIImage(named: "leftarrow")
        oneWayBtnImage.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        roundTripBtnImage.image = UIImage(named: "roundtrip")
        multiCityBtnImage.image = UIImage(named: "multicity")
        
        setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupViews(v: buttonsHolderView, radius: 25, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .AppTabSelectColor)
        setupViews(v: roundTripView, radius: 18, color: .AppHolderViewColor)
        setupViews(v: multiCityView, radius: 18, color: .AppHolderViewColor)
        
        setupViews(v: oneWayBtnView, radius: 15, color: .WhiteColor.withAlphaComponent(0.5))
        setupViews(v: roundTripBtnView, radius: 15, color: .WhiteColor)
        setupViews(v: multiCityBtnView, radius: 15, color: .WhiteColor)
        
        
        setupLabels(lbl:titlelbl,text: "Search Flights", textcolor: .WhiteColor, font: .LatoMedium(size: 20))
        setupLabels(lbl:oneWaylbl,text: "One Way", textcolor: .WhiteColor, font: .LatoRegular(size: 14))
        setupLabels(lbl:roundTriplbl,text: "Round Trip", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl:multiCitylbl,text: "Multi City", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
        commonTableView.registerTVCells(["SearchFlightsTVCell","EmptyTVCell","TopAirlinesTVCell","MultiCityTVCell"])
        
    }
    
    func setupTV() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.SearchFlightsTVCell))
        tablerow.append(TableRow(title:"Top airlines",cellType:.TopAirlinesTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupMultiCityTV() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.MultiCityTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func oneWayBtnAction(_ sender: Any) {
        print("oneWayBtnAction")
        
        oneWayView.backgroundColor = .AppTabSelectColor
        oneWayBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.2)
        oneWaylbl.textColor = .WhiteColor
        oneWayBtnImage.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        roundTripView.backgroundColor = .AppHolderViewColor
        roundTripBtnView.backgroundColor = .WhiteColor
        roundTriplbl.textColor = .AppLabelColor
        roundTripBtnImage.image = UIImage(named: "roundtrip")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        multiCityView.backgroundColor = .AppHolderViewColor
        multiCityBtnView.backgroundColor = .WhiteColor
        multiCitylbl.textColor = .AppLabelColor
        multiCityBtnImage.image = UIImage(named: "multicity")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        setupTV()
    }
    
    @IBAction func roundTripBtnAction(_ sender: Any) {
        print("oneWayBtnAction")
        oneWayView.backgroundColor = .AppHolderViewColor
        oneWayBtnView.backgroundColor = .WhiteColor
        oneWaylbl.textColor = .AppLabelColor
        oneWayBtnImage.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        roundTripView.backgroundColor = .AppTabSelectColor
        roundTripBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.2)
        roundTriplbl.textColor = .WhiteColor
        roundTripBtnImage.image = UIImage(named: "roundtrip")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        multiCityView.backgroundColor = .AppHolderViewColor
        multiCityBtnView.backgroundColor = .WhiteColor
        multiCitylbl.textColor = .AppLabelColor
        multiCityBtnImage.image = UIImage(named: "multicity")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        setupTV()
    }
    
    @IBAction func multiCityBtnAction(_ sender: Any) {
        print("oneWayBtnAction")
        oneWayView.backgroundColor = .AppHolderViewColor
        oneWayBtnView.backgroundColor = .WhiteColor
        oneWaylbl.textColor = .AppLabelColor
        oneWayBtnImage.image = UIImage(named: "oneway")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        roundTripView.backgroundColor = .AppHolderViewColor
        roundTripBtnView.backgroundColor = .WhiteColor
        roundTriplbl.textColor = .AppLabelColor
        roundTripBtnImage.image = UIImage(named: "roundtrip")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        
        multiCityView.backgroundColor = .AppTabSelectColor
        multiCityBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.2)
        multiCitylbl.textColor = .WhiteColor
        multiCityBtnImage.image = UIImage(named: "multicity")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        setupMultiCityTV()
    }
    
    override func didTapOnFromCityBtnAction(cell: SearchFlightsTVCell) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = "From"
        self.present(vc, animated: true)
    }
    
    override func didTapOnToCityBtnAction(cell: SearchFlightsTVCell){
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = "To"
        self.present(vc, animated: true)
    }
    
    override func didTapOnSwipeCityBtnAction(cell: SearchFlightsTVCell) {
        c1 = cell.fromCitylbl.text ?? ""
        c2 = cell.toCitylbl.text ?? ""
        cell.fromCitylbl.text = c2
        cell.toCitylbl.text = c1
    }
    
    override func didTapOnDepartureBtnAction(cell: SearchFlightsTVCell) {
        dateSelectKey = "dep"
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "Departure Date"
        self.present(vc, animated: true)
    }
    
    override func didTapOnReturnBtnAction(cell: SearchFlightsTVCell) {
        dateSelectKey = "ret"
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "Ruturn Date"
        self.present(vc, animated: true)
    }
    
    override func addEconomyBtnAction(cell: SearchFlightsTVCell) {
        gotoTravellerEconomyVC()
    }
    
    override func addEconomyBtnAction(cell: MultiCityTVCell) {
        gotoTravellerEconomyVC()
    }
    
    func gotoTravellerEconomyVC() {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func moreOptionBtnAction(cell: SearchFlightsTVCell){
        cell.moreExpandViewHeight.constant = 200
        cell.moreOptionlbl.text = "Advanced Search Options"
        commonTableView.reloadData()
    }
    
    override func didTapOnairlineBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOnairlineBtnAction")
    }
    
    override func didTapOntimeReturnJourneyBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOntimeReturnJourneyBtnAction")
    }
    
    override func didTapOntimeOutwardJourneyBtnAction(cell: SearchFlightsTVCell) {
        print("didTapOntimeOutwardJourneyBtnAction")
    }
    
    
    override func didTapOnReturnJurneyRadioButton(cell: SearchFlightsTVCell) {
        print("didTapOnReturnJurneyRadioButton")
    }
    override func didTapOnDirectFlightRadioButton(cell: SearchFlightsTVCell) {
        print("didTapOnDirectFlightRadioButton")
    }
    
    
    override func didTapOnairlineBtnAction(cell: MultiCityTVCell) {
        print("didTapOnairlineBtnAction")
    }
    
    override func didTapOntimeReturnJourneyBtnAction(cell: MultiCityTVCell) {
        print("didTapOntimeReturnJourneyBtnAction")
    }
    
    override func didTapOntimeOutwardJourneyBtnAction(cell: MultiCityTVCell) {
        print("didTapOntimeOutwardJourneyBtnAction")
    }
    
    override func didTapOnSearchFlightBtnAction(cell: SearchFlightsTVCell) {
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}
