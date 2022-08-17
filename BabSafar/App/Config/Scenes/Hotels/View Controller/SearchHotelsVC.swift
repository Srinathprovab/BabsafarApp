//
//  SearchHotelsVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class SearchHotelsVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    var tablerow = [TableRow]()
    static var newInstance: SearchHotelsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchHotelsVC
        return vc
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Search Hotels"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["ButtonTVCell","CommonFromCityTVCell","EmptyTVCell"])
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.layer.borderWidth = 1
        commonTableView.layer.borderColor = UIColor.AppBorderColor.cgColor
        setuptv()
        
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: Notification.Name("reload"), object: nil)

    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        commonTableView.reloadData()
    }
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Location/City",subTitle: defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "Add City",key:"dual1", image: "",cellType:.CommonFromCityTVCell))
        
        tablerow.append(TableRow(title:"Check-In",subTitle: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Add Check In Date",key:"dual", text:"Check-On", tempText: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Add Check Out Date",cellType:.CommonFromCityTVCell))
        
        tablerow.append(TableRow(title:"Rooms & Guests",subTitle: "\(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "Add") Adultas ",key:"dual1", image: "downarrow",cellType:.CommonFromCityTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Search Hotels",cellType:.ButtonTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.selectedIndex = 0
        self.present(vc, animated: false)
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
        print("btnAction")
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
