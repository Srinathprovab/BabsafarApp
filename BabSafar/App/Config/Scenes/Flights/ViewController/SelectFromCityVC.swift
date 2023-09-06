//
//  SelectFromCityVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire


class SelectFromCityVC: BaseTableVC, SelectCityViewModelProtocal, HotelCitySearchViewModelDelegate {
    
    
    
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var leftArrowImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    
    
    var tokey = String()
    var filtered:[SelectCityModel] = []
    var cityList:[SelectCityModel] = []
    var hotelfiltered:[HotelCityListModel] = []
    var hotelList = [HotelCityListModel]()
    var cityViewModel: SelectCityViewModel?
    var cityViewModel1: HotelCitySearchViewModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var payload = [String:Any]()
    var isSearchBool = Bool()
    var searchText = String()
    var celltag = Int()
    var keyStr = String()
    
    
    static var newInstance: SelectFromCityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectFromCityVC
        return vc
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        callapibool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.celltag = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        
        searchTF.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        if let selectedtab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedtab == "Flights" {
                callApi()
            }else {
                CALL_CITY_OR_HOTEL_SEARCH_API(str: "")
            }
        }
    }
    
    
    func callApi() {
        CallShowCityListAPI(str: "")
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
    
    
    //MARK: - CITY SEARCH API
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        // cityViewModel?.CallShowCityListAPI(dictParam: payload)
        cityViewModel?.CallShowCityList_multicity_API(dictParam: payload)
    }
    
    func ShowCityList(response: [SelectCityModel]) {
        self.cityList = response
        print(cityList)
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    func ShowCityListMulticity(response: [SelectCityModel]) {
        self.cityList = response
        print(cityList)
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    //MARK: - CITY OR HOTEL LIST API
    
    func CALL_CITY_OR_HOTEL_SEARCH_API(str:String) {
        
        payload["term"] = str
        cityViewModel1?.CallHotelCitySearchAPI(dictParam: payload)
    }
    
    func hotelCitySearchResult(response: [HotelCityListModel]) {
        hotelList = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        cityViewModel = SelectCityViewModel(self)
        cityViewModel1 = HotelCitySearchViewModel(self)
        
    }
    
    func setupUI() {
        // setupViews(v: searchTextfieldHolderView, radius: 25, color: .WhiteColor.withAlphaComponent(0.5))
        searchTextfieldHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 25)
        searchTextfieldHolderView.backgroundColor = .AppHolderViewColor
        leftArrowImg.image = UIImage(named: "leftarrow")
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        
        setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupLabels(lbl:titlelbl,text: titleStr , textcolor: .WhiteColor, font: .LatoMedium(size: 20))
        
        searchTF.backgroundColor = .clear
        searchTF.placeholder = "Search airport /City"
        searchTF.setLeftPaddingPoints(20)
        searchTF.font = UIFont.LatoRegular(size: 16)
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        
        //  commonTableView.registerTVCells(["FromCityTVCell","EmptyTVCell"])
        commonTableView.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        commonTableView.separatorStyle = .singleLine
        commonTableView.separatorColor = .lightGray
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
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
            
        }
        
        if let selectedtab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedtab == "Flights" {
                CallShowCityListAPI(str: searchText)
            }else {
                CALL_CITY_OR_HOTEL_SEARCH_API(str: searchText)
            }
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        filtered.removeAll()
        hotelfiltered.removeAll()
        
        if let selectedtab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedtab == "Flights" {
                filtered = self.cityList.filter { thing in
                    return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
                }
            }else {
                hotelfiltered = self.hotelList.filter { thing in
                    return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
                }
            }
        }
        
        commonTableView.reloadData()
    }
    
    
    
    
    
    func gotoSearchFlightsVC() {
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        keyStr = "select"
        vc.isfromVc = "city"
        self.present(vc, animated: false)
    }
    
    func gotoSearchHotelsVC() {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


extension SelectFromCityVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if let selectedtab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedtab == "Flights" {
                //check search text & original text
                if( isSearchBool == true){
                    return filtered.count
                }else{
                    return cityList.count
                }
            }else {
                //check search text & original text
                if( isSearchBool == true){
                    return hotelfiltered.count
                }else{
                    return hotelList.count
                }
            }
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FromCityTVCell
        
        if let selectedtab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedtab == "Flights" {
                if( isSearchBool == true){
                    let dict = filtered[indexPath.row]
                    cell.titlelbl.text = dict.label
                    cell.subTitlelbl.text = dict.value
                    cell.id = dict.id ?? ""
                    cell.cityShortNamelbl.text = dict.code
                    cell.value = dict.value ?? ""
                    cell.citycode = "\(dict.name ?? "")"
                    cell.cityname = dict.city ?? ""
                }else{
                    let dict = cityList[indexPath.row]
                    cell.titlelbl.text = dict.label
                    cell.subTitlelbl.text = dict.value
                    cell.id = dict.id ?? ""
                    cell.cityShortNamelbl.text = dict.code
                    cell.value = dict.value ?? ""
                    cell.citycode = "\(dict.name ?? "")"
                    cell.cityname = dict.city  ?? ""
                }
                
            }else {
                if( isSearchBool == true){
                    let dict = hotelfiltered[indexPath.row]
                    cell.titlelbl.text = dict.label
                    cell.subTitlelbl.text = dict.value
                    cell.id = dict.id ?? ""
                    cell.cityShortNamelbl.text = dict.id
                    cell.value = dict.value ?? ""
                    cell.citycode = "\(dict.label ?? "")"
                    cell.cityname = dict.label ?? ""
                }else{
                    let dict = hotelList[indexPath.row]
                    cell.titlelbl.text = dict.label
                    cell.subTitlelbl.text = dict.value
                    cell.id = dict.id ?? ""
                    cell.cityShortNamelbl.text = dict.id
                    cell.value = dict.value ?? ""
                    cell.citycode = "\(dict.label ?? "")"
                    cell.cityname = dict.label  ?? ""
                }
                
            }
        }
        
        
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            if let selectedtab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
                if selectedtab == "Flights" {
                    
                    
                    if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if journeyType == "oneway" {
                            if titleStr == "From" {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.fromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.fromlocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.fromairport)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.fromcityname)
                                
                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.toCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.tolocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.toairport)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.tocityname)
                                
                            }
                        }else if journeyType == "circle"{
                            if titleStr == "From" {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rfromlocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.rfromairport)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.rfromcityname)
                                
                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rtolocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.rtoairport)
                                defaults.set(cell.cityname , forKey: UserDefaultsKeys.rtocityname)
                                
                            }
                        }else {
                            
        
                            
                            if titleStr == "From" {
                                
                                
                                addmulticityCount += 1
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mfromlocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.mfromairportCode)
                                defaults.set(cell.value , forKey: UserDefaultsKeys.mfromCityValue)
                                
                                fromCityNameArray[self.celltag] = cell.titlelbl.text ?? ""
                                fromCityShortNameArray[self.celltag] = cell.cityShortNamelbl.text ?? ""
                                
                                fromCityArray[self.celltag] = cell.value
                                fromlocidArray[self.celltag] = cell.id
                                defaults.set(cell.citycode , forKey: UserDefaultsKeys.mfromCity1)
                                
                               
                                
                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mtolocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.mtoairportCode)
                                defaults.set(cell.value , forKey: UserDefaultsKeys.mtoCityValue)
                                
                                toCityNameArray[self.celltag] = cell.titlelbl.text ?? ""
                                toCityShortNameArray[self.celltag] = cell.cityShortNamelbl.text ?? ""
                                
                                toCityArray[self.celltag] = cell.value
                                tolocidArray[self.celltag] = cell.id
                                
                                defaults.set(cell.citycode , forKey: UserDefaultsKeys.mtoCity1)
                                
                                if addmulticityCount < fromCityNameArray.count {
                                    addmulticityCount += 1
                                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mfromCity)
                                    defaults.set(cell.id , forKey: UserDefaultsKeys.mfromlocid)
                                    defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.mfromairportCode)
                                    defaults.set(cell.value , forKey: UserDefaultsKeys.mfromCityValue)
                                    
                                    
                                  
                                    
                                    if self.celltag + 1 < fromCityNameArray.count {
                                        
                                        fromCityNameArray[self.celltag + 1] = cell.titlelbl.text ?? ""
                                        fromCityShortNameArray[self.celltag + 1] = cell.cityShortNamelbl.text ?? ""
                                        fromCityArray[self.celltag + 1] = cell.value
                                        fromlocidArray[self.celltag + 1] = cell.id
                                        
                                    } else {
                                        
                                    }
                                    
                                    defaults.set(cell.citycode , forKey: UserDefaultsKeys.mfromCity1)

                                }
                                
                                
                            }
                            
                        }
                    }
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    NotificationCenter.default.post(name: NSNotification.Name("fromSelectCityVC"), object: nil)
                    
                    
                    if titleStr == "From" {
                        guard let vc = SelectFromCityVC.newInstance.self else {return}
                        vc.modalPresentationStyle = .fullScreen
                        callapibool = true
                        vc.titleStr = "To"
                        vc.tokey = "toooo"
                        present(vc, animated: false)
                    }else {
                        
                        
                        if tokey == "frommm" {
                            dismiss(animated: true, completion: nil)
                        }else {
                            // presentingViewController?.presentingViewController?.dismiss(animated: true)
                            gotoCalenderVC(key: "dep", titleStr: "Departure Date")
                        }
                    }
                }else {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.locationcity)
                    defaults.set(cell.id, forKey: UserDefaultsKeys.locationcityid)
                    defaults.set(cell.cityname, forKey: UserDefaultsKeys.locationcityname)
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    self.gotoSearchHotelsVC()
                }
            }
        }
        
        
    }
    
    
    func gotoCalenderVC(key:String,titleStr:String) {
        dateSelectKey = key
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = titleStr
        callapibool = true
        self.present(vc, animated: false)
    }
}
