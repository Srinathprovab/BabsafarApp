//
//  DashBoardVC.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class DashBoardVC: BaseTableVC {
    
    @IBOutlet weak var banerImage: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var banerView: UIView!
    @IBOutlet weak var selectLangView: UIView!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var langLeftImage: UIImageView!
    @IBOutlet weak var langDropdownImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tabSelectionView: UIView!
    @IBOutlet weak var flightHolderView: UIView!
    @IBOutlet weak var flightimage: UIImageView!
    @IBOutlet weak var hotelHolderView: UIView!
    @IBOutlet weak var hotelimage: UIImageView!
    @IBOutlet weak var insuranceHolderView: UIView!
    @IBOutlet weak var insuranceImage: UIImageView!
    @IBOutlet weak var visaHolderView: UIView!
    @IBOutlet weak var visatimag: UIImageView!
    @IBOutlet weak var lblFlight: UILabel!
    @IBOutlet weak var lblHotel: UILabel!
    @IBOutlet weak var lblInsurance: UILabel!
    @IBOutlet weak var lblVisa: UILabel!
    
    
    
    var tableRow = [TableRow]()
    
    override func viewWillAppear(_ animated: Bool) {
        defaults.set("flights", forKey: UserDefaultsKeys.dashboardTapSelected)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        setupUI()
        setupTV()
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        banerImage.image = UIImage(named: "baner")
        banerImage.contentMode = .scaleAspectFill
        selectLangView.backgroundColor = .clear
        tabSelectionView.backgroundColor = .WhiteColor.withAlphaComponent(0.5)
        flightHolderView.backgroundColor = .AppTabSelectColor
        flightHolderView.layer.cornerRadius = 6
        flightHolderView.clipsToBounds = true
        hotelHolderView.backgroundColor = .WhiteColor
        hotelHolderView.layer.cornerRadius = 6
        hotelHolderView.clipsToBounds = true
        insuranceHolderView.backgroundColor = .WhiteColor
        insuranceHolderView.layer.cornerRadius = 6
        insuranceHolderView.clipsToBounds = true
        visaHolderView.backgroundColor = .WhiteColor
        visaHolderView.layer.cornerRadius = 6
        visaHolderView.clipsToBounds = true
        
        langLeftImage.image = UIImage(named: "lang")
        langDropdownImage.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        flightimage.image = UIImage(named: "flight")
        hotelimage.image = UIImage(named: "hotel")
        insuranceImage.image = UIImage(named: "insurence")
        visatimag.image = UIImage(named: "visa")
        
        langLabel.text = "EN"
        langLabel.textColor = .WhiteColor
        langLabel.font = UIFont.LatoSemibold(size: 14)
        
        titleLabel.text = "Search for flights toanywhere."
        titleLabel.textColor = .WhiteColor
        titleLabel.font = UIFont.LatoRegular(size: 22)
        titleLabel.numberOfLines = 0
        
        lblFlight.text = "Flights"
        lblFlight.textColor = .WhiteColor
        lblFlight.font = UIFont.LatoRegular(size: 14)
        
        lblHotel.text = "Hotels"
        lblHotel.textColor = .WhiteColor
        lblHotel.font = UIFont.LatoRegular(size: 14)
        
        lblInsurance.text = "Insurence"
        lblInsurance.textColor = .WhiteColor
        lblInsurance.font = UIFont.LatoRegular(size: 14)
        
        lblVisa.text = "Visa"
        lblVisa.textColor = .WhiteColor
        lblVisa.font = UIFont.LatoRegular(size: 14)
        
        
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.gotoPrivacyScreen()
            }
        }
        
        self.commonTableView.registerTVCells(["SpecialDealsTVCell","TopCityTVCell","EmptyTVCell"])
        
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("reload"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        commonTableView.reloadData()
    }
    
    func gotoPrivacyScreen() {
        guard let vc = YourPrivacyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    func gotoSearchFlightScreen() {
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func gotoInsurenceVC() {
        guard let vc = InsuranceVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func gotoVisaEnduiryVC() {
        guard let vc = VisaEnduiryVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func gotoSearchHotelsVC() {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    func setupTV() {
        tableRow.removeAll()
        tableRow.append(TableRow(cellType:.SpecialDealsTVCell))
        tableRow.append(TableRow(title:"Top International City",cellType:.TopCityTVCell))
        tableRow.append(TableRow(height:16,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Top International Hotels",cellType:.TopCityTVCell))
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    
    
    @IBAction func menuButtonAction(_ sender: Any) {
        guard let vc = SideMenuVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        UIView.animate(withDuration: 5, delay: 5, options: UIView.AnimationOptions(), animations: { () -> Void in
            
        }, completion: { (finished: Bool) -> Void in
            self.present(vc, animated: false)
        })
    }
    
    @IBAction func selectLangButtonAction(_ sender: Any) {
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func searchFlightBtnAction(_ sender: Any) {
        defaults.set("flights", forKey: UserDefaultsKeys.dashboardTapSelected)
        
        flightHolderView.backgroundColor = .AppTabSelectColor
        flightimage.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        hotelHolderView.backgroundColor = .WhiteColor
        hotelimage.image = UIImage(named: "hotel")
        
        insuranceHolderView.backgroundColor = .WhiteColor
        insuranceImage.image = UIImage(named: "insurence")
        
        visaHolderView.backgroundColor = .WhiteColor
        visatimag.image = UIImage(named: "visa")
        
        gotoSearchFlightScreen()
        
    }
    
    @IBAction func searchHotelsBtnAction(_ sender: Any) {
        defaults.set("hotels", forKey: UserDefaultsKeys.dashboardTapSelected)
        
        flightHolderView.backgroundColor = .WhiteColor
        flightimage.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImageDefaultColor)
        
        hotelHolderView.backgroundColor = .AppTabSelectColor
        hotelimage.image = UIImage(named: "hotel")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        insuranceHolderView.backgroundColor = .WhiteColor
        insuranceImage.image = UIImage(named: "insurence")
        
        visaHolderView.backgroundColor = .WhiteColor
        visatimag.image = UIImage(named: "visa")
        
        gotoSearchHotelsVC()
    }
    
    @IBAction func searchHInsuranceBtnAction(_ sender: Any) {
        defaults.set("insurence", forKey: UserDefaultsKeys.dashboardTapSelected)
        
        flightHolderView.backgroundColor = .WhiteColor
        flightimage.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImageDefaultColor)
        
        hotelHolderView.backgroundColor = .WhiteColor
        hotelimage.image = UIImage(named: "hotel")
        
        insuranceHolderView.backgroundColor = .AppTabSelectColor
        insuranceImage.image = UIImage(named: "insurence")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        visaHolderView.backgroundColor = .WhiteColor
        visatimag.image = UIImage(named: "visa")
        
        gotoInsurenceVC()
    }
    
    
    @IBAction func searchVisaBtnAction(_ sender: Any) {
        defaults.set("visa", forKey: UserDefaultsKeys.dashboardTapSelected)
        
        flightHolderView.backgroundColor = .WhiteColor
        flightimage.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImageDefaultColor)
        
        hotelHolderView.backgroundColor = .WhiteColor
        hotelimage.image = UIImage(named: "hotel")
        
        insuranceHolderView.backgroundColor = .WhiteColor
        insuranceImage.image = UIImage(named: "insurence")
        
        visaHolderView.backgroundColor = .AppTabSelectColor
        visatimag.image = UIImage(named: "visa")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        gotoVisaEnduiryVC()
    }
    
    override func didTapFlightsTabBtnAction(cell: SpecialDealsTVCell) {
        cell.flightlbl.textColor = .WhiteColor
        cell.flightTabView.backgroundColor = .AppTabSelectColor
        cell.flightViewUL.backgroundColor = .AppTabSelectColor
        
        cell.hotelslbl.textColor = .AppLabelColor
        cell.hotelsTabView.backgroundColor = .WhiteColor
        cell.hotelViewUL.backgroundColor = .WhiteColor
    }
    
    override func didTapHotelsTabBtnAction(cell: SpecialDealsTVCell) {
        cell.flightlbl.textColor = .AppLabelColor
        cell.flightTabView.backgroundColor = .WhiteColor
        cell.flightViewUL.backgroundColor = .WhiteColor
        
        cell.hotelslbl.textColor = .WhiteColor
        cell.hotelsTabView.backgroundColor = .AppTabSelectColor
        cell.hotelViewUL.backgroundColor = .AppTabSelectColor
    }
    
    override func viewAllBtnAction(cell: SpecialDealsTVCell) {
        print("viewAllBtnAction SpecialDealsTVCell")
    }
    
    override func didTapOnPromoCodeBtnAction(cell: SpecialDealsTVCell) {
        print("didTapOnPromoCodeBtnAction")
    }
    
    override func viewAllBtnAction(cell: TopCityTVCell) {
        print("viewAllBtnAction TopCityTVCell ")
    }
    
    
}


