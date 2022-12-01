//
//  SelectFromCityVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire


class SelectFromCityVC: BaseTableVC, SelectCityViewModelProtocal {
    
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var leftArrowImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    
    var filtered:[SelectCityModel] = []
    var cityList:[SelectCityModel] = []
    var cityViewModel: SelectCityViewModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var payload = [String:Any]()
    var isSearchBool = Bool()
    var searchText = String()
    var celltag = Int()
    
    
    static var newInstance: SelectFromCityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectFromCityVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CallShowCityListAPI(str: "")
        
        self.celltag = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(noInterNet(notification:)), name: NSNotification.Name("nointernet"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV(notification:)), name: NSNotification.Name("reloadTV"), object: nil)
    }
    
    @objc func noInterNet(notification:NSNotification) {
        let msg = notification.object as? String
        if msg == "no internet" {
            guard let vc = NoInternetConnectionVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false)
        }
    }
    
    @objc func reloadTV(notification:NSNotification) {
        CallShowCityListAPI(str: "")
    }
    
    
    func CallShowCityListAPI(str:String) {
        BASE_URL = "https://provabdevelopment.com/alghanim_new/mobile_webservices/mobile/index.php/ajax/"
        
        payload["term"] = str
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        cityViewModel = SelectCityViewModel(self)
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
    }
    
    func setupUI() {
        setupViews(v: searchTextfieldHolderView, radius: 25, color: .WhiteColor.withAlphaComponent(0.5))
        
        leftArrowImg.image = UIImage(named: "leftarrow")
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupLabels(lbl:titlelbl,text: titleStr , textcolor: .WhiteColor, font: .LatoMedium(size: 20))
        
        searchTF.backgroundColor = .clear
        searchTF.placeholder = "search airport /city"
        searchTF.setLeftPaddingPoints(20)
        searchTF.font = UIFont.LatoRegular(size: 16)
        
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
        
        CallShowCityListAPI(str: searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        filtered.removeAll()
        filtered = self.cityList.filter { thing in
            return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        commonTableView.reloadData()
    }
    
    
    
    func ShowCityList(response: [SelectCityModel]) {
        
        print(response.first)
        self.cityList = response
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    func gotoSearchFlightsVC() {
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
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
        //check search text & original text
        if( isSearchBool == true){
            return filtered.count
        }else{
            return cityList.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FromCityTVCell
        if( isSearchBool == true){
            let dict = filtered[indexPath.row]
            cell.titlelbl.text = dict.label
            cell.subTitlelbl.text = dict.value
            cell.id = dict.id ?? ""
            cell.cityShortNamelbl.text = dict.code
            cell.value = dict.value ?? ""
        }else{
            let dict = cityList[indexPath.row]
            cell.titlelbl.text = dict.label
            cell.subTitlelbl.text = dict.value
            cell.id = dict.id ?? ""
            cell.cityShortNamelbl.text = dict.code
            cell.value = dict.value ?? ""
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

                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.toCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.tolocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.toairport)

                            }
                        }else if journeyType == "circle"{
                            if titleStr == "From" {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rfromlocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.rfromairport)
                                
                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rtolocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.rtoairport)

                            }
                        }else {
                            
                            if titleStr == "From" {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mfromlocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.mfromairportCode)
                                defaults.set(cell.value , forKey: UserDefaultsKeys.mfromCityValue)

                                fromCityNameArray[self.celltag] = cell.titlelbl.text ?? ""
                                fromCityShortNameArray[self.celltag] = cell.cityShortNamelbl.text ?? ""
                                
                
                                fromCityArray[self.celltag] = cell.value
                                fromlocidArray[self.celltag] = cell.id
                                
                             
                               
                            
                                
                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mtolocid)
                                defaults.set(cell.cityShortNamelbl.text , forKey: UserDefaultsKeys.mtoairportCode)
                                defaults.set(cell.value , forKey: UserDefaultsKeys.mtoCityValue)

                                toCityNameArray[self.celltag] = cell.titlelbl.text ?? ""
                                toCityShortNameArray[self.celltag] = cell.cityShortNamelbl.text ?? ""
                                
                                toCityArray[self.celltag] = cell.value
                                tolocidArray[self.celltag] = cell.id
                                
                                
                               

                            }
                            
                        }
                    }
                    
                    
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    self.gotoSearchFlightsVC()
                }else {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.locationcity)
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    self.gotoSearchHotelsVC()
                }
            }
        }
        
        
    }
}
