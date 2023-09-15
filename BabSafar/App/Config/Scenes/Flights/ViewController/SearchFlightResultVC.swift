//
//  SearchFlightResultVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
import FreshchatSDK


class SearchFlightResultVC: BaseTableVC, UITextFieldDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var navView: NavBar!
    @IBOutlet weak var cvHolderView: UIView!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortimg: UIImageView!
    @IBOutlet weak var sortlbl: UILabel!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var filterBtnView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterlbl: UILabel!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var leftTapHolderView: UIView!
    @IBOutlet weak var leftTapView: UIView!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var leftTapBtn: UIButton!
    @IBOutlet weak var rightTapView: UIView!
    @IBOutlet weak var rightTapImg: UIImageView!
    @IBOutlet weak var rightTapBtn: UIButton!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var cityCodelbl: UILabel!
    @IBOutlet weak var dropupimg: UIImageView!
    @IBOutlet weak var moveUpBtn: UIButton!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var chatBtnView: UIView!
    @IBOutlet weak var returnDatalbl: UILabel!
    
    
    var lastContentOffset: CGFloat = 0
    static var newInstance: SearchFlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightResultVC
        return vc
    }
    
    
    
    var isfromVc = String()
    var tablerow = [TableRow]()
    var kwdPriceArray = [String]()
    var dateArray = [String]()
    let refreshControl = UIRefreshControl()
    var filterdFlightList :[[J_flight_list]]?
    var filterdRTJ_flight_list :[[RTJ_flight_list]]?
    var filterdMCJ_flight_list :[[MCJ_flight_list]]?
    var isFromVc = String()
    var directFlightBool = true
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var viewModel : FlightListViewModel?
    var totalprice = String()
    
    override func viewWillAppear(_ animated: Bool) {
        BASE_URL = BASE_URL1
        addObserver()
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .WhiteColor
       
        setupUI()
        viewModel = FlightListViewModel(self)
    }
    
    
    
    func setupUI() {
        chatBtnView.isHidden = true
        holderView.backgroundColor = .WhiteColor
        hiddenView.isHidden = true
        hiddenView.backgroundColor = .AppBtnColor
        hiddenView.addCornerRadiusWithShadow(color: .lightGray, borderColor: .clear, cornerRadius: 4)
        dropupimg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        leftTapHolderView.backgroundColor = .WhiteColor
        cvHolderView.backgroundColor = .WhiteColor
        
        self.commonTableView.registerTVCells(["SearchFlightResultTVCell",
                                              "EmptyTVCell",
                                              "RoundTripFlightResultTVCell",
                                              "FlightDetailsTVCell",
                                              "NewFlightSearchResultTVCell",
                                              "MultiCityTripFlightResultTVCell"])
        
        setupRefreshControl()
        
        navView.isHidden = true
        cvHolderView.isHidden = true
    }
    
    //MARK: - setupRefreshControl
    func setupRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        commonTableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        setupTV()
        commonTableView.reloadData()
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.refreshControl.endRefreshing()
        }
    }
    
    
    //MARK: - setUpNav
    func setUpNav(){
        navView.isHidden = false
        cvHolderView.isHidden = false
        navView.titlelbl.text = ""
        
        
        if screenHeight > 835 {
            navHeight.constant = 170
        }else {
            navHeight.constant = 140
        }
        
        
        navView.editBtnView.isHidden = true
        navView.filterBtnView.isHidden = false
        navView.filterImg.image = UIImage(named: "edit1")?.withRenderingMode(.alwaysOriginal)
        navView.lbl1.isHidden = false
        navView.lbl2.isHidden = false
        navView.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        navView.filterBtn.addTarget(self, action: #selector(didTapOnEditBtn(_:)), for: .touchUpInside)
        navView.editBtn.addTarget(self, action: #selector(didTapOnEditBtn(_:)), for: .touchUpInside)
        
        sortimg.image = UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        sortBtn.setTitle("", for: .normal)
        setuplabels(lbl: sortlbl, text: "SORT", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .left)
        
        filterImg.image = UIImage(named: "filter1")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        filterBtn.setTitle("", for: .normal)
        setuplabels(lbl: filterlbl, text: "FILTER", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .left)
        
        
        leftTapBtn.setTitle("", for: .normal)
        rightTapBtn.setTitle("", for: .normal)
        
        leftTapView.backgroundColor = .WhiteColor
        rightTapView.backgroundColor = .WhiteColor
        commonTableView.backgroundColor = .WhiteColor
        
    }
    
    
    
    func setupTV() {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "multicity" {
                multicityFilterdList(list: MCJflightlist ?? [])
            }else {
                onewayFilterdList(list: FlightList ?? [])
            }
        }
        
        
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton){
        callapibool = false
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
        
    }
    
    
    @objc func didTapOnEditBtn(_ sender:UIButton){
        gotoModifySearchFlightVC(key: "edit")
    }
    
    
    func gotoModifySearchFlightVC(key:String) {
        guard let vc = ModifySearchFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = key
        present(vc, animated: true)
    }
    
    
    
    
    
    // MARK: - MultiCityTripFlightResultTVCell
    override func didTapOnFlightDetailsBtnAction(cell:MultiCityTripFlightResultTVCell){
        defaults.set(cell.indexPath?.row ?? 0, forKey: UserDefaultsKeys.selectdFlightcellIndex)
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        gotoBaggageInfoVC()
    }
    
    
    override func didTapOnBookNowBtnAction(cell:MultiCityTripFlightResultTVCell){
        flightSelectedIndex = Int(cell.indexPath?.row ?? 0 )
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        totalprice = cell.totalPrice
        gotoBookingDetailsVC()
    }
    
    
    // MARK: - didTapOnSortBtnAction
    @IBAction func didTapOnSortBtnAction(_ sender: Any) {
        gotoFilterVC(strkey: "sort")
    }
    
    // MARK: - didTapOnFilterBtn
    @IBAction func didTapOnFilterBtn(_ sender: Any) {
        gotoFilterVC(strkey: "filter")
    }
    
    
    //MARK: - gotoFilterVC
    func gotoFilterVC(strkey:String) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterKey = strkey
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnPreviousDateBtnAction
    @IBAction func didTapOnPreviousDateBtnAction(_ sender: Any) {
        
       
        loderBool = true
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the previous day's date
                let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let previousDayString = dateFormatter.string(from: previousDay!)
                print("previousDayString ==== > \(previousDayString)")
                defaults.set(previousDayString, forKey: UserDefaultsKeys.calDepDate)
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                self.datelbl.text = previousDayString
                
                callAPI()
                
            }else {
                
                
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: -1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                
                if returnDatalbl.text == nextDayString {
                    showToast(message: "Journey Dates Should Not Same")
                }else {
                    
                    
                    print("nextDayString ==== > \(nextDayString)")
                    defaults.set(nextDayString, forKey: UserDefaultsKeys.rcalDepDate)
                    payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
                    self.datelbl.text = nextDayString
                    
                    callAPI()
                }
            }
            
        }
        
        
    }
    
    //MARK: - didTapOnNextDateBtnTapAction
    @IBAction func didTapOnNextDateBtnTapAction(_ sender: Any) {
        
        
        loderBool = true
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            
            if journeyType == "oneway" {
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                print("nextDayString ==== > \(nextDayString)")
                defaults.set(nextDayString, forKey: UserDefaultsKeys.calDepDate)
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                self.datelbl.text = nextDayString
                
                callAPI()
                
            }else {
                
                
                // Convert the date string to a Date object
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? ""
                guard let date = dateFormatter.date(from: dateString) else { return }
                
                // Get the next day's date
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
                
                // Convert the next and previous day's dates back to a string format
                let nextDayString = dateFormatter.string(from: nextDay!)
                print("nextDayString ==== > \(nextDayString)")
                
                if returnDatalbl.text == nextDayString {
                    showToast(message: "Journey Dates Should Not Same")
                }else {
                    
                    
                    defaults.set(nextDayString, forKey: UserDefaultsKeys.rcalDepDate)
                    payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
                    self.datelbl.text = nextDayString
                    
                    callAPI()
                }
            }
            
        }
        
    }
    
    
    
    
    
    
    //MARK: - didTapOnSimilarOptionBtnAction  MultiCityTripFlightResultTVCell
    override func didTapOnSimilarOptionBtnAction(cell:MultiCityTripFlightResultTVCell){
        //        // Use flatMap to combine all the arrays into a single array
        //        let similarFlightList = MCJflightlist?.filter { flight in
        //            return String(format: "%.2f", flight.price?.api_total_display_fare ?? "") == cell.displayPrice
        //        }
        //
        //        if similarFlightList?.count != 0 {
        //            guard let vc = similarFlightsVC.newInstance.self else {return}
        //            vc.modalPresentationStyle = .overCurrentContext
        //            callapibool = true
        //            vc.similarflightListMulticity = similarFlightList ?? []
        //            present(vc, animated: true)
        //        }else {
        //            showToast(message: "No Flights Found")
        //        }
    }
    
    
    
    //MARK: - didTapOnMoveUpScreenBtn
    @IBAction func didTapOnMoveUpScreenBtn(_ sender: Any) {
        //        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        //        self.hiddenView.isHidden = true
    }
    
    
    
    //MARK: - didTapOnShowChatWindow
    @IBAction func didTapOnShowChatWindow(_ sender: Any) {
        Freshchat.sharedInstance().showConversations(self)
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
    
    
    //MARK: - didTapOnMoreSimilarBtnAction NewFlightSearchResultTVCell
    override func didTapOnMoreSimilarBtnAction(cell: NewFlightSearchResultTVCell) {
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journyType == "multicity" {
                multicitySimilarTap(displayPrice: cell.displayPrice)
            }else {
                onewaySimilarTap(displayPrice: cell.displayPrice)
            }
            
        }
    }
    
    
    
    func onewaySimilarTap(displayPrice:String){
        let similarFlights = similar(fare: Double(displayPrice) ?? 0.0)
        print(similarFlights.count)
        
        // Use flatMap to combine all the arrays into a single array
        let similarFlightList = FlightList?.filter { flight in
            return String(format: "%.2f", flight.first?.price?.api_total_display_fare ?? "") == displayPrice
        }
        
        if similarFlightList?.count != 0 {
            
            guard let vc = similarFlightsVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            callapibool = true
            vc.similarflightList = similarFlightList ?? [[]]
            present(vc, animated: true)
        }else {
            showToast(message: "No Flights Found")
        }
    }
    
    
    
    
    func multicitySimilarTap(displayPrice:String){
        let similarFlights = similar(fare: Double(displayPrice) ?? 0.0)
        print(similarFlights.count)
        
        // Use flatMap to combine all the arrays into a single array
        let similarFlightList = MCJflightlist?.filter { flight in
            return String(format: "%.2f", flight.first?.price?.api_total_display_fare ?? "") == displayPrice
        }
        
        if similarFlightList?.count != 0 {
            
            guard let vc = similarFlightsVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            callapibool = true
            vc.similarflightListMulticity = similarFlightList ?? [[]]
            present(vc, animated: true)
        }else {
            showToast(message: "No Flights Found")
        }
    }
    
    
    
    
}



extension SearchFlightResultVC: AppliedFilters{
    
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
    }
    
    
    
    func filtersByApplied(minpricerange: Double, maxpricerange: Double, noofStopsArray: [String], refundableTypeArray: [String], departureTime: String, arrivalTime: String, noOvernightFlight: String, airlinesFilterArray: [String], connectingFlightsFilterArray: [String], ConnectingAirportsFilterArray: [String]) {
        
        
        print(" ===== minpricerange ====== \n\(minpricerange)")
        print(" ===== maxpricerange ====== \n\(maxpricerange)")
        print(" ===== noofStopsArray ====== \n\(noofStopsArray.joined(separator: ","))")
        print(" ===== refundableTypeArray ====== \n\(refundableTypeArray)")
        print(" ===== airlinesFilterArray ====== \n\(airlinesFilterArray.joined(separator: ","))")
        print(" ===== departureTime ====== \n\(departureTime)")
        print(" ===== arrivalTime ====== \n\(arrivalTime)")
        print(" ===== noOvernightFlight ====== \n\(noOvernightFlight)")
        print(" ===== connectingFlightsFilterArray ====== \n\(connectingFlightsFilterArray)")
        print(" ===== ConnectingAirportsFilterArray ====== \n\(ConnectingAirportsFilterArray)")
        
        
        //                if let flightList = MCJflightlist {
        //                    let filteredList = flightList.filter { flight in
        //                        guard let summary = flight.flight_details?.summary else { return false }
        //                        let priceString = flight.price?.api_total_display_fare ?? 0.0 // Provide a default value if it's nil
        //                        let doublePrice = Double(priceString) // Convert to Double or use a default value if conversion fails
        //
        //
        //                        let priceRangeMatch = (doublePrice >= minpricerange && doublePrice <= maxpricerange)
        //                        let noOfStopsMatch = noofStopsArray.isEmpty || summary.contains(where: { noofStopsArray.contains("\($0.no_of_stops ?? 0)") })
        //                        let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(flight.fareType ?? "")
        //                        let airlinesMatch = airlinesFilterArray.isEmpty || summary.contains(where: { airlinesFilterArray.contains($0.operator_name ?? "") })
        //                        let connectingFlightsMatch = connectingFlightsFilterArray.isEmpty || summary.contains(where: { connectingFlightsFilterArray.contains($0.operator_name ?? "") })
        //                        let connectingAirportsMatch = ConnectingAirportsFilterArray.isEmpty || summary.contains(where: { ConnectingAirportsFilterArray.contains($0.destination?.airport_name ?? "") })
        //
        //                        return priceRangeMatch && noOfStopsMatch && refundableMatch && airlinesMatch && connectingFlightsMatch && connectingAirportsMatch
        //                    }
        //
        //                    multicityFilterdList(list: filteredList)
        //                }
        //
        //            }
        //        }
        
        let sortedArray = FlightList.map { flight in
            flight.filter { j in
                
                guard let summary = j.first?.flight_details?.summary else { return false }
                guard let price = j.first?.price?.api_total_display_fare else { return false }
                
                
                let priceRangeMatch = ((Double(price) ) >= minpricerange && (Double(price) ) <= maxpricerange)
                
                let noOfStopsMatch = noofStopsArray.isEmpty || summary.contains(where: { noofStopsArray.contains("\($0.no_of_stops ?? 0)") }) == true
                let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(j.first?.fareType ?? "")
                let airlinesMatch = airlinesFilterArray.isEmpty || summary.contains(where: { airlinesFilterArray.contains($0.operator_name ?? "") }) == true
                let connectingFlightsMatch = connectingFlightsFilterArray.isEmpty || summary.contains(where: { connectingFlightsFilterArray.contains($0.operator_name ?? "") }) == true
                let ConnectingAirportsMatch = connectingFlightsFilterArray.isEmpty || summary.contains(where: { connectingFlightsFilterArray.contains($0.destination?.airport_name ?? "") }) == true
                
                
                return priceRangeMatch && noOfStopsMatch && refundableMatch && airlinesMatch && connectingFlightsMatch && ConnectingAirportsMatch
            }
        }
        
        
        onewayFilterdList(list: sortedArray ?? [[]])
        
    }
    
    
    //MARK: - SORT BY FILTER
    func filtersSortByApplied(sortBy: SortParameter) {
        
        filterdFlightList?.removeAll()
        
        
        if sortBy == .PriceLow{
            
            let sortedArray = FlightList?.sorted(by: { Double($0.first?.totalPrice ?? "0.0") ?? 0.0 < Double($1.first?.totalPrice ?? "0.0") ?? 0.0 })
            
            onewayFilterdList(list: sortedArray ?? [[]])
            
            
        }else if sortBy == .PriceHigh{
            
            
            let sortedArray = FlightList?.sorted(by: { Double($0.first?.totalPrice ?? "0.0") ?? 0.0 > Double($1.first?.totalPrice ?? "0.0") ?? 0.0 })
            
            onewayFilterdList(list: sortedArray ?? [[]])
            
            
        }else if sortBy == .DepartureLow {
            
            if let flightList = FlightList {
                let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
                    let time1 = a.flight_details?.summary?.first?.destination?.time ?? ""
                    let time2 = b.flight_details?.summary?.first?.destination?.time ?? ""
                    return time1 < time2
                }
                onewayFilterdList1(list: sortedArray)
            }
            
            //                    if let flightList = MCJflightlist {
            //
            //                        let sortedArray = flightList.compactMap { $0 }.sorted { a, b in
            //                            let time1 = a.flight_details?.summary?.first?.destination?.time ?? ""
            //                            let time2 = b.flight_details?.summary?.first?.destination?.time ?? ""
            //                            return time1 < time2
            //                        }
            //
            //
            //                        multicityFilterdList(list: sortedArray)
            //                    }
            
            
        }else if sortBy == .DepartureHigh {
            
            
            
            if let flightList = FlightList {
                
                let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
                    let time1 = a.flight_details?.summary?.first?.destination?.time ?? ""
                    let time2 = b.flight_details?.summary?.first?.destination?.time ?? ""
                    return time1 > time2
                }
                onewayFilterdList1(list: sortedArray)
                
            }
            
            //                    if let flightList = MCJflightlist {
            //
            //                        let sortedArray = flightList.compactMap { $0 }.sorted { a, b in
            //                            let time1 = a.flight_details?.summary?.first?.destination?.time ?? ""
            //                            let time2 = b.flight_details?.summary?.first?.destination?.time ?? ""
            //                            return time1 > time2
            //                        }
            //
            //
            //                        multicityFilterdList(list: sortedArray)
            //                    }
            
        }else if sortBy == .ArrivalLow{
            print(" .ArrivalLow .ArrivalLow .ArrivalLow .ArrivalLow")
            
            
            
            if let flightList = FlightList {
                
                let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
                    let time1 = a.flight_details?.summary?.first?.origin?.time ?? ""
                    let time2 = b.flight_details?.summary?.first?.origin?.time ?? ""
                    return time1 < time2
                }
                onewayFilterdList1(list: sortedArray)
                
            }
            
            //                    if let flightList = MCJflightlist {
            //
            //                        let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
            //                            let time1 = a.flight_details?.summary?.first?.origin?.time ?? ""
            //                            let time2 = b.flight_details?.summary?.first?.origin?.time ?? ""
            //                            return time1 < time2
            //                        }
            //
            //
            //                        multicityFilterdList(list: sortedArray)
            //                    }
            //
            
            
        }else if sortBy == .ArrivalHigh{
            
            
            if let flightList = FlightList {
                let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
                    let time1 = a.flight_details?.summary?.first?.origin?.time ?? ""
                    let time2 = b.flight_details?.summary?.first?.origin?.time ?? ""
                    return time1 > time2
                }
                onewayFilterdList1(list: sortedArray)
                
            }
            
            
            //                    if let flightList = MCJflightlist {
            //
            //                        let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
            //                            let time1 = a.flight_details?.summary?.first?.origin?.time ?? ""
            //                            let time2 = b.flight_details?.summary?.first?.origin?.time ?? ""
            //                            return time1 > time2
            //                        }
            //
            //
            //                        multicityFilterdList(list: sortedArray)
            //                    }
            //
            
        }else if sortBy == .DurationLow{
            
            
            if let flightList = FlightList {
                let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
                    let duration_seconds1 = a.flight_details?.summary?.first?.duration_seconds ?? 0
                    let duration_seconds2 = b.flight_details?.summary?.first?.duration_seconds ?? 0
                    return duration_seconds1 < duration_seconds2
                }
                onewayFilterdList1(list: sortedArray)
                
            }
            
            //   if let flightList = MCJflightlist {
            //
            //                        let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
            //                            let duration_seconds1 = a.flight_details?.summary?.first?.duration_seconds ?? 0
            //                            let duration_seconds2 = b.flight_details?.summary?.first?.duration_seconds ?? 0
            //                            return duration_seconds1 < duration_seconds2
            //                        }
            //
            //
            //                        multicityFilterdList(list: sortedArray)
            //                    }
            //
            
        }else if sortBy == .DurationHigh{
            
            
            if let flightList = FlightList {
                let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
                    let duration_seconds1 = a.flight_details?.summary?.first?.duration_seconds ?? 0
                    let duration_seconds2 = b.flight_details?.summary?.first?.duration_seconds ?? 0
                    return duration_seconds1 > duration_seconds2
                }
                onewayFilterdList1(list: sortedArray)
            }
            
            
            //   if let flightList = MCJflightlist {
            //
            //                        let sortedArray = flightList.compactMap { $0 }.sorted { a, b in
            //                            let duration_seconds1 = a.flight_details?.summary?.first?.duration_seconds ?? 0
            //                            let duration_seconds2 = b.flight_details?.summary?.first?.duration_seconds ?? 0
            //                            return duration_seconds1 > duration_seconds2
            //                        }
            //
            //
            //                        multicityFilterdList(list: sortedArray)
            //                    }
            
        }else if sortBy == .airlinessortatoz{
            
            
            
            if let flightList = FlightList {
                
                
                let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
                    let operator_name1 = a.flight_details?.summary?.first?.operator_name ?? ""
                    let operator_name2 = b.flight_details?.summary?.first?.operator_name ?? ""
                    return operator_name1 < operator_name2 // Sort in ascending order
                }
                onewayFilterdList1(list: sortedArray)
            }
            
            //  if let flightList = MCJflightlist {
            //
            //                        let sortedArray = flightList.compactMap { $0 }.sorted { a, b in
            //                            let operator_name1 = a.flight_details?.summary?.first?.operator_name ?? ""
            //                            let operator_name2 = b.flight_details?.summary?.first?.operator_name ?? ""
            //                            return operator_name1 < operator_name2 // Sort in ascending order
            //                        }
            //
            //
            //                        multicityFilterdList(list: sortedArray)
            //                    }
            
        }else if sortBy == .airlinessortztoa{
            
            
            if let flightList = FlightList {
                
                
                let sortedArray = flightList.flatMap { $0 }.sorted { a, b in
                    let operator_name1 = a.flight_details?.summary?.first?.operator_name ?? ""
                    let operator_name2 = b.flight_details?.summary?.first?.operator_name ?? ""
                    return operator_name1 < operator_name2 // Sort in ascending order
                }
                onewayFilterdList1(list: sortedArray)
            }
        }
        //
        //                        let sortedArray = flightList.compactMap { $0 }.sorted { a, b in
        //                            let operator_name1 = a.flight_details?.summary?.first?.operator_name ?? ""
        //                            let operator_name2 = b.flight_details?.summary?.first?.operator_name ?? ""
        //                            return operator_name1 > operator_name2 // Sort in decending order
        //                        }
        //
        //
        //                        multicityFilterdList(list: sortedArray)
        //                    }
        
        
    }
    
    
    
    func onewayFilterdList(list:[[J_flight_list]]) {
        commonTableView.backgroundColor = .AppHolderViewColor
        tablerow.removeAll()
        var updatedUniqueList: [[J_flight_list]] = []
        var similarFlights1: [[J_flight_list]] = []
        updatedUniqueList = getUniqueElements_oneway(inputArray: list)
        
        if list.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            //   self.hiddenView.isHidden = true
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            tablerow.removeAll()
            
            updatedUniqueList.forEach({ i in
                i.forEach { j in
                    
                    similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
                    
                    tablerow.append(TableRow(title:"\(j.price?.api_total_display_fare_withoutmarkup ?? 0.0)",
                                             subTitle: j.fareType ?? "",
                                             price: "\(j.price?.api_total_display_fare ?? 0.0)",
                                             key: "oneway",
                                             text: j.selectedResult ?? "",
                                             buttonTitle: j.aPICurrencyType ?? "",
                                             data: similarFlights1,
                                             moreData: j.flight_details?.summary ?? [],
                                             cellType:.NewFlightSearchResultTVCell))
                    
                    
                }
            })
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    
    
    func onewayFilterdList1(list:[J_flight_list]) {
        commonTableView.backgroundColor = .AppHolderViewColor
        tablerow.removeAll()
        
        
        list.forEach { j in
            let similarFlights1 = similar(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
            
            tablerow.append(TableRow(title:String(format: "%.2f", j.price?.api_total_display_fare_withoutmarkup ?? ""),
                                     subTitle: j.fareType ?? "",
                                     price: String(format: "%.2f", j.price?.api_total_display_fare ?? ""),
                                     key: "oneway",
                                     text: j.selectedResult ?? "",
                                     buttonTitle: j.aPICurrencyType ?? "",
                                     data: similarFlights1,
                                     moreData: j.flight_details?.summary ?? [],
                                     cellType:.NewFlightSearchResultTVCell))
            
            
        }
        
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        if list.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            //     self.hiddenView.isHidden = true
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    
    
    
    //MARK: - multicityFilterdList
    
    func multicityFilterdList(list:[[MCJ_flight_list]]) {
        commonTableView.backgroundColor = .AppHolderViewColor
        tablerow.removeAll()
        var updatedUniqueList: [[MCJ_flight_list]] = []
        var similarFlights1: [[MCJ_flight_list]] = []
        updatedUniqueList = getUniqueElements_multicity(inputArray: list)
        
        if list.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            //   self.hiddenView.isHidden = true
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            tablerow.removeAll()
            
            updatedUniqueList.forEach({ i in
                i.forEach { j in
                    
                    similarFlights1 = similar_multicity(fare: Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")) ?? 0.0)
                    
                    tablerow.append(TableRow(title:"\(j.price?.api_total_display_fare_withoutmarkup ?? 0.0)",
                                             subTitle: j.fareType ?? "",
                                             price: "\(j.price?.api_total_display_fare ?? 0.0)",
                                             key: "oneway",
                                             text: j.selectedResult ?? "",
                                             buttonTitle: j.aPICurrencyType ?? "",
                                             data: similarFlights1,
                                             moreData: j.flight_details?.summary ?? [],
                                             cellType:.NewFlightSearchResultTVCell))
                    
                    
                }
            })
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    
}



extension SearchFlightResultVC {
    
    func callAPI() {
       
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "multicity" {
                viewModel?.CallMulticityTripSearchFlightAPI(dictParam: payload)
            }else {
                viewModel?.CallSearchFlightAPI(dictParam: payload)
            }
        }
    }
}



extension SearchFlightResultVC:FlightListModelProtocal{
    
    func flightList(response: FlightSearchModel) {
        
        if response.status == 1 {
            
            
            
            self.holderView.isHidden = false
            loderBool = false
            
            oldjournyType = response.data?.search_params?.trip_type ?? ""
            //   chatBtnView.isHidden = false
            holderView.backgroundColor = .AppHolderViewColor
            FlightList = response.data?.j_flight_list
            defaults.set(response.data?.search_id, forKey: UserDefaultsKeys.searchid)
            defaults.set(response.data?.booking_source, forKey: UserDefaultsKeys.bookingsource)
            defaults.set(response.data?.booking_source_key, forKey: UserDefaultsKeys.bookingsourcekey)
            defaults.set(response.data?.traceId, forKey: UserDefaultsKeys.traceId)
            
            
            setuplabels(lbl: navView.lbl1, text: "\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
            
            
            setuplabels(lbl: datelbl, text: response.data?.search_params?.depature ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
            
            
            setuplabels(lbl: cityCodelbl, text: "\(response.data?.search_params?.from_loc ?? "")-\(response.data?.search_params?.to_loc ?? "")", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
            
            setuplabels(lbl: navView.lbl2, text: "On \(convertDateFormat(inputDate: "\(response.data?.search_params?.depature ?? "")", f1: "dd-MM-yyyy", f2: "dd MMM")) \n \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .center)
            
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "circle" {
                    returnDatalbl.isHidden = false
                    
                    setuplabels(lbl: navView.lbl1, text: "\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
                    
                    
                    setuplabels(lbl: datelbl, text: response.data?.search_params?.depature ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
                    
                    setuplabels(lbl: returnDatalbl, text: response.data?.search_params?.freturn ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
                    
                    
                    setuplabels(lbl: cityCodelbl, text: "\(response.data?.search_params?.from_loc ?? "")-\(response.data?.search_params?.to_loc ?? "")", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
                    
                    setuplabels(lbl: navView.lbl2, text: "On \(convertDateFormat(inputDate: "\(response.data?.search_params?.depature ?? "")", f1: "dd-MM-yyyy", f2: "dd MMM")) & Return \(convertDateFormat(inputDate: "\(response.data?.search_params?.freturn ?? "")", f1: "dd-MM-yyyy", f2: "dd MMM")) \n \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .center)
                    
                }
            }
            
            DispatchQueue.main.async {[self] in
                setInputs()
            }
        }else {
            
            guard let vc = NoInternetConnectionVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            vc.key = "noresult"
            self.present(vc, animated: true)
        }
        
        
    }
    
    
    func multiTripflightList(response: MulticityModel) {
        
        
        if response.status == 1 {
    
            self.holderView.isHidden = false
            loderBool = false
            
            oldjournyType = response.data?.search_params?.trip_type ?? "''"
            MCJflightlist = response.data?.j_flight_list
            defaults.set(response.data?.search_id, forKey: UserDefaultsKeys.searchid)
            defaults.set(response.data?.booking_source, forKey: UserDefaultsKeys.bookingsource)
            defaults.set(response.data?.booking_source_key, forKey: UserDefaultsKeys.bookingsourcekey)
            defaults.set(response.data?.traceId, forKey: UserDefaultsKeys.traceId)
            
            
            
            
            setuplabels(lbl: navView.lbl1, text: response.data?.search_params?.from_loc?.joined(separator: "-") ?? "", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
            setuplabels(lbl: navView.lbl2, text: response.data?.search_params?.depature?.joined(separator: ",") ?? "", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .center)
            setuplabels(lbl: datelbl, text: response.data?.search_params?.depature?[0] ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
            setuplabels(lbl: cityCodelbl, text: "\(response.data?.search_params?.from_loc?[0] ?? "") - \(response.data?.search_params?.from_loc?[1] ?? "")", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
            
            
            
            DispatchQueue.main.async {[self] in
                setInputs()
            }
            
        }else {
            
            guard let vc = NoInternetConnectionVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            vc.key = "noresult"
            self.present(vc, animated: true)
        }
        
    }
    
    
    func setInputs(){
        
        setUpNav()
        appendPriceAndDate()
        setupTV()
    }
    
}




extension SearchFlightResultVC {
    
    
    
    //MARK: - similar  J_flight_list
    func similar(fare:Double) -> [[J_flight_list]] {
        
        
        // Create a dictionary to group flights with the same api_total_display_fare
        var similarFlightsDictionary: [Double: [[J_flight_list]]] = [:]
        
        // Iterate through the FlightList
        FlightList?.forEach({ i in
            i.forEach { j in
                if let fare = Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")){
                    // Check if the fare is already present in the dictionary
                    if let existingFlights = similarFlightsDictionary[fare] {
                        // If it exists, append the current flight to the existing array
                        var updatedFlights = existingFlights
                        updatedFlights.append([j])
                        similarFlightsDictionary[fare] = updatedFlights
                    } else {
                        // If it doesn't exist, create a new array with the current flight
                        similarFlightsDictionary[fare] = [[j]]
                    }
                }
            }
        })
        
        
        
        // To access the flights with a specific fare, you can do something like this:
        if let flightsWithFare101 = similarFlightsDictionary[fare] {
            // flightsWithFare101 will contain an array of flights with api_total_display_fare equal to 101.0
            return flightsWithFare101
        }else {
            return [[]]
        }
        
    }
    
    
    
    
    
    
    //MARK: - similar_multicity  MCJ_flight_list
    func similar_multicity(fare:Double) -> [[MCJ_flight_list]] {
        
        
        // Create a dictionary to group flights with the same api_total_display_fare
        var similarFlightsDictionary: [Double: [[MCJ_flight_list]]] = [:]
        
        // Iterate through the FlightList
        MCJflightlist?.forEach({ i in
            i.forEach { j in
                if let fare = Double(String(format: "%.2f", j.price?.api_total_display_fare ?? "")){
                    // Check if the fare is already present in the dictionary
                    if let existingFlights = similarFlightsDictionary[fare] {
                        // If it exists, append the current flight to the existing array
                        var updatedFlights = existingFlights
                        updatedFlights.append([j])
                        similarFlightsDictionary[fare] = updatedFlights
                    } else {
                        // If it doesn't exist, create a new array with the current flight
                        similarFlightsDictionary[fare] = [[j]]
                    }
                }
            }
        })
        
        
        
        // To access the flights with a specific fare, you can do something like this:
        if let flightsWithFare101 = similarFlightsDictionary[fare] {
            // flightsWithFare101 will contain an array of flights with api_total_display_fare equal to 101.0
            return flightsWithFare101
        }else {
            return [[]]
        }
        
    }
    
    
    
    
    
    //MARK: - Function to get unique elements based on totalPrice oneway
    func getUniqueElements_oneway(inputArray: [[J_flight_list]]) -> [[J_flight_list]] {
        var uniqueElements: [[J_flight_list]] = []
        var uniquePrices: Set<String> = []
        
        for array in inputArray {
            var uniqueArray: [J_flight_list] = []
            for item in array {
                if !uniquePrices.contains("\(item.price?.api_total_display_fare ?? 0.0)") {
                    uniquePrices.insert("\(item.price?.api_total_display_fare ?? 0.0)")
                    uniqueArray.append(item)
                }
            }
            if !uniqueArray.isEmpty {
                uniqueElements.append(uniqueArray)
            }
        }
        
        return uniqueElements
    }
    
    
    
    
    
    //MARK: - Function to get unique elements based on totalPrice oneway
    func getUniqueElements_multicity(inputArray: [[MCJ_flight_list]]) -> [[MCJ_flight_list]] {
        var uniqueElements: [[MCJ_flight_list]] = []
        var uniquePrices: Set<String> = []
        
        for array in inputArray {
            var uniqueArray: [MCJ_flight_list] = []
            for item in array {
                if !uniquePrices.contains("\(item.price?.api_total_display_fare ?? 0.0)") {
                    uniquePrices.insert("\(item.price?.api_total_display_fare ?? 0.0)")
                    uniqueArray.append(item)
                }
            }
            if !uniqueArray.isEmpty {
                uniqueElements.append(uniqueArray)
            }
        }
        
        return uniqueElements
    }
    
    
    
    //MARK: - APPEND PRICE AND DATE
    func appendPriceAndDate() {
        
        kwdPriceArray.removeAll()
        dateArray.removeAll()
        AirlinesArray.removeAll()
        ConnectingFlightsArray.removeAll()
        ConnectingAirportsArray.removeAll()
        prices.removeAll()
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "multicity" {
                MCJflightlist.map { i in
                    i.map { j in
                        j.map { k in
                            
                            k.flight_details?.summary.map({ l in
                                kwdPriceArray.append(k.totalPrice_API ?? "")
                                prices.append(k.totalPrice ?? "")
                                //   prices.append("\(k.aPICurrencyType ?? "")\(k.totalPrice ?? "")")
                                
                                l.map { m in
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd MMM yyyy"
                                    if let date = dateFormatter.date(from: "\(m.origin?.date ?? "")"){
                                        dateFormatter.dateFormat = "dd MMM"
                                        let resultString = dateFormatter.string(from: date)
                                        dateArray.append(dateFormatter.string(from: date))
                                    }
                                    
                                    AirlinesArray.append(m.operator_name ?? "")
                                    ConnectingFlightsArray.append(m.operator_name ?? "")
                                    ConnectingAirportsArray.append(m.destination?.airport_name ?? "")
                                    
                                }
                            })
                        }
                    }
                }
            }else {
                FlightList.map { i in
                    i.map { j in
                        j.map { k in
                            
                            k.flight_details?.summary.map({ l in
                                kwdPriceArray.append(k.totalPrice_API ?? "")
                                prices.append(k.totalPrice ?? "")
                                //   prices.append("\(k.aPICurrencyType ?? "")\(k.totalPrice ?? "")")
                                
                                l.map { m in
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd MMM yyyy"
                                    if let date = dateFormatter.date(from: "\(m.origin?.date ?? "")"){
                                        dateFormatter.dateFormat = "dd MMM"
                                        let resultString = dateFormatter.string(from: date)
                                        dateArray.append(dateFormatter.string(from: date))
                                    }
                                    
                                    AirlinesArray.append(m.operator_name ?? "")
                                    ConnectingFlightsArray.append(m.operator_name ?? "")
                                    ConnectingAirportsArray.append(m.destination?.airport_name ?? "")
                                    
                                }
                            })
                        }
                    }
                }
            }
        }
        
        
        
        
        
        kwdPriceArray = kwdPriceArray.unique()
        dateArray = dateArray.unique()
        AirlinesArray = AirlinesArray.unique()
        ConnectingFlightsArray = ConnectingFlightsArray.unique()
        ConnectingAirportsArray = ConnectingAirportsArray.unique()
        prices = prices.unique()
        
        
    }
    
    
    
}


extension SearchFlightResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
    }
    
    
    @objc func reloadTV() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func reload() {
        
        DispatchQueue.main.async {[self] in
            callAPI()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}


