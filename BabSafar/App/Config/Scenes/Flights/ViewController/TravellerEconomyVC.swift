//
//  TravellerEconomyVC.swift
//  AirportProject
//
//  Created by Codebele 09 on 26/06/22.
//

import UIKit
import CoreData

class TravellerEconomyVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var selectClassArray = [String]()
    var tableRow = [TableRow]()
    
    var keyString = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var roomCountArray = [Int]()
    var count = 1
    static var newInstance: TravellerEconomyVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TravellerEconomyVC
        return vc
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        callapibool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvHeight.constant = 410
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        setupinitialUI()
        
    }
    
    
    func setupinitialUI() {
        
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
                
            }else if selectedTab == "Insurence" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
                    if journeyType == "oneway" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.iadultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.ichildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.iinfantsCount) ?? "0") ?? 0
                        
                    }else {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.iradultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.irchildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.irinfantsCount) ?? "0") ?? 0
                    }
                }
                
            }else if selectedTab == "Fasttrack" {
                
                tvHeight.constant = 350
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.iradultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.irchildCount) ?? "0") ?? 0
                
            }else if selectedTab == "Visa" {
                adultsCount = 1
                childCount = 0
                infantsCount = 0
            }else {
                
                tvHeight.constant = 350
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1") ?? 1
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.hchildCount) ?? "0") ?? 0
                
            }
        }
        
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
            switch tabselect {
                
            case "Flights","Visa","Insurence","Fasttrack":
                DispatchQueue.main.async {[self] in
                    setupSearchFlightEconomyTVCells()
                }
                break
                
            case "Hotels":
                DispatchQueue.main.async {[self] in
                    roomCountArray.append(count)
                    setupSearchHotelsEconomyTVCells()
                }
                break
                
                
                
                
            default:
                break
            }
            
        }
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        setupinitialUI()
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
        commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["RadioButtonTVCell",
                                         "TravellerEconomyTVCell",
                                         "LabelTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "CommonTVCell"])
        
        
    }
    
    func setupSearchFlightEconomyTVCells(){
        
        tableRow.removeAll()
        
        if keyString == "traveller" {
            
            tableRow.append(TableRow(title:"Add Travellers ",key: "showbtn",cellType:.LabelTVCell))

            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    
                    
                    tableRow.append(TableRow(title:"Adults",subTitle: "(12+)",text: defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Child",subTitle: "(2-11)",text: defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Infant",subTitle: "(0-2)",text: defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
                    
                    
                }else if journeyType == "circle"{
                    tableRow.append(TableRow(title:"Adults",subTitle: "(12+)",text: defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Child",subTitle: "(2-11)",text: defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Infant",subTitle: "(0-2)",text: defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
                }else {
                    
                    tableRow.append(TableRow(title:"Adults",subTitle: "(12+)",text: defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Child",subTitle: "(2-11)",text: defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Infant",subTitle: "(0-2)",text: defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
                }
            }
            
            
            
        }else if keyString == "visa"{
            
            tableRow.append(TableRow(title:"Add Travellers ",key: "showbtn",cellType:.LabelTVCell))

            tableRow.append(TableRow(title:"Adults",subTitle: "(12+)",text: defaults.string(forKey: UserDefaultsKeys.visaadultCount) ?? "1",cellType:.TravellerEconomyTVCell))
            tableRow.append(TableRow(title:"Child",subTitle: "(2-11)",text: defaults.string(forKey: UserDefaultsKeys.visachildCount) ?? "0",cellType:.TravellerEconomyTVCell))
            tableRow.append(TableRow(title:"Infant",subTitle: "(0-2)",text: defaults.string(forKey: UserDefaultsKeys.visainfantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
            
        }else if keyString == "insurence"{
            
            tableRow.append(TableRow(title:"Add Travellers ",key: "showbtn",cellType:.LabelTVCell))

            if let journeyType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
                if journeyType == "oneway" {
                    tableRow.append(TableRow(title:"Adults",subTitle: "(12+)",text: defaults.string(forKey: UserDefaultsKeys.iadultCount) ?? "1",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Child",subTitle: "(2-11)",text: defaults.string(forKey: UserDefaultsKeys.ichildCount) ?? "0",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Infant",subTitle: "(0-2)",text: defaults.string(forKey: UserDefaultsKeys.iinfantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
                    
                    
                }else{
                    tableRow.append(TableRow(title:"Adults",subTitle: "(12+)",text: defaults.string(forKey: UserDefaultsKeys.iradultCount) ?? "1",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Child",subTitle: "(2-11)",text: defaults.string(forKey: UserDefaultsKeys.irchildCount) ?? "0",cellType:.TravellerEconomyTVCell))
                    tableRow.append(TableRow(title:"Infant",subTitle: "(0-2)",text: defaults.string(forKey: UserDefaultsKeys.irinfantsCount) ?? "0",cellType:.TravellerEconomyTVCell))
                }
            }
            
            
            
            
        }else if keyString == "fasttrack"{
            
            
            tableRow.append(TableRow(title:"Add Travellers ",key: "showbtn",cellType:.LabelTVCell))

            tableRow.append(TableRow(title:"Adults",subTitle: "(12+)",text: defaults.string(forKey: UserDefaultsKeys.fradultCount) ?? "1",cellType:.TravellerEconomyTVCell))
            tableRow.append(TableRow(title:"Child",subTitle: "(2-11)",text: defaults.string(forKey: UserDefaultsKeys.frchildCount) ?? "0",cellType:.TravellerEconomyTVCell))
            
            
        }else {
            
            tableRow.append(TableRow(height:10,cellType:.EmptyTVCell))
            tableRow.append(TableRow(title:"Select Class",key: "showbtn",cellType:.LabelTVCell))
            tableRow.append(TableRow(cellType:.CommonTVCell))
            
        }
        
        
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
            tableRow.append(TableRow(title:"Adults",subTitle: "(12+)",text: "\(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
            tableRow.append(TableRow(title:"Child",subTitle: "(2-11)",text: "\(defaults.string(forKey: UserDefaultsKeys.hchildCount) ?? "0")",cellType:.TravellerEconomyTVCell))
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
        if cell.titlelbl.text == "Infant" {
            // Increment the infant count if it's less than the number of adults
            if infantsCount < adultsCount {
                infantsCount += 1
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
            
            
        } else if cell.titlelbl.text == "Adults" {
            // Increment adults, but don't exceed 9 travelers in total
            if (adultsCount + childCount) < 9 {
                adultsCount += 1
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else {
            if (adultsCount + childCount) < 9 {
                // Increment children, but don't exceed 9 travelers in total
                if cell.count >= 0 {
                    cell.count += 1
                    cell.countlbl.text = "\(cell.count)"
                }
                if cell.titlelbl.text == "Child" {
                    childCount = cell.count
                }
            }
        }
        
        updateTotalTravelerCount()
    }

    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" {
            // Decrement the infant count if it's greater than 0
            if infantsCount > 0 {
                infantsCount -= 1
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else if cell.titlelbl.text == "Adults" {
            // Decrement adults, but don't go below 1
            if adultsCount > 1 {
                adultsCount -= 1
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }

        } else {
            // Decrement children
            if cell.count > 0 {
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }
            if cell.titlelbl.text == "Child" {
                childCount = cell.count
            }
        }

        updateTotalTravelerCount()
    }
    
    


    func updateTotalTravelerCount() {
        let totalTravelers = adultsCount + childCount + infantsCount
        print("Total Count === \(totalTravelers)")
        defaults.set(totalTravelers, forKey: UserDefaultsKeys.totalTravellerCount)
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
                
                
                if adultsCount > 1 {
                    let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") Infant | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
                    defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
                }else {
                    let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "") Adult | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") Infant | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
                    defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
                   
                }
                
                
                
            }else if journeyType == "circle" {
                
                if adultsCount > 1 {
                    let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "") Infant |\(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
                    defaults.set(totaltraverlers, forKey: UserDefaultsKeys.rtravellerDetails)
                }else {
                    let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "") Adult | \(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "") Infant |\(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
                    defaults.set(totaltraverlers, forKey: UserDefaultsKeys.rtravellerDetails)
                   
                }
                
               
            }else{
                
                if adultsCount > 1 {
                    let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "") Infants | \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "")"
                    defaults.set(totaltraverlers, forKey: UserDefaultsKeys.mtravellerDetails)
                }else {
                    
                    let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "") Adult | \(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "") Infant | \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "")"
                    defaults.set(totaltraverlers, forKey: UserDefaultsKeys.mtravellerDetails)
                }
                
              
            }
        }
        
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
        dismiss(animated: false)
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
                    
                }else if selectedTab == "Insurence" {
                    
                    if let journeyType = defaults.string(forKey: UserDefaultsKeys.InsurenceJourneyType) {
                        if journeyType == "oneway" {
                            
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.iadultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.ichildCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.iinfantsCount)
                            
                            
                            if adultsCount > 1 {
                                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.iadultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.ichildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.iinfantsCount) ?? "") Infant"
                                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.itravellerDetails)
                            }else {
                                
                                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.iadultCount) ?? "") Adult | \(defaults.string(forKey: UserDefaultsKeys.ichildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.iinfantsCount) ?? "") Infant "
                                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.itravellerDetails)
                            }
                            
                            
                            
                            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                            dismiss(animated: false)
                            
                            
                        }else if journeyType == "circle" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.iradultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.irchildCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.irinfantsCount)
                            
                            
                            if adultsCount > 1 {
                                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.iradultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.irchildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.irinfantsCount) ?? "") Infant "
                                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.irtravellerDetails)
                            }else {
                                
                                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.iradultCount) ?? "") Adult | \(defaults.string(forKey: UserDefaultsKeys.irchildCount) ?? "") child | \(defaults.string(forKey: UserDefaultsKeys.irinfantsCount) ?? "") Infants "
                                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.irtravellerDetails)
                            }
                            
                            
                            
                            
                            
                            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                            dismiss(animated: false)
                            
                        }
                    }
                    
                    
                    
                }else if selectedTab == "Fasttrack" {
                    
                    defaults.set(adultsCount, forKey: UserDefaultsKeys.fradultCount)
                    defaults.set(childCount, forKey: UserDefaultsKeys.frchildCount)
                    
                    if adultsCount > 1 {
                        let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.fradultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.frchildCount) ?? "") Child"
                        defaults.set(totaltraverlers, forKey: UserDefaultsKeys.frtravellerDetails)
                    }else {
                        let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.fradultCount) ?? "") Adult | \(defaults.string(forKey: UserDefaultsKeys.frchildCount) ?? "") Child"
                        defaults.set(totaltraverlers, forKey: UserDefaultsKeys.frtravellerDetails)
                    }
                    
                    
                    
                    NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                    dismiss(animated: false)
                    
                    
                }else if selectedTab == "Visa" {
                    defaults.set(adultsCount, forKey: UserDefaultsKeys.visaadultCount)
                    defaults.set(childCount, forKey: UserDefaultsKeys.visachildCount)
                    defaults.set(infantsCount, forKey: UserDefaultsKeys.visainfantsCount)
                    
                    
                    let totaltraverlers = "\(adultsCount + childCount + infantsCount) Passengers"
                    defaults.set(totaltraverlers, forKey: UserDefaultsKeys.visatravellerDetails)
                    
                    NotificationCenter.default.post(name: Notification.Name("reloadvisavc"), object: nil)
                    dismiss(animated: false)
                    
                }else {
                    defaults.set(adultsCount, forKey: UserDefaultsKeys.hadultCount)
                    defaults.set(childCount, forKey: UserDefaultsKeys.hchildCount)
                    
                }
                
                
            }
        }else {
            
            count += 1
            roomCountArray.append(count)
            //  setupSearchHotelsEconomyTVCells()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LabelTVCell {
            cell.menuOptionImage.image = UIImage(named: "radioSelected")
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
