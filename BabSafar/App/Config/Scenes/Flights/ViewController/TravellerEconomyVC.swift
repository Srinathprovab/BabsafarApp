//
//  TravellerEconomyVC.swift
//  AirportProject
//
//  Created by Codebele 09 on 26/06/22.
//

import UIKit

class TravellerEconomyVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    
    
    var selectClassArray = [String]()
    var tableRow = [TableRow]()
    var count = 1
    var keyString = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var roomCountArray = [Int]()
    static var newInstance: TravellerEconomyVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TravellerEconomyVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
            
            if selectedTab == "Flights" {
                
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                        
                        
                    }else if journeyType == "circle"{
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
                    }else {
                        
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
                    }
                }
                
            }else {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1") ?? 1
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.hchildCount) ?? "0") ?? 0
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        holderView.backgroundColor = .black.withAlphaComponent(0.3)
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["RadioButtonTVCell","TravellerEconomyTVCell","LabelTVCell","EmptyTVCell","ButtonTVCell","CommonTVCell"])
        
        if keyString == "hotels" {
            roomCountArray.append(count)
            setupSearchHotelsEconomyTVCells()
        }else {
            setupSearchFlightEconomyTVCells()
        }
    }
    
    func setupSearchFlightEconomyTVCells(){
        
        tableRow.removeAll()
        
        tableRow.append(TableRow(title:"Add Travellers ",key: "showbtn",cellType:.LabelTVCell))
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                tableRow.append(TableRow(title:"Adults",subTitle: "From 12 yeras old",text: defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Children",subTitle: "2 - 11",text: defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infants",subTitle: "From 12 yeras old",text: defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
                
                
            }else if journeyType == "circle"{
                tableRow.append(TableRow(title:"Adults",subTitle: "From 12 yeras old",text: defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Children",subTitle: "2 - 11",text: defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infants",subTitle: "From 12 yeras old",text: defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
            }else {
                
                tableRow.append(TableRow(title:"Adults",subTitle: "From 12 yeras old",text: defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Children",subTitle: "2 - 11",text: defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infants",subTitle: "From 12 yeras old",text: defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
            }
        }
        
        
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Select Class",cellType:.LabelTVCell))
        tableRow.append(TableRow(cellType:.CommonTVCell))
        tableRow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    
    func setupSearchHotelsEconomyTVCells(){
        
        print("adultsCount ==== > \(Int(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1") ?? 1)")
        tableRow.removeAll()
        
        tableRow.append(TableRow(title:"Add  Rooms & Guests  ",key: "showbtn",cellType:.LabelTVCell))
        
        roomCountArray.forEach { i in
            tableRow.append(TableRow(title:"Room \(i)",cellType:.LabelTVCell))
            tableRow.append(TableRow(title:"Adults",subTitle: "From 12 yeras old",text: "\(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
            tableRow.append(TableRow(title:"Children",subTitle: "2 - 11",text: "\(defaults.string(forKey: UserDefaultsKeys.hchildCount) ?? "0")",cellType:.TravellerEconomyTVCell))
        }
        
        
        tableRow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"+ Add Room",key:"addroom",cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    override func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {
        
        
        
        if (infantsCount) > 8 {
            showToast(message: "Infants Count not mor than 9 ")
            showAlertOnWindow(title: "", message: "Infants Count not mor than 9", titles: ["OK"], completionHanlder: nil)
        }else if (adultsCount + childCount) > 8 {
            showToast(message: "adultsCount not mor than 9 ")
            showAlertOnWindow(title: "", message: "Adults Count Not More Than 9", titles: ["OK"], completionHanlder: nil)
        }else  {
            if cell.count >= 0 {
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
            
            if cell.titlelbl.text == "Adults" {
                adultsCount = cell.count
            }else if cell.titlelbl.text == "Children"{
                childCount = cell.count
            }else {
                infantsCount = cell.count
            }
        }
        
        print("Total Count === \(adultsCount + childCount + infantsCount)")
        defaults.set((adultsCount + childCount + infantsCount), forKey: UserDefaultsKeys.totalTravellerCount)
        
    }
    
    
    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        
        if cell.count > 0 {
            cell.count -= 1
            // cell.countlbl.text = "\(cell.count)"
        }
        print(cell.count)
        
        if cell.titlelbl.text == "Adults" {
            adultsCount = cell.count
            //   deleteRecords(title: "Adult", index: cell.count)
        }else if cell.titlelbl.text == "Children"{
            childCount = cell.count
            // deleteRecords(title: "Children", index: cell.count)
        }else {
            infantsCount = cell.count
            //   deleteRecords(title: "Infantas", index: cell.count)
        }
        
        
        if (adultsCount + childCount) > 8 {
            showToast(message: "adultsCount not mor than 9 ")
            showAlertOnWindow(title: "", message: "Adults Count Not More Than 9", titles: ["OK"], completionHanlder: nil)
        }else {
            cell.countlbl.text = "\(cell.count)"
            
        }
        
        
        print("Total Count === \(adultsCount + childCount + infantsCount)")
        defaults.set((adultsCount + childCount + infantsCount), forKey: UserDefaultsKeys.totalTravellerCount)
        
    }
    
    
    override func didTapOnCloseBtn(cell: LabelTVCell) {
        self.dismiss(animated: true)
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
    
    
    
    
    func gotoBookFlightVC() {
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "") Children | \(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") Infants | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            }else if journeyType == "circle" {
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "") Children | \(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "") Infants |\(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.rtravellerDetails)
            }else{
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "") Children | \(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "") Infants | \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "")"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.mtravellerDetails)
            }
        }
        
        
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        print("button tap ...")
        print("adultsCount \(adultsCount)")
        print("childCount \(childCount)")
        print("infantsCount \(infantsCount)")
        
        
        if cell.titlelbl.text == "Done" {
            if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
                
                
                if selectedTab == "Flights" {
                    
                    if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
                            if selectedTab == "Flights" {
                                
                                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                                    if journeyType == "oneway" {
                                        defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                                        defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                                        defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                                        
                                    }else if journeyType == "circle" {
                                        defaults.set(adultsCount, forKey: UserDefaultsKeys.radultCount)
                                        defaults.set(childCount, forKey: UserDefaultsKeys.rchildCount)
                                        defaults.set(infantsCount, forKey: UserDefaultsKeys.rinfantsCount)
                                    }else {
                                        defaults.set(adultsCount, forKey: UserDefaultsKeys.madultCount)
                                        defaults.set(childCount, forKey: UserDefaultsKeys.mchildCount)
                                        defaults.set(infantsCount, forKey: UserDefaultsKeys.minfantsCount)
                                    }
                                }
                                
                                gotoBookFlightVC()
                                
                            }else {
                                defaults.set(adultsCount, forKey: UserDefaultsKeys.hadultCount)
                                defaults.set(childCount, forKey: UserDefaultsKeys.hchildCount)
                                
                                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                                dismiss(animated: false)
                            }
                        }
                    }
                    
                    
                    
                    
                }else {
                    defaults.set(adultsCount, forKey: UserDefaultsKeys.hadultCount)
                    defaults.set(childCount, forKey: UserDefaultsKeys.hchildCount)
                    
                    NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                    dismiss(animated: false)
                }
            }
        }else {
            print("Add Room ......")
            count += 1
            roomCountArray.append(count)
            //  setupSearchHotelsEconomyTVCells()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LabelTVCell {
            cell.menuOptionImage.image = UIImage(named: "radioSelected")
            print(cell.titlelbl.text)
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.selectClass)
                }else if journeyType == "circle"{
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rselectClass)
                }else {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mselectClass)
                }
            }

        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LabelTVCell {
            cell.menuOptionImage.image = UIImage(named: "radioUnselected")
        }
    }
    
    
}


extension TravellerEconomyVC {
    
    
   
}
