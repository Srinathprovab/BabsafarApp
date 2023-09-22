//
//  similarFlightsVC.swift
//  BabSafar
//
//  Created by FCI on 18/07/23.
//

import UIKit

class similarFlightsVC: BaseTableVC {
    
    
    
    @IBOutlet weak var flightsFoundlbl: UILabel!
    static var newInstance: similarFlightsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Calender.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? similarFlightsVC
        return vc
    }
    var similarflightList = [[J_flight_list]]()
    var similarflightListMulticity = [[MCJ_flight_list]]()
    var tablerow = [TableRow]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //  tvheight.constant = CGFloat(similarflightList.count * 200)
        commonTableView.registerTVCells(["NewFlightSearchResultTVCell"])
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "multicity" {
                setupMulticityTVCells()
            }else {
                setupTVCells()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // self.view.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    
    
    func setupTVCells() {
        flightsFoundlbl.text = "\(similarflightList.count ) Flights Found"
        tablerow.removeAll()
        
        
        var updatedUniqueList: [[J_flight_list]] = []
        updatedUniqueList = getUniqueElements_oneway(inputArray: similarflightList)
        
        similarflightList.forEach({ i in
            i.forEach { j in
                
                tablerow.append(TableRow(title:"\(j.price?.api_total_display_fare_withoutmarkup ?? 0.0)",
                                         subTitle: j.fareType ?? "",
                                         price: "\(j.price?.api_total_display_fare ?? 0.0)",
                                         key: "similar",
                                         text: j.selectedResult ?? "",
                                         buttonTitle: j.aPICurrencyType ?? "",
                                         moreData: j.flight_details?.summary ?? [],
                                         cellType:.NewFlightSearchResultTVCell))
                
                
            }
        })
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    func setupMulticityTVCells() {
        flightsFoundlbl.text = "\(similarflightListMulticity.count ) Flights Found"
        tablerow.removeAll()
        
    
        similarflightListMulticity.forEach({ i in
            i.forEach { j in
                
                tablerow.append(TableRow(title:"\(j.price?.api_total_display_fare_withoutmarkup ?? 0.0)",
                                         subTitle: j.fareType ?? "",
                                         price: "\(j.price?.api_total_display_fare ?? 0.0)",
                                         key: "similar",
                                         text: j.selectedResult ?? "",
                                         buttonTitle: j.aPICurrencyType ?? "",
                                         moreData: j.flight_details?.summary ?? [],
                                         cellType:.NewFlightSearchResultTVCell))
                
                
            }
        })
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    
    //MARK: - didTapOnFlightDetailsBtnAction NewFlightSearchResultTVCell
    override func didTapOnFlightDetailsBtnAction(cell: NewFlightSearchResultTVCell) {
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        gotoBaggageInfoVC()
    }
    
    func gotoBaggageInfoVC() {
        guard let vc = BaggageInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        fdbool = false
        present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnBookNowBtnAction NewFlightSearchResultTVCell
    override func didTapOnBookNowBtnAction(cell: NewFlightSearchResultTVCell) {
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        totalprice = cell.pricelbl.text ?? ""
        gotoBookingDetailsVC()
    }
    
    func gotoBookingDetailsVC() {
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.totalPrice1 = totalprice
        callapibool = true
        fdbool = true
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnAddReturnFlightBtnAction NewFlightSearchResultTVCell
    override func didTapOnAddReturnFlightBtnAction(cell: NewFlightSearchResultTVCell) {
        gotoModifySearchFlightVC(key: "addreturn")
    }
    
    func gotoModifySearchFlightVC(key:String) {
        guard let vc = ModifySearchFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = key
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnCloseBtnAction
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    
}


extension similarFlightsVC {
    
    
    //MARK: - Function to get unique elements based on totalPrice oneway
    func getUniqueElements_oneway(inputArray: [[J_flight_list]]) -> [[J_flight_list]] {
        var uniqueElements: [[J_flight_list]] = []
        var uniquePrices: Set<String> = []
        
        for array in inputArray {
            var uniqueArray: [J_flight_list] = []
            for item in array {
                if !uniquePrices.contains("\(item.flight_details?.summary?.first?.flight_number ?? "")") {
                    uniquePrices.insert("\(item.flight_details?.summary?.first?.flight_number ?? "")")
                    uniqueArray.append(item)
                }
            }
            if !uniqueArray.isEmpty {
                uniqueElements.append(uniqueArray)
            }
        }
        
        return uniqueElements
    }
}
