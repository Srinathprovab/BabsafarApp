//
//  ModifySearchHotelVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class ModifySearchHotelVC: BaseTableVC, HotelSearchViewModelDelegate {
    
    
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var viewModel:HotelSearchViewModel?
    var tablerow = [TableRow]()
    static var newInstance: ModifySearchHotelVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchHotelVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
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
        setupUI()
        viewModel = HotelSearchViewModel(self)
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        commonTableView.registerTVCells(["ButtonTVCell","CommonFromCityTVCell","EmptyTVCell","LabelTVCell"])
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.layer.borderWidth = 1
        commonTableView.layer.borderColor = UIColor.clear.cgColor
        commonTableView.isScrollEnabled = false
        setuptv()
        
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("reload"), object: nil)
        
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        commonTableView.reloadData()
    }
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Modify",key: "modifyhotel",cellType:.LabelTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        
        tablerow.append(TableRow(title:"Location/City",subTitle: defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "Add City",key:"search", image: "",cellType:.CommonFromCityTVCell))
        
        tablerow.append(TableRow(title:"Check-In",subTitle: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Add Check In Date",key:"dual", text:"Check-On", tempText: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Add Check Out Date",cellType:.CommonFromCityTVCell))
        
        tablerow.append(TableRow(title:"Rooms & Guests",subTitle: "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "Add") Rooms ,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "0") Adults,\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") Childrens",key:"dual1", image: "downarrow",cellType:.CommonFromCityTVCell))
        
        
        
        
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Search Hotels",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    override func didTapOnCloseBtn(cell: LabelTVCell) {
        callapibool = false
        dismiss(animated: true)
    }
    
    override func viewBtnAction(cell: CommonFromCityTVCell) {
        print(cell.subtitlelbl.text as Any)
        switch cell.titlelbl.text {
        case "Location/City":
            gotoFromCitySearchVC()
            break
        case "Rooms & Guests":
            gotoAddAdultEconomyVC()
            break
        default:
            break
        }
    }
    
    override func didTapOnDual1Btn(cell:CommonFromCityTVCell){
        gotoCalenderVC()
    }
    override func didTapOnDual2Btn(cell:CommonFromCityTVCell){
        gotoCalenderVC()
    }
    
    
    
    func gotoFromCitySearchVC() {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    func gotoAddAdultEconomyVC() {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keyString = "hotels"
        self.present(vc, animated: true)
    }
    
    func gotoCalenderVC() {
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        callAPI()
    }
    
    
    
    func callAPI() {
        
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationcityid)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        payload["adult"] = ["2"]
        payload["child"] = ["0"]
        payload["childAge_1"] = ["0","0"]
        payload["nationality"] = "IN"
        
        do {
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            
     //       BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"
            payload1["search_params"] = theJSONText
            viewModel?.CallHotelSearchAPI(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    
    func hoteSearchResult(response: HotelSearchModel) {
        response.data?.hotelSearchResult?.forEach({ i in
            print( i.image)
        })
        hotelSearchResult = response.data?.hotelSearchResult ?? []
        gotoSearchHotelsResultVC()
    }
    
    func gotoSearchHotelsResultVC(){
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}



