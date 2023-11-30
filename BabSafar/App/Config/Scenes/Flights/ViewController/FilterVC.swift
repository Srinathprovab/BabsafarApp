//
//  FilterVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit



struct FlightFilterModel {
    var minPriceRange: Double?
    var maxPriceRange: Double?
    var noOfStops: [String] = []
    var refundableTypes: [String] = []
    var airlines: [String] = []
    var departureTime: [String] = []
    var arrivalTime: [String] = []
    var noOvernightFlight: [String] = []
    var connectingFlights: [String] = []
    var connectingAirports: [String] = []
    var luggage: [String] = []
}


struct HotelFilterModel {
    var minPriceRange: Double?
    var maxPriceRange: Double?
    var starRating = String()
    var refundableTypes: [String] = []
    var nearByLocA: [String] = []
    var niberhoodA: [String] = []
    var aminitiesA: [String] = []
}



enum SortParameter {
    case PriceHigh
    case PriceLow
    case DurationHigh
    case DurationLow
    case DepartureHigh
    case DepartureLow
    case ArrivalHigh
    case ArrivalLow
    case starLow
    case starHeigh
    case nothing
    case airlinessortatoz
    case airlinessortztoa
}

protocol AppliedFilters:AnyObject {
    func filtersSortByApplied(sortBy: SortParameter)
    func filtersByApplied(minpricerange:Double,
                          maxpricerange:Double,
                          noofStopsArray:[String],
                          refundableTypeArray:[String],
                          departureTime:[String],
                          arrivalTime:[String],
                          noOvernightFlight:[String],
                          airlinesFilterArray:[String],
                          luggageFilterArray:[String],
                          connectingFlightsFilterArray:[String],
                          ConnectingAirportsFilterArray:[String])
    
    
    
    func hotelFilterByApplied(minpricerange:Double,
                              maxpricerange:Double,
                              starRating: String,
                              refundableTypeArray:[String],
                              nearByLocA:[String],
                              niberhoodA:[String],
                              aminitiesA:[String])
}


class FilterVC: BaseTableVC{
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var filterButtonsView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var sortbyBtnView: UIView!
    @IBOutlet weak var sortbyUL: UIView!
    @IBOutlet weak var filterUL: UIView!
    @IBOutlet weak var sortBylbl: UILabel!
    @IBOutlet weak var sortbyBtn: UIButton!
    @IBOutlet weak var filtersBtnView: UIView!
    @IBOutlet weak var filterslbl: UILabel!
    @IBOutlet weak var filtersBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    //MARK: - Flights
    weak var delegate: AppliedFilters?
    var minpricerangefilter = Double()
    var maxpricerangefilter = Double()
    var starRatingFilter = String()
    var stopsArray = ["0 Stop","1 Stop","2 Stop"]
   
    var departurnTimeArray = ["12 am - 6 am","06 am - 12 pm","12 pm - 06 pm","06 pm - 12 am"]
    var tablerow = [TableRow]()
    var filterKey = String()
    var noOverNightFlightArray = ["No"]
    var paymentTypeArray = ["Refundable","Non Refundable"]
    
    var noOvernightFlightFilterStr = [String]()
    var noOfStopsFilterArray = [String]()
    var refundablerTypeFilteArray = [String]()
    var departureTimeFilter = [String]()
    var arrivalTimeFilter = [String]()
    var airlinesFilterArray = [String]()
    var connectingFlightsFilterArray = [String]()
    var ConnectingAirportsFilterArray = [String]()
    var flightRefundablerTypeFilteArray = [String]()
    
    //MARK: - Hotels
    var selectedNeighbourwoodArray = [String]()
    var selectednearBylocationsArray = [String]()
    var selectedamenitiesArray = [String]()
    var selectedLuggageArray = [String]()
    var hotelRefundablerTypeFilteArray = [String]()
    
    static var newInstance: FilterVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FilterVC
        return vc
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        callapibool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: filterButtonsView, radius: 0, color: .WhiteColor)
        filterButtonsView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        setupViews(v: sortbyBtnView, radius: 0, color: .WhiteColor)
        setupViews(v: filtersBtnView, radius: 0, color: .WhiteColor)
        setupViews(v: sortbyUL, radius: 0, color: .AppTabSelectColor)
        setupViews(v: filterUL, radius: 0, color: .WhiteColor)
        setuplabels(lbl: sortBylbl, text: "Sort By", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        setuplabels(lbl: filterslbl, text: "Filters", textcolor: .SubTitleColor, font: .LatoRegular(size: 18), align: .center)
        closeBtn.setTitle("", for: .normal)
        sortbyBtn.setTitle("", for: .normal)
        filtersBtn.setTitle("", for: .normal)
        //  filterKey = "sort"
        
        filtersBtnView.isHidden = true
        filtersBtn.isUserInteractionEnabled = false
        sortbyBtn.isUserInteractionEnabled = false
        
        switch filterKey {
        case "filter":
            sortBylbl.text = "Filter"
            setupFilterTVCells()
            break
            
        case "sort":
            sortBylbl.text = "Sort"
            setupSortByTVCells()
            break
            
        case "hotelfilter":
            sortBylbl.text = "Filter"
            setupHotelsFilterTVCells()
            break
            
        case "hotelsort":
            sortBylbl.text = "Sort"
            setupHotelsSortByTVCells()
            break
            
            
        default:
            break
        }
        
        
        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.titleLabel?.textColor = .AppTabSelectColor
        resetBtn.titleLabel?.font = UIFont.LatoRegular(size: 16)
        commonTableView.registerTVCells(["CheckBoxTVCell",
                                         "EmptyTVCell",
                                         "SortbyTVCell",
                                         "ButtonTVCell",
                                         "DoubleSliderTVCell",
                                         "PopularFiltersTVCell",
                                         "LabelTVCell",
                                         "SliderTVCell",
                                         "FilterDepartureTVCell"])
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.WhiteColor.cgColor
    }
    
    
    
    func setupFilterTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",cellType:.SliderTVCell))
        tablerow.append(TableRow(title:"Stops",data: stopsArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Refundable Type",data: faretypeArray,cellType:.CheckBoxTVCell))
        
        tablerow.append(TableRow(title:"Luggage",data: luggageArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Departure Time",cellType:.FilterDepartureTVCell))
        tablerow.append(TableRow(title:"Arrival Time",cellType:.FilterDepartureTVCell))
        
        
//        tablerow.append(TableRow(title:"Departurn Time",key:"time", data: departurnTimeArray,cellType:.CheckBoxTVCell))
//        tablerow.append(TableRow(title:"Arrival Time",key:"time", data: departurnTimeArray,cellType:.CheckBoxTVCell))
        
        
        tablerow.append(TableRow(title:"No Overnight Flight",data: noOverNightFlightArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Airlines",data: AirlinesArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Connecting Flights",data: ConnectingFlightsArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Connecting Airports",data: ConnectingAirportsArray,cellType:.CheckBoxTVCell))
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",key: "filterbtn",bgColor: .AppBtnColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupSortByTVCells() {
        
        if screenHeight > 835{
            commonTableView.isScrollEnabled = false
        }
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Departure",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Arrival Time",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Duration",key: "no",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Airlines",key: "airline",cellType:.SortbyTVCell))
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Done",key: "filterbtn",bgColor: .AppBtnColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    func setupHotelsFilterTVCells() {
        
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",cellType:.SliderTVCell))
        tablerow.append(TableRow(title:"Star Ratings ",cellType:.PopularFiltersTVCell))
        tablerow.append(TableRow(title:"Booking Type",data: paymentTypeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Neighbourhood",data: neighbourwoodArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Near By Location's",data: nearBylocationsArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Amenities",data: amenitiesArray,cellType:.CheckBoxTVCell))
        
        
        
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Apply",key: "btn",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    func setupHotelsSortByTVCells() {
        commonTableView.isScrollEnabled = false
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",key: "",cellType:.SortbyTVCell))
        tablerow.append(TableRow(title:"Star",key: "no",cellType:.SortbyTVCell))
        
        tablerow.append(TableRow(height:200,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Done",key: "btn",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    override func didTapOnShowMoreBtn(cell:CheckBoxTVCell){
        
        
        switch cell.titlelbl.text {
        case "Airlines":
            cell.nameArray = AirlinesArray
            break
            
        default:
            break
        }
        cell.btnView.isHidden = true
        cell.btnViewHeight.constant = 0
        cell.checkOptionsTV.reloadData()
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
        
    }
    
    
    override func didTapOnOneRatingViewBtn(cell: PopularFiltersTVCell) {
        starRatingFilter = cell.onelbl.text ?? ""
    }
    override func didTapOnTwoRatingViewBtn(cell: PopularFiltersTVCell) {
        starRatingFilter = cell.twolbl.text ?? ""
    }
    override func didTapOnThreeatingViewBtn(cell: PopularFiltersTVCell) {
        starRatingFilter = cell.threelbl.text ?? ""
    }
    override func didTapOnFouratingViewBtn(cell: PopularFiltersTVCell) {
        starRatingFilter = cell.fourlbl.text ?? ""
    }
    override func didTapOnFivetingViewBtn(cell: PopularFiltersTVCell) {
        starRatingFilter = cell.fivelbl.text ?? ""
    }
    
    override func didTapOnLowtoHighBtn(cell: SortbyTVCell) {
        cell.lowtoHighlbl.textColor = .WhiteColor
        cell.lowtoHighView.backgroundColor = .AppCalenderDateSelectColor
        cell.hightoLowhlbl.textColor = .AppLabelColor
        cell.hightoLowView.backgroundColor = .WhiteColor
        
        
        
        if cell.titlelbl.text == "Price" {
            sortBy = .PriceLow
            
            
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Departure" {
            sortBy = .DepartureLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Arrival Time" {
            sortBy = .ArrivalLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Star" {
            sortBy = .starLow
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            
        }else if cell.titlelbl.text == "Duration"{
            sortBy = .DurationLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else {
            sortBy = .airlinessortatoz
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
        }
        
        
    }
    
    override func didTapOnHightoLowBtn(cell: SortbyTVCell) {
        cell.lowtoHighlbl.textColor = .AppLabelColor
        cell.lowtoHighView.backgroundColor = .WhiteColor
        cell.hightoLowhlbl.textColor = .WhiteColor
        cell.hightoLowView.backgroundColor = .AppCalenderDateSelectColor
        
        if cell.titlelbl.text == "Price" {
            sortBy = .PriceHigh
            
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Departure" {
            sortBy = .DepartureHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Arrival Time" {
            sortBy = .ArrivalHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Star" {
            sortBy = .starHeigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            
        }else if cell.titlelbl.text == "Duration"{
            sortBy = .DurationHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell5)
            }
        }else {
            sortBy = .airlinessortztoa
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                resetSortBy(cell: cell4)
            }
        }
        
        
    }
    
    
    func resetSortBy(cell:SortbyTVCell) {
        
        cell.lowtoHighlbl.textColor = .AppLabelColor
        cell.lowtoHighView.backgroundColor = .WhiteColor
        cell.hightoLowhlbl.textColor = .AppLabelColor
        cell.hightoLowView.backgroundColor = .WhiteColor
    }
    
    func resetFilterValues() {
        DispatchQueue.main.async {
            self.setupFilterTVCells()
        }
    }
    
    
    @IBAction func didTapOnResetBtn(_ sender: Any) {
        sortBy = .nothing
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String  {
            if tabselect == "Flights" {
                if filterKey == "filter" {
                    DispatchQueue.main.async {[self] in
                        resetFilter()
                    }
                }else {
                    DispatchQueue.main.async {[self] in
                        resetFlightSortFilter()
                    }
                }
            }else {
                resetHotelFilter()
            }
        }
        
        
        
    }
    
    
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnSortByBtn(_ sender: Any) {
        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        sortbyTap()
    }
    
    func sortbyTap() {
        filterKey = "sortby"
        sortBylbl.textColor = .AppTabSelectColor
        sortbyUL.backgroundColor = .AppTabSelectColor
        filterslbl.textColor = .SubTitleColor
        filterUL.backgroundColor = .WhiteColor
        
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "Flights" {
                setupSortByTVCells()
            }else {
                setupHotelsSortByTVCells()
            }
        }
    }
    
    
    
    override func didTapOnCheckBox(cell:checkOptionsTVCell){
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String{
            
            if tabselect == "Flights"  {
                
                
                switch cell.filtertitle {
                    
                    
                case "Departurn Time":
                    departureTimeFilter.append(cell.titlelbl.text ?? "")
                    break
                    
                case "Arrival Time":
                    arrivalTimeFilter.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Stops":
                    if cell.titlelbl.text == "0 Stop" {
                        noOfStopsFilterArray.append("0")
                    }else if cell.titlelbl.text == "1 Stop" {
                        noOfStopsFilterArray.append("1")
                    }else {
                        noOfStopsFilterArray.append("2")
                    }
                    
                    break
                    
                case "Refundable Type":
                    
                   
                    flightRefundablerTypeFilteArray.append(cell.titlelbl.text ?? "")
                    
                    break
                    
                case "Airlines":
                    airlinesFilterArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Luggage":
                    selectedLuggageArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "No Overnight Flight":
                    noOvernightFlightFilterStr.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Connecting Flights":
                    connectingFlightsFilterArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Connecting Airports":
                    ConnectingAirportsFilterArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                    
                default:
                    break
                }
            }else {
                
                switch cell.filtertitle {
                    
                    
                case "Booking Type":
                   
                    hotelRefundablerTypeFilteArray.append(cell.titlelbl.text ?? "")
                    
                    break
                    
                    
                    
                case "Neighbourhood":
                    selectedNeighbourwoodArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Near By Location's":
                    selectednearBylocationsArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                case "Amenities":
                    selectedamenitiesArray.append(cell.titlelbl.text ?? "")
                    break
                    
                    
                    
                    
                default:
                    break
                }
            }
            
            
        }
        
    }
    
    
    override func didTapOnDeselectCheckBox(cell: checkOptionsTVCell) {
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String{
            
            
            if tabselect == "Flights"  {
                
                switch cell.filtertitle {
                    
                    
                case "Departurn Time":
                    if let index = departureTimeFilter.firstIndex(of: cell.titlelbl.text ?? "") {
                        departureTimeFilter.remove(at: index)
                    }
                    break
                    
                case "Arrival Time":
                    if let index = arrivalTimeFilter.firstIndex(of: cell.titlelbl.text ?? "") {
                        arrivalTimeFilter.remove(at: index)
                    }
                    break
                    
                    
                case "Stops":
                    
                    if cell.titlelbl.text == "0 Stop" {
                       
                        if let index = noOfStopsFilterArray.firstIndex(of: "0") {
                            noOfStopsFilterArray.remove(at: index)
                        }
                    }else if cell.titlelbl.text == "1 Stop" {
                        if let index = noOfStopsFilterArray.firstIndex(of: "1") {
                            noOfStopsFilterArray.remove(at: index)
                        }
                    }else {
                        if let index = noOfStopsFilterArray.firstIndex(of: "2") {
                            noOfStopsFilterArray.remove(at: index)
                        }
                    }
                    
                    
                    
                    break
                    
                case "Refundable Type":
                    
                    if let index = flightRefundablerTypeFilteArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        flightRefundablerTypeFilteArray.remove(at: index)
                    }
                    
                    
                    break
                    
                    
                case "Airlines":
                    if let index = airlinesFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        airlinesFilterArray.remove(at: index)
                    }
                    break
                    
                    
                case "Luggage":
                    if let index = selectedLuggageArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedLuggageArray.remove(at: index)
                    }
                    
                    if selectedLuggageArray.isEmpty == true {
                        filterModel.luggage.removeAll()
                    }
                    
                    print(selectedLuggageArray.joined(separator: "---"))
                    break
                    
                case "No Overnight Flight":
                    
                    if let index = noOvernightFlightFilterStr.firstIndex(of: cell.titlelbl.text ?? "") {
                        noOvernightFlightFilterStr.remove(at: index)
                    }
                    break
                    
                case "Connecting Flights":
                    if let index = connectingFlightsFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        connectingFlightsFilterArray.remove(at: index)
                    }
                    
                    break
                    
                    
                case "Connecting Airports":
                    if let index = ConnectingAirportsFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        ConnectingAirportsFilterArray.remove(at: index)
                    }
                    break
                    
                    
                    
                default:
                    break
                }
            }else {
                
                
                switch cell.filtertitle {
                    
                    
                case "Booking Type":
                    
                    if let index = hotelRefundablerTypeFilteArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        hotelRefundablerTypeFilteArray.remove(at: index)
                    }
                    break
                    
                    
                case "Neighbourhood":
                    
                    if let index = selectedNeighbourwoodArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedNeighbourwoodArray.remove(at: index)
                    }
                    break
                    
                    
                case "Near By Location's":
                    
                    if let index = selectednearBylocationsArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectednearBylocationsArray.remove(at: index)
                    }
                    break
                    
                    
                case "Amenities":
                    
                    if let index = selectedamenitiesArray.firstIndex(of: cell.titlelbl.text ?? "") {
                        selectedamenitiesArray.remove(at: index)
                    }
                    break
                    
                    
                default:
                    break
                }
            }
            
            
        }
    }
    
    
    override func didTapOnTimeBtn(cell:FilterDepartureTVCell){
        
        
        switch cell.titlelbl.text {
        case "Departure Time":
        
            
            switch cell.timeString {
                
            case "12AM - 6AM":
                departureTimeFilter.append("12 am - 6 am")
                break
                
            case "6AM - 12PM":
                departureTimeFilter.append("06 am - 12 pm")
                break
                
            case "12PM - 6PM":
                departureTimeFilter.append("12 pm - 06 pm")
                break
                
                
            case "6PM - 12AM":
                departureTimeFilter.append("06 pm - 12 am")
                break
           
            default:
                break
            }
            break

        case "Arrival Time":
            
            switch cell.timeString {
                
            case "12AM - 6AM":
                arrivalTimeFilter.append("12 am - 6 am")
                break
                
            case "6AM - 12PM":
                arrivalTimeFilter.append("06 am - 12 pm")
                break
                
            case "12PM - 6PM":
                arrivalTimeFilter.append("12 pm - 06 pm")
                break
                
                
            case "6PM - 12AM":
                arrivalTimeFilter.append("06 pm - 12 am")
                break
           
            default:
                break
            }
            break
        default:
            break
        }
    }
    
    
    
    override func didTapOnShowSliderBtn(cell: SliderTVCell) {
        
        
        print("Selected minimum value: \(cell.minValue1)")
        print("Selected maximum value: \(cell.maxValue1)")
        
        minpricerangefilter = cell.minValue1
        maxpricerangefilter = cell.maxValue1
        
        
    }
    
    
    @IBAction func didTapOnFiltersBtn(_ sender: Any) {
        filtertap()
    }
    
    
    func filtertap() {
        filterKey = "filter"
        sortBylbl.textColor = .SubTitleColor
        sortbyUL.backgroundColor = .WhiteColor
        filterslbl.textColor = .AppTabSelectColor
        filterUL.backgroundColor = .AppTabSelectColor
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "Flights" {
                setupFilterTVCells()
            }else {
                setupHotelsFilterTVCells()
            }
        }
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String {
            let pricesFloat = prices.compactMap { Float($0) }
            
            if tabselect == "Flights" {
                
                if filterKey == "filter" {
                        
                        if minpricerangefilter != 0.0 {
                            filterModel.minPriceRange = minpricerangefilter
                        }else {
                            filterModel.minPriceRange = Double(pricesFloat.min() ?? 0.0)
                        }
                        
                        if maxpricerangefilter != 0.0 {
                            filterModel.maxPriceRange = maxpricerangefilter
                        }else {
                            filterModel.maxPriceRange = Double(pricesFloat.max() ?? 0.0)
                        }
                        
                        
                        if noOvernightFlightFilterStr.isEmpty == false {
                            filterModel.noOvernightFlight = noOvernightFlightFilterStr
                        }else {
                            filterModel.noOvernightFlight.removeAll()
                        }
                        
                    if departureTimeFilter.isEmpty == false {
                        filterModel.departureTime = departureTimeFilter
                    }else {
                        filterModel.departureTime.removeAll()
                    }
                    
                    if arrivalTimeFilter.isEmpty == false {
                        filterModel.arrivalTime = arrivalTimeFilter
                    }else {
                        filterModel.arrivalTime.removeAll()
                    }
                        
                        
                        if !noOfStopsFilterArray.isEmpty {
                            filterModel.noOfStops = noOfStopsFilterArray
                        }else {
                            filterModel.noOfStops.removeAll()
                        }
                        
                        if !flightRefundablerTypeFilteArray.isEmpty {
                            filterModel.refundableTypes = flightRefundablerTypeFilteArray
                        }else {
                            filterModel.refundableTypes.removeAll()
                        }
                        
                        if !airlinesFilterArray.isEmpty {
                            filterModel.airlines = airlinesFilterArray
                        }else {
                            filterModel.airlines.removeAll()
                        }
                        
                        if !connectingFlightsFilterArray.isEmpty {
                            filterModel.connectingFlights = connectingFlightsFilterArray
                        }else {
                            filterModel.connectingFlights.removeAll()
                        }
                        
                        
                        if !ConnectingAirportsFilterArray.isEmpty {
                            filterModel.connectingAirports = ConnectingAirportsFilterArray
                        }else {
                            filterModel.connectingAirports.removeAll()
                        }
                        
                        if !selectedLuggageArray.isEmpty {
                            filterModel.luggage = selectedLuggageArray
                        }else {
                            filterModel.luggage.removeAll()
                        }
                        
                        
                        
                        delegate?.filtersByApplied(minpricerange:filterModel.minPriceRange ?? 0.0,
                                                   maxpricerange: filterModel.maxPriceRange ?? 0.0,
                                                   noofStopsArray:  filterModel.noOfStops,
                                                   refundableTypeArray: filterModel.refundableTypes,
                                                   departureTime:  filterModel.departureTime ,
                                                   arrivalTime: filterModel.arrivalTime ,
                                                   noOvernightFlight: filterModel.noOvernightFlight,
                                                   airlinesFilterArray: filterModel.airlines,
                                                   luggageFilterArray: filterModel.luggage,
                                                   connectingFlightsFilterArray: filterModel.connectingFlights,
                                                   ConnectingAirportsFilterArray: filterModel.connectingAirports)
                        
                    
                }else {
                    delegate?.filtersSortByApplied(sortBy: sortBy)
                }
            }else {
                
                    
                    
                    if minpricerangefilter != 0.0 {
                        hotelfiltermodel.minPriceRange = minpricerangefilter
                    }else {
                        hotelfiltermodel.minPriceRange = Double(pricesFloat.min() ?? 0.0)
                    }
                    
                    if maxpricerangefilter != 0.0 {
                        hotelfiltermodel.maxPriceRange = maxpricerangefilter
                    }else {
                        hotelfiltermodel.maxPriceRange = Double(pricesFloat.max() ?? 0.0)
                    }
                    
                    
                    if !starRatingFilter.isEmpty {
                        hotelfiltermodel.starRating = starRatingFilter
                    }else {
                        hotelfiltermodel.starRating = ""
                    }
                    
                    
                    if !hotelRefundablerTypeFilteArray.isEmpty {
                        hotelfiltermodel.refundableTypes = hotelRefundablerTypeFilteArray
                    }else {
                        hotelfiltermodel.refundableTypes.removeAll()
                    }
                    
                    if !selectednearBylocationsArray.isEmpty {
                        hotelfiltermodel.nearByLocA = selectednearBylocationsArray
                    }else {
                        hotelfiltermodel.nearByLocA.removeAll()
                    }
                    
                    
                    if !selectedNeighbourwoodArray.isEmpty {
                        hotelfiltermodel.niberhoodA = selectedNeighbourwoodArray
                    }else {
                        hotelfiltermodel.niberhoodA.removeAll()
                    }
                    
                    if !selectedamenitiesArray.isEmpty {
                        hotelfiltermodel.aminitiesA = selectedamenitiesArray
                    }else {
                        hotelfiltermodel.aminitiesA.removeAll()
                    }
                    
                    
                    
                    delegate?.hotelFilterByApplied(minpricerange:  hotelfiltermodel.minPriceRange ?? 0.0,
                                                   maxpricerange:  hotelfiltermodel.maxPriceRange ?? 0.0,
                                                   starRating:  hotelfiltermodel.starRating,
                                                   refundableTypeArray: hotelfiltermodel.refundableTypes,
                                                   nearByLocA: hotelfiltermodel.nearByLocA,
                                                   niberhoodA: hotelfiltermodel.niberhoodA,
                                                   aminitiesA: hotelfiltermodel.aminitiesA)
                
            }
            
            
            
            
        }
        
        dismiss(animated: true)
    }
    
}




extension FilterVC {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? CheckBoxTVCell {
            
            if cell.showbool == true {
                cell.expand()
                cell.showbool = false
            }else {
                cell.hide()
                cell.showbool = true
            }
            
        }else if let cell = tableView.cellForRow(at: indexPath) as? SliderTVCell {
            if cell.showbool == true {
                cell.expand()
                cell.showbool = false
            }else {
                cell.hide()
                cell.showbool = true
            }
        }else if let cell = tableView.cellForRow(at: indexPath) as? FilterDepartureTVCell {
            if cell.showbool == true {
                cell.expand()
                cell.showbool = false
            }else {
                cell.hide()
                cell.showbool = true
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }
    }
    
}



extension FilterVC {
    
    func resetFilter() {
        // Reset all values in the FilterModel
        
       
        
        let pricesFloat = prices.compactMap { Float($0) }
        filterModel.minPriceRange = Double((pricesFloat.min() ?? prices.compactMap { Float($0) }.min()) ?? 0.0)
        filterModel.maxPriceRange = Double((pricesFloat.max() ?? prices.compactMap { Float($0) }.max()) ?? 0.0)
        if let cell = commonTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SliderTVCell {
            cell.setupUI()
        }
        minpricerangefilter = filterModel.minPriceRange ?? 0.0
        maxpricerangefilter = filterModel.maxPriceRange ?? 0.0
        
        filterModel.noOfStops = []
        filterModel.refundableTypes = []
        filterModel.airlines = []
        filterModel.connectingFlights = []
        filterModel.connectingAirports = []
        filterModel.luggage.removeAll()
        filterModel.noOvernightFlight = []
        filterModel.departureTime.removeAll()
        filterModel.arrivalTime.removeAll()
        
        noOfStopsFilterArray.removeAll()
        flightRefundablerTypeFilteArray.removeAll()
        airlinesFilterArray.removeAll()
        connectingFlightsFilterArray.removeAll()
        ConnectingAirportsFilterArray.removeAll()
        selectedLuggageArray.removeAll()
        departureTimeFilter.removeAll()
        arrivalTimeFilter.removeAll()
        
        
        // Deselect all cells in your checkOptionsTVCell table view
        deselectAllCheckOptionsCells()
        
        // Reload the table view to reflect the changes
        commonTableView.reloadData()
    }
    
    func deselectAllCheckOptionsCells() {
        // Iterate through the table view and deselect all cells
        for section in 0..<commonTableView.numberOfSections {
            for row in 0..<commonTableView.numberOfRows(inSection: section) {
                if let cell = commonTableView.cellForRow(at: IndexPath(row: row, section: section)) as? checkOptionsTVCell {
                    cell.unselected()
                }
            }
        }
    }
    
    
    func resetFlightSortFilter() {
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "Flights" {
                if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell1)
                }
                if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell2)
                }
                
                if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell3)
                }
                if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell4)
                }
                
                if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell5)
                }
                
                
            }else {
                if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell1)
                }
                if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortbyTVCell {
                    resetSortBy(cell: cell2)
                }
            }
        }
    }
    
    
}



extension FilterVC {
    func addObserver() {
        
        if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if tabSelected == "Flights" {
                loadinitiallFlightFilterValues()
            }else {
                loadinitiallHotelFilterValues()
            }
        }
    }
    
    
    
    func loadinitiallFlightFilterValues(){
        
        if !UserDefaults.standard.bool(forKey: "flightfilteronce") {
            resetFilter()
           defaults.set(true, forKey: "flightfilteronce")
        }
        
        
        if filterModel.minPriceRange != 0.0 {
            minpricerangefilter = filterModel.minPriceRange ?? Double(prices.compactMap { Float($0) }.min()!)
        }
        
        if filterModel.maxPriceRange != 0.0 {
            maxpricerangefilter = filterModel.maxPriceRange ?? Double(prices.compactMap { Float($0) }.max()!)
        }
        
        
        if !filterModel.noOfStops.isEmpty {
            noOfStopsFilterArray = filterModel.noOfStops
        }
        
        if !filterModel.refundableTypes.isEmpty {
            flightRefundablerTypeFilteArray = filterModel.refundableTypes
        }
        
        if !filterModel.airlines.isEmpty {
            airlinesFilterArray = filterModel.airlines
        }
        
        
        if !filterModel.connectingFlights.isEmpty {
            connectingFlightsFilterArray = filterModel.connectingFlights
        }
        
        if !filterModel.connectingAirports.isEmpty {
            ConnectingAirportsFilterArray = filterModel.connectingAirports
        }
        
        if !filterModel.luggage.isEmpty {
            luggageArray = filterModel.luggage
        }
        
        
        if !filterModel.noOvernightFlight.isEmpty {
            noOverNightFlightArray = filterModel.noOvernightFlight
        }
        
    }
    
    
    func loadinitiallHotelFilterValues(){
        
        if !UserDefaults.standard.bool(forKey: "hoteltfilteronce") {
            resetHotelFilter()
            defaults.set(true, forKey: "hoteltfilteronce")
        }
        
        
        if hotelfiltermodel.minPriceRange != 0.0 {
            minpricerangefilter = hotelfiltermodel.minPriceRange ?? Double(prices.compactMap { Float($0) }.min()!)
        }
        
        if hotelfiltermodel.maxPriceRange != 0.0 {
            maxpricerangefilter = hotelfiltermodel.maxPriceRange ?? Double(prices.compactMap { Float($0) }.max()!)
        }
        
     
        
        if !hotelfiltermodel.refundableTypes.isEmpty {
            hotelRefundablerTypeFilteArray = hotelfiltermodel.refundableTypes
        }
        
        if !hotelfiltermodel.aminitiesA.isEmpty {
            selectedamenitiesArray = hotelfiltermodel.aminitiesA
        }
        
        if !hotelfiltermodel.nearByLocA.isEmpty {
            selectednearBylocationsArray = hotelfiltermodel.nearByLocA
        }
        
        if !hotelfiltermodel.niberhoodA.isEmpty {
            selectedNeighbourwoodArray = hotelfiltermodel.niberhoodA
        }
    }
    
    
    func resetHotelFilter() {
        // Reset all values in the FilterModel
        
        let pricesFloat = prices.compactMap { Float($0) }
        hotelfiltermodel.minPriceRange = Double((pricesFloat.min() ?? prices.compactMap { Float($0) }.min()) ?? 0.0)
        hotelfiltermodel.maxPriceRange = Double((pricesFloat.max() ?? prices.compactMap { Float($0) }.max()) ?? 0.0)
        if let cell = commonTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SliderTVCell {
            cell.setupUI()
        }
        minpricerangefilter = hotelfiltermodel.minPriceRange ?? 0.0
        maxpricerangefilter = hotelfiltermodel.maxPriceRange ?? 0.0
        
        hotelfiltermodel.refundableTypes.removeAll()
        hotelfiltermodel.aminitiesA.removeAll()
        hotelfiltermodel.nearByLocA.removeAll()
        hotelfiltermodel.niberhoodA.removeAll()
        hotelfiltermodel.starRating = ""
        
        starRatingFilter = ""
        hotelRefundablerTypeFilteArray.removeAll()
        selectednearBylocationsArray.removeAll()
        selectedNeighbourwoodArray.removeAll()
        selectedamenitiesArray.removeAll()
        
        // Deselect all cells in your checkOptionsTVCell table view
        deselectAllCheckOptionsCells()
        
        // Reload the table view to reflect the changes
        commonTableView.reloadData()
    }
}
