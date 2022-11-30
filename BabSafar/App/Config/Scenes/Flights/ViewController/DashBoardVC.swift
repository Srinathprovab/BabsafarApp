//
//  DashBoardVC.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class DashBoardVC: BaseTableVC, TopFlightDetailsViewModelDelegate {
    
    
    @IBOutlet weak var banerImage: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var banerView: UIView!
    @IBOutlet weak var selectLangView: UIView!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var langLeftImage: UIImageView!
    @IBOutlet weak var langDropdownImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tabSelectionView: UIView!
    @IBOutlet weak var tabSelectCV: UICollectionView!
    
    
    //MARK: LOCAL VARIABLES
    var tabNames = ["Flights","Hotels","Visa"]
    var tabNamesImages = ["flight","hotel","visa"]
    var tableRow = [TableRow]()
    var viewmodel:TopFlightDetailsViewModel?
    
    
    
    //MARK: - LOADING FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
            switch tabselect {
                
            case "Flights":
                DispatchQueue.main.async {[self] in
                    callTopFlightsHotelsDetailsAPI()
                }
                break
                
                
            default:
                break
            }
        }
            
        
       
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.gotoPrivacyScreen()
            }
            defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
            defaults.set(0, forKey: UserDefaultsKeys.DashboardTapSelectedCellIndex)
            tabSelectCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
            defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
            defaults.set(0, forKey: UserDefaultsKeys.journeyTypeSelectedIndex)
            defaults.set("English", forKey: UserDefaultsKeys.APICurrencyType)
            defaults.set("English", forKey: UserDefaultsKeys.APILanguageType)
            langLabel.text = "EN"
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: Notification.Name("reload"), object: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        setupCV()
        setupUI()
        viewmodel = TopFlightDetailsViewModel(self)
    }
    
    
    
    //MARK: - VIEW SETUP
    func setupUI() {
        
       
        holderView.backgroundColor = .WhiteColor
        banerImage.image = UIImage(named: "baner")
        banerImage.contentMode = .scaleAspectFill
        selectLangView.backgroundColor = .clear
        tabSelectionView.addCornerRadiusWithShadow(color: .clear , borderColor: .clear, cornerRadius: 6)
        tabSelectionView.backgroundColor = .WhiteColor.withAlphaComponent(0.5)
        tabSelectCV.backgroundColor = .clear
        langLeftImage.image = UIImage(named: "lang")
        langDropdownImage.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        setuplabels(lbl: langLabel, text: defaults.string(forKey: UserDefaultsKeys.APILanguageType) ?? "", textcolor: .WhiteColor, font: .LatoSemibold(size: 14), align: .center)
        setuplabels(lbl: titleLabel, text: "Search for flights toanywhere.", textcolor: .WhiteColor, font: .LatoRegular(size: 22), align: .left)
        
        
        //MARK: REGISTER TABEL VIEW CELLS
        self.commonTableView.registerTVCells(["SpecialDealsTVCell","TopCityTVCell","EmptyTVCell"])
        
        
    }
    
    
    //MARK: RELOAD TABLE VIEW
    @objc func reload(notification: Notification) {
        commonTableView.reloadData()
    }
    
    
    //MARK: CALL TOP FLIGHT HOTEL DETAILS API FUNCTION
    func callTopFlightsHotelsDetailsAPI() {
        BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"
        viewmodel?.callTopFlightsHotelsDetailsAPI(dictParam: [:])
    }
    
    //MARK: CALL TOP FLIGHT DETAILS IMAGES API FUNCTION
    func topFlightDetailsImages(response: TopFlightDetailsModel) {
        print(" ======= topFlightDetailsImages ======== ")
        topFlightDetails = response.topFlightDetails ?? []
        topHotelDetails = response.topHotelDetails ?? []
        
        DispatchQueue.main.async {[self] in
            setupTV()
        }
        
    }
    
    
    
    
    //MARK: SETUP INITIAL TABLEVIEW CELLS
    func setupTV() {
        tableRow.removeAll()
        tableRow.append(TableRow(cellType:.SpecialDealsTVCell))
        tableRow.append(TableRow(title:"Top International City",key: "flights",cellType:.TopCityTVCell))
        tableRow.append(TableRow(height:16,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Top International Hotels",key: "hotels",cellType:.TopCityTVCell))
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    //MARK: SETUP COLLECTION VIEW CELL
    func setupCV() {
        let nib = UINib(nibName: "TabSelectCVCell", bundle: nil)
        tabSelectCV.register(nib, forCellWithReuseIdentifier: "cell")
        tabSelectCV.delegate = self
        tabSelectCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        tabSelectCV.collectionViewLayout = layout
        tabSelectCV.isScrollEnabled = false
    }
    
    
    //MARK: GOTO PRIVACY SETUP SCREEN
    func gotoPrivacyScreen() {
        guard let vc = YourPrivacyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: GOTO SEARCH FLIGHT SCREEN
    func gotoSearchFlightScreen() {
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: GO TO VISA ENQUIREY SCREEN
    func gotoVisaEnduiryVC() {
        guard let vc = VisaEnduiryVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: GOTO SEARCH HOTEL SCREEN
    func gotoSearchHotelsVC() {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: TAP ON MENU BUTTON ACTION
    @IBAction func menuButtonAction(_ sender: Any) {
        guard let vc = SideMenuVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        UIView.animate(withDuration: 5, delay: 5, options: UIView.AnimationOptions(), animations: { () -> Void in
            
        }, completion: { (finished: Bool) -> Void in
            self.present(vc, animated: false)
        })
    }
    
    
    
    //MARK: SELECT LANGUAGE BUTTON ACTION
    @IBAction func selectLangButtonAction(_ sender: Any) {
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
}





extension DashBoardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TabSelectCVCell {
            cell.titlelbl.text = tabNames[indexPath.row]
            cell.img.image = UIImage(named: tabNamesImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
            
            if indexPath.row == defaults.integer(forKey: UserDefaultsKeys.DashboardTapSelectedCellIndex) {
                cell.imageStr = tabNamesImages[indexPath.row]
                cell.selected()
                setupTV()
                tabSelectCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                
            }
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? TabSelectCVCell {
            defaults.set(tabNames[indexPath.row], forKey: UserDefaultsKeys.dashboardTapSelected)
            defaults.set(indexPath.row, forKey: UserDefaultsKeys.DashboardTapSelectedCellIndex)
            cell.imageStr = tabNamesImages[indexPath.row]
            cell.selected()
            
            switch indexPath.row {
            case 0:
                gotoSearchFlightScreen()
                break
                
            case 1:
                gotoSearchHotelsVC()
                break
                
            case 2:
                gotoVisaEnduiryVC()
                break
                
            default:
                break
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TabSelectCVCell {
            cell.unselected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 90)
        
    }
    
}
