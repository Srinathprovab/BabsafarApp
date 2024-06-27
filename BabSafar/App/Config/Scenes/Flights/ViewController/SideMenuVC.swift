//
//  SideMenuVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class SideMenuVC: BaseTableVC, ProfileDetailsViewModelDelegate, LogoutViewModelDelegate {
    
    
    
    static var newInstance: SideMenuVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var viewmodel1:ProfileDetailsViewModel?
    var logoutvm :LogoutViewModel?
    var profilcallAPIBool = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        if profilcallAPIBool == true {
            DispatchQueue.main.async {
                self.callProfileDetailsAPI()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(callprofileapi), name: Notification.Name("reloadAfterLogin"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(callprofileapi), name: Notification.Name("callprofileapi"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    //MARK: - callprofileapi
    @objc func callprofileapi() {
        DispatchQueue.main.async {
            self.callProfileDetailsAPI()
        }
    }
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        viewmodel1 = ProfileDetailsViewModel(self)
        logoutvm = LogoutViewModel(self)
        setupUI()
        
    }
    
    
    func setupUI(){
        setupMenuTVCells()
        commonTableView.isScrollEnabled = true
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "LabelTVCell",
                                         "SideMenuTitleTVCell",
                                         "EmptyTVCell"])
    }
    
    
    //MARK: - call Profile Details API
    func callProfileDetailsAPI() {
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        viewmodel1?.CallGetProileDetails_API(dictParam: payload)
    }
    
    
    func getProfileDetails(response: ProfileDetailsModel) {
        print(" =====   getProfileDetails ====== \(response)")
        pdetails = response.data
        
        defaults.set(response.data?.email, forKey: UserDefaultsKeys.useremail)
        defaults.set(response.data?.phone, forKey: UserDefaultsKeys.usermobile)
        
        
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
    }
    
    func updateProfileDetails(response: ProfileDetailsModel) {
        
    }
    
    
    
    func setupMenuTVCells() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.MenuBGTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        if let loginstatus = defaults.object(forKey: UserDefaultsKeys.loggedInStatus) as? Bool ,loginstatus == true {
            tablerow.append(TableRow(title:"My Bookings",key: "menu", image: "bookings",cellType:.SideMenuTitleTVCell))
        }
        
        tablerow.append(TableRow(title:"Customer Support",key: "menu", image: "customer",cellType:.SideMenuTitleTVCell))
        tablerow.append(TableRow(title:"Services",key: "products", image: "",cellType:.SideMenuTitleTVCell))
        tablerow.append(TableRow(title:"Flights",key: "menu", image: "flightmenu",cellType:.SideMenuTitleTVCell))
        tablerow.append(TableRow(title:"Hotels",key: "menu", image: "hotelmenu",cellType:.SideMenuTitleTVCell))
        tablerow.append(TableRow(title:"Insurence",key: "menu", image: "insure",cellType:.SideMenuTitleTVCell))
        tablerow.append(TableRow(title:"Visa",key: "menu", image: "visatab",cellType:.SideMenuTitleTVCell))
      //  tablerow.append(TableRow(title:"Fastrack",key: "menu", image: "fasttrack",cellType:.SideMenuTitleTVCell))
        
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            tablerow.append(TableRow(title:"Logout",key: "menu", image: "logout",cellType:.SideMenuTitleTVCell))
            tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isVcFrom = "SideMenuVC"
        present(vc, animated: true)
        
    }
    
    
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.showKey = "profiledit"
        present(vc, animated: true)
    }
    
    
    func callLogoutAPI() {
        BASE_URL = BASE_URL1
        payload.removeAll()
        payload["username"] = defaults.string(forKey: UserDefaultsKeys.useremail) ?? ""
        logoutvm?.CALL_MOBILE_USER_LOGOUT_API(dictParam: payload)
    }
    
    
    func logoutSucessDetails(response: LogoutModel) {
        showToast(message: response.data ?? "")
        let seconds = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set("0", forKey: UserDefaultsKeys.userid)
            defaults.set("", forKey: UserDefaultsKeys.useremail)
            defaults.set("", forKey: UserDefaultsKeys.usermobile)
            defaults.set("", forKey: UserDefaultsKeys.uname)
            defaults.set("", forKey: UserDefaultsKeys.mcountrycode)
            
            // Reset Standard User Defaults
            UserDefaults.resetStandardUserDefaults()
            self.setupMenuTVCells()
        }
    }
    
    
}



extension SideMenuVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SideMenuTitleTVCell {
            
            switch cell.menuTitlelbl.text {
            case "My Bookings":
                gotoDashBoaardTabbarVC()
                break
                
            case "Flights":
                gotoSearchFlightsVC()
                break
                
            case "Hotels":
                gotoSearchHotelsVC()
                break
                
                
            case "Visa":
                gotoVisaEnduiryVC()
                break
                
                
            case "Insurence":
               // gotoInsuranceVC()
                showToast(message: "Still Under Development")
                break
                
                
//            case "Fastrack":
//                gotoSearchFastTrackVC()
//                break
                
                
            case "Logout":
                callLogoutAPI()
                break
                
            default:
                break
            }
        }
    }
    
    func gotoDashBoaardTabbarVC(){
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 1
        present(vc, animated: true)
    }
    
    
    func gotoSearchFlightsVC(){
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
    func gotoSearchHotelsVC(){
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func gotoVisaEnduiryVC(){
        guard let vc = VisaEnduiryVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    func gotoInsuranceVC(){
        guard let vc = InsuranceVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func gotoSearchFastTrackVC(){
        guard let vc = SearchFastTrackVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}
