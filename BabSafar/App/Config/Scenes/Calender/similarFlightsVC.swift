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
    var similarflightListCircle = [[RTJ_flight_list]]()
    var similarflightListMulticity = [MCJ_flight_list]()
    var tablerow = [TableRow]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //  tvheight.constant = CGFloat(similarflightList.count * 200)
        commonTableView.registerTVCells(["SearchFlightResultTVCell",
                                         "RoundTripFlightResultTVCell",
                                         "MultiCityTripFlightResultTVCell"])
        
        //MARK: - Journey Type Check
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            setupTVCells()
        }else if journyType == "circle" {
            setupRoundTripTVCell()
        }else {
            setupMulticityTVCell()
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
        
        similarflightList.forEach({ i in
            i.forEach { j in
                j.flight_details?.summary?.forEach({ k in
                    tablerow.append(TableRow(
                        title:"\(k.operator_name ?? "") (\(k.operator_code ?? "") \(k.flight_number ?? ""))",
                        subTitle: "\(j.price?.api_total_display_fare?.rounded() ?? 0.0)" ,
                        price: j.aPICurrencyType,
                        Weight_Allowance: k.weight_Allowance,
                        key:"oneway",
                        text: k.origin?.time,
                        headerText: k.destination?.time,
                        buttonTitle: "\(k.destination?.city ?? "") (\(k.destination?.loc ?? ""))",
                        errormsg: "\(j.price?.api_total_display_fare_withoutmarkup?.rounded() ?? 0.0)",
                        key1:j.fareType,
                        image: k.operator_image,
                        tempText:"\(k.origin?.city ?? "") (\(k.origin?.loc ?? ""))",
                        questionType:(k.duration),
                        TotalQuestions: j.selectedResult,
                        cellType:.SearchFlightResultTVCell,
                        shareLink: "similar",
                        questionBase: "\(String(k.no_of_stops ?? 0))"
                        
                    ))
                    
                })
            }
        })
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupRoundTripTVCell() {
        flightsFoundlbl.text = "\(similarflightListCircle.count ) Flights Found"
        
        tablerow.removeAll()
        
        similarflightListCircle.forEach({ i in
            
            i.forEach { k in
                tablerow.append(TableRow(title:"\(k.price?.api_total_display_fare?.rounded() ?? 0.0)",
                                         price:k.aPICurrencyType,
                                         key: "circle",
                                         headerText:"\(k.price?.api_total_display_fare_withoutmarkup?.rounded() ?? 0.0)",
                                         errormsg:String(k.flight_details?.summary?.first?.no_of_stops ?? 0),
                                         key1:k.fareType ?? "",
                                         moreData:k.flight_details,
                                         questionType:k.aPICurrencyType,
                                         TotalQuestions: k.selectedResult,
                                         cellType:.RoundTripFlightResultTVCell,
                                         shareLink: "similar",
                                         questionBase: k.taxes))
            }
        })
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    func setupMulticityTVCell() {
        flightsFoundlbl.text = "\(similarflightListMulticity.count ) Flights Found"
        tablerow.removeAll()
        
        
        similarflightListMulticity.forEach { k in
            tablerow.append(TableRow(title:"\(k.price?.api_total_display_fare?.rounded() ?? 0.0)",
                                     price:k.aPICurrencyType,
                                     headerText:"\(k.price?.api_total_display_fare?.rounded() ?? 0.0)",
                                     key1:k.fareType ?? "",
                                     moreData:k.flight_details,
                                     TotalQuestions: k.selectedResult,
                                     cellType:.MultiCityTripFlightResultTVCell,
                                     shareLink: "similar",
                                     questionBase: k.taxes))
            
            
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    // MARK: - Oneway SearchFlightResultTVCell
    
    override func didTapOnFlightDetailsBtnAction(cell:SearchFlightResultTVCell){
        flightSelectedIndex = Int(cell.indexPath?.row ?? 0 )
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        gotoBaggageInfoVC()
    }
    
    
    override func didTapOnBookNowBtn(cell:SearchFlightResultTVCell){
        flightSelectedIndex = Int(cell.indexPath?.row ?? 0 )
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        totalprice = cell.kwdPricelbl.text ?? ""
        gotoBookingDetailsVC()
    }
    
    
    
    // MARK: - RoundTripFlightResultTVCell
    override func didTapOnFlightDetailsBtn(cell:RoundTripFlightResultTVCell){
        flightSelectedIndex = Int(cell.indexPath?.row ?? 0 )
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        gotoBaggageInfoVC()
    }
    
    
    override func didTapOnBookNowBtn(cell:RoundTripFlightResultTVCell){
        flightSelectedIndex = Int(cell.indexPath?.row ?? 0 )
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        totalprice = cell.totalPrice
        gotoBookingDetailsVC()
    }
    
    
    
    // MARK: - MultiCityTripFlightResultTVCell
    override func didTapOnFlightDetailsBtnAction(cell:MultiCityTripFlightResultTVCell){
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        defaults.set(cell.indexPath?.row ?? 0, forKey: UserDefaultsKeys.selectdFlightcellIndex)
        gotoBaggageInfoVC()
    }
    
    
    override func didTapOnBookNowBtnAction(cell:MultiCityTripFlightResultTVCell){
        flightSelectedIndex = Int(cell.indexPath?.row ?? 0 )
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        totalprice = cell.totalPrice
        gotoBookingDetailsVC()
    }
    
    
    
    // MARK: - gotoBaggageInfoVC
    func gotoBaggageInfoVC() {
        guard let vc = BaggageInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        fdbool = false
        present(vc, animated: true)
    }
    
    
    // MARK: - gotoBookingDetailsVC
    func gotoBookingDetailsVC() {
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.totalPrice1 = totalprice
        callapibool = true
        fdbool = true
        present(vc, animated: true)
    }
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
    
}
