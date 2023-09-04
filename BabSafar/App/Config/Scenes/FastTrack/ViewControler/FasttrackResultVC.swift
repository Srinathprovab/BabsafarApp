//
//  FasttrackResultVC.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit

class FasttrackResultVC: BaseTableVC, FasttrackViewModelDelegate {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var quickbookingView: UIView!
    @IBOutlet weak var exploreView: UIView!
    @IBOutlet weak var quickbookinglbl: UILabel!
    @IBOutlet weak var explorelbl: UILabel!
    @IBOutlet weak var depimg: UIImageView!
    @IBOutlet weak var airportNamelbl: UILabel!
    @IBOutlet weak var btnsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnsView: UIView!
    @IBOutlet weak var filterView: UIView!
    
    
    var availablePlans = [[AvailablePlans]]()
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    var fromList = [From]()
    var toList = [To]()
    
    var eploreList = [EList]()
    var key = "dep"
    var vm:FasttrackViewModel?
    static var newInstance: FasttrackResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.FastTrack.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FasttrackResultVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        if callapibool == true {
            holderView.isHidden = true
            if let selectedTab = defaults.object(forKey: UserDefaultsKeys.fasttrackJournyType) as? String ,selectedTab == "quick" {
                callQuickBookingAPI()
            }else {
                callExploreAPI()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = FasttrackViewModel(self)
        
    }
    
    func setupUI() {
        departureSelected()
        commonTableView.registerTVCells(["QuickBookingResultTVCell",
                                         "EmptyTVCell",
                                         "ExploreResultTVCell"])
    }
    
    func departureSelected() {
        key = "dep"
        airportNamelbl.text = defaults.string(forKey: UserDefaultsKeys.frfromCity)
        quickbookingView.backgroundColor = HexColor("#D7B912")
        exploreView.backgroundColor = .WhiteColor
        depimg.image = UIImage(named: "dep")?.withRenderingMode(.alwaysOriginal)
        DispatchQueue.main.async {[self] in
            setupQuickBookingTV()
        }
    }
    
    func arrivalSelected() {
        key = "arrival"
        airportNamelbl.text = defaults.string(forKey: UserDefaultsKeys.frtoCity)
        quickbookingView.backgroundColor = .WhiteColor
        exploreView.backgroundColor = HexColor("#D7B912")
        depimg.image = UIImage(named: "arrival")?.withRenderingMode(.alwaysOriginal)
        DispatchQueue.main.async {[self] in
            setupQuickBookingTV()
        }
    }
    
    
    
    
    
    //MARK: - didTapOnSelectBtnAction QuickBookingResultTVCell
    override func didTapOnSelectBtnAction(cell: QuickBookingResultTVCell) {
        if key == "dep" {
            gotoSelectedServicesVC(airportname: self.airportNamelbl.text ?? "",
                                   terminal: cell.titlelbl.text ?? "",
                                   logoname: "dep")
        }else {
            gotoSelectedServicesVC(airportname: self.airportNamelbl.text ?? "",
                                   terminal: cell.titlelbl.text ?? "",
                                   logoname: "arrival")
        }
    }
    
    func gotoSelectedServicesVC(airportname:String,terminal:String,logoname:String) {
        callapibool = true
        guard let vc = SelectedServicesVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.airportName = airportname
        vc.terminal = terminal
        vc.logoImg = logoname
        self.present(vc, animated: false)
    }
    
    
    
    @IBAction func didTapOnBackBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnEditSearchBtn(_ sender: Any) {
        print("didTapOnEditSearchBtn")
    }
    
    
    @IBAction func didTapOnDepBtnAction(_ sender: Any) {
        departureSelected()
    }
    
    @IBAction func didTapOnArrivalBtnAction(_ sender: Any) {
        arrivalSelected()
    }
    
    
    
    //MARK: - didTapOnBookNowBtnAction ExploreResultTVCell
    override func didTapOnBookNowBtnAction(cell: ExploreResultTVCell) {
        print(cell.titlelbl.text)
    }
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        print("didTapOnFilterBtnAction")
    }
    
    
}


extension FasttrackResultVC {
    
    func callQuickBookingAPI() {
        vm?.CALL_FASTTRACK_API(dictParam: payload)
    }
    
    func fasttrackList(response: FasttrackModel) {
        holderView.isHidden = false
        filterView.isHidden = true
        btnsView.isHidden = false
        btnsViewHeight.constant = 50
        fromList = response.fasttrackdata?.col_x?.list?.from ?? []
        toList = response.fasttrackdata?.col_x?.list?.to ?? []
        
        citylbl.text = "\(response.fasttrackdata?.col_x?.search_params?.from_loc_airport_city ?? "")(\(response.fasttrackdata?.col_x?.search_params?.from_loc ?? "")) - \(response.fasttrackdata?.col_x?.search_params?.to_loc_airport_city ?? "")(\(response.fasttrackdata?.col_x?.search_params?.to_loc ?? ""))"
        
        datelbl.text = "\(response.fasttrackdata?.col_x?.search_params?.departure_date ?? "") to \(response.fasttrackdata?.col_x?.search_params?.arrival_date ?? "") | \(defaults.string(forKey: UserDefaultsKeys.frtravellerDetails) ?? "")"
        
        DispatchQueue.main.async {
            self.setupQuickBookingTV()
        }
        
    }
    
    func setupQuickBookingTV() {
        tablerow.removeAll()
        
        
        if key == "dep" {
            fromList.forEach { i in
                tablerow.append(TableRow(title:i.sku,
                                         price: i.category_id,
                                         cellType:.QuickBookingResultTVCell))
            }
        }else {
            toList.forEach { i in
                tablerow.append(TableRow(title:i.sku,
                                         price: i.category_id,
                                         cellType:.QuickBookingResultTVCell))
            }
        }
        
        tablerow.append(TableRow(height:50,
                                 bgColor: .AppHolderViewColor,
                                 cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    
}


extension FasttrackResultVC {
    
    func callExploreAPI() {
        vm?.CALL_EXPLORE_SEARCH_API(dictParam: payload)
    }
    
    func exploreSearchList(response: ExploreModel) {
        holderView.isHidden = false
        filterView.isHidden = false
        btnsView.isHidden = true
        btnsViewHeight.constant = 0
        
        eploreList = response.fasttrackdata?.col_x?.list ?? []
        
        citylbl.text = "\(response.fasttrackdata?.col_x?.search_params?.to_loc_airport_city ?? "")(\(response.fasttrackdata?.col_x?.search_params?.to_loc ?? ""))"
        
        datelbl.isHidden = true
        
        DispatchQueue.main.async {
            self.setupExploreTV()
        }
        
    }
    
    
    
    func setupExploreTV() {
        tablerow.removeAll()
        
        eploreList.forEach { i in
            tablerow.append(TableRow(title:i.sku,image: "",cellType:.ExploreResultTVCell))
        }
        
        tablerow.append(TableRow(height:50,
                                 bgColor: .AppHolderViewColor,
                                 cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    

}



extension FasttrackResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callQuickBookingAPI()
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
