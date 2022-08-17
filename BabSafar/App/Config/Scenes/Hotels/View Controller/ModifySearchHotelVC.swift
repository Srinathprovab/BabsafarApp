//
//  ModifySearchHotelVC.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

class ModifySearchHotelVC: BaseTableVC {
    
    
    
    var tablerow = [TableRow]()
    static var newInstance: ModifySearchHotelVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchHotelVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
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
        tablerow.append(TableRow(title:"Location/City",subTitle: "Dubai ",key:"dual1", image: "",cellType:.CommonFromCityTVCell))
        tablerow.append(TableRow(title:"Check-In",subTitle: "26-07-2022",key:"dual", text:"Check-On", tempText: "28-07-2022",cellType:.CommonFromCityTVCell))
        tablerow.append(TableRow(title:"Rooms & Guests",subTitle: "1 Adults ",key:"dual1", image: "downarrow",cellType:.CommonFromCityTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Search Hotels",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))

        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    override func didTapOnCloseBtn(cell: LabelTVCell) {
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
        print("btnAction")
        guard let vc = SearchHotelsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
}



