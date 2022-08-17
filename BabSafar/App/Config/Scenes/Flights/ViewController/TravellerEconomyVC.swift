//
//  TravellerEconomyVC.swift
//  AirportProject
//
//  Created by Codebele 09 on 26/06/22.
//

import UIKit

class TravellerEconomyVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    
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
            if selectedTab == "flights" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "0") ?? 0
                
                
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
        commonTableView.registerTVCells(["RadioButtonTVCell","TravellerEconomyTVCell","LabelTVCell","EmptyTVCell","ButtonTVCell"])
        
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
        tableRow.append(TableRow(title:"Adults",subTitle: "From 12 yeras old",text: "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(title:"Children",subTitle: "2 - 11",text: "\(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0")",cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(title:"Infants",subTitle: "From 12 yeras old",text: "\(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Select Class",cellType:.LabelTVCell))
        tableRow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Economy",cellType:.RadioButtonTVCell))
        tableRow.append(TableRow(title:"Premium Economy",cellType:.RadioButtonTVCell))
        tableRow.append(TableRow(title:"First",cellType:.RadioButtonTVCell))
        tableRow.append(TableRow(title:"Business",cellType:.RadioButtonTVCell))
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
        
        
        if (adultsCount + childCount) > 8 ||  (adultsCount + childCount + infantsCount) > 8{
            showToast(message: "adultsCount not mor than 9 ")
            showAlertOnWindow(title: "", message: "Adults Count Not More Than 9", titles: ["OK"], completionHanlder: nil)
        }else {
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
            
            print("adultsCount :\(adultsCount)")
        }
        
    }
    
    
    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        
        if cell.count > 0 {
            cell.count -= 1
            // cell.countlbl.text = "\(cell.count)"
        }
        print(cell.count)
        
        if cell.titlelbl.text == "Adults" {
            adultsCount = cell.count
        }else if cell.titlelbl.text == "Children"{
            childCount = cell.count
        }else {
            infantsCount = cell.count
        }
        
        
        if (adultsCount + childCount) > 8 || (adultsCount + childCount + infantsCount) > 8{
            showToast(message: "adultsCount not mor than 9 ")
            showAlertOnWindow(title: "", message: "Adults Count Not More Than 9", titles: ["OK"], completionHanlder: nil)
        }else {
            cell.countlbl.text = "\(cell.count)"
            print("adultsCount :\(adultsCount)")
        }
    }
    
    
    override func didTapOnCloseBtn(cell: LabelTVCell) {
        self.dismiss(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.radioImg.image = UIImage(named: "radioSelected")
            defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.selectClass)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.radioImg.image = UIImage(named: "radioUnselected")
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
    
    
    override func btnAction(cell: ButtonTVCell) {
        print("button tap ...")
        print("adultsCount \(adultsCount)")
        print("childCount \(childCount)")
        print("infantsCount \(infantsCount)")
        if cell.titlelbl.text == "Done" {
            if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
                if selectedTab == "flights" {
                    defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                    defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                    defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                    
                    gotoSearchFlightsVC()
                }else {
                    defaults.set(adultsCount, forKey: UserDefaultsKeys.hadultCount)
                    defaults.set(childCount, forKey: UserDefaultsKeys.hchildCount)
                    
                    gotoSearchHotelsVC()
                }
            }
        }else {
            print("Add Room ......")
            count += 1
            roomCountArray.append(count)
            setupSearchHotelsEconomyTVCells()
        }
        
        
        
    }
}


