//
//  FilterVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

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
                          departureTime:String,arrivalTime:String,
                          noOvernightFlight:String,
                          airlinesFilterArray:[String],
                          connectingFlightsFilterArray:[String],
                          ConnectingAirportsFilterArray:[String])
    
    
    
    func hotelFilterByApplied(minpricerange:Double,
                              maxpricerange:Double,
                              starRating: String,
                              refundableTypeArray:[String])
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
    
    
    weak var delegate: AppliedFilters?
    var sortBy: SortParameter = .nothing
    var minpricerangefilter = Double()
    var maxpricerangefilter = Double()
    var starRatingFilter = String()

    
    var stopsArray = ["0 Stop","1 Stop","1+ Stop"]
    var refundableTypeArray = ["Refundable","Non Refundable"]
    var luggageArray = ["Cabin Baggage","Checked Baggage"]
    var classArray = ["Economy","Permium Economy","Bussiness","First Class"]
    var tablerow = [TableRow]()
    var filterKey = String()
    var free_airport_shuttleArray = ["Free Ariport Shuttle","All Inclusive","Facilities"]
    var guestRating = ["Wonderful 4.5+","Very good 4+","Good 3.5+","Average 3+","Poor 4.5+"]
    var guestRating1 = ["Fully Refundable","Reserve Now , Pay Later"]
    var  healthsafetyArray = ["only show stay with enhanced health & safety measures"]
    var badPreference = ["Twin Beds","Double Bed"]
    var brands = ["Maison Privee","Jumeirah","Rove hotels"]
    var accessibilityFeatures = ["Accessibility Equipment","Accessible Bathroom","Accessible Path Of Travel"]
    var distance_from_center = [String]()
    var noOverNightFlightArray = ["No"]
    var paymentTypeArray = ["Refundable","Non Refundable"]
    var badPreferenceArray = ["Twin Beds","Double Bed"]
    var amenitiesArray = ["24 Hour Front Desk","Adults Only","Air Conditioned"]
    var neighbourhoodArray = ["Deira","Dubai","Jebel ali","Jumeirah"]
    var accommodationArray = ["Hotel"]
    
    
    var noOvernightFlightFilterStr = String()
    var noOfStopsFilterArray = [String]()
    var refundablerTypeFilteArray = [String]()
    var departureTimeFilter = String()
    var arrivalTimeFilter = String()
    var airlinesFilterArray = [String]()
    var connectingFlightsFilterArray = [String]()
    var ConnectingAirportsFilterArray = [String]()
    
    var pricetitle = String()
    var pricefilterValue = String()
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
        
        print("  viewWillAppear ")
        print(AirlinesArray.joined(separator: ","))
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
                                         "DoubleSliderTVCell","PopularFiltersTVCell","LabelTVCell","SliderTVCell","FilterDepartureTVCell"])
        
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
        tablerow.append(TableRow(title:"Refundable Type",data: refundableTypeArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Luggage",data: luggageArray,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Departure Time",cellType:.FilterDepartureTVCell))
        tablerow.append(TableRow(title:"Arrival Time",cellType:.FilterDepartureTVCell))
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
        commonTableView.isScrollEnabled = false
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",cellType:.SliderTVCell))
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
        tablerow.append(TableRow(title:"Neighbourhood",data: badPreference,cellType:.CheckBoxTVCell))
        tablerow.append(TableRow(title:"Near By Location's",data: brands,cellType:.CheckBoxTVCell))
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
    
    @IBAction func didTapOnResetBtn(_ sender: Any) {
        sortBy = .nothing
        if filterKey == "filter" {
            if let tabSelected = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
                if tabSelected == "Flights" {
                    
                }else {
                    
                }
            }
        }else {
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
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String, tabselect == "Flights" {
            
            switch cell.filtertitle {
            case "Stops":
                if cell.titlelbl.text == "0 Stop" {
                    noOfStopsFilterArray.append("0")
                }else if cell.titlelbl.text == "1 Stop" {
                    noOfStopsFilterArray.append("1")
                }else {
                    noOfStopsFilterArray.append("2")
                }
                
                print(noOfStopsFilterArray.joined(separator: "---"))
                break
                
            case "Refundable Type":
                
                if cell.titlelbl.text == "Refundable" {
                    refundablerTypeFilteArray.append("Refundable")
                }else {
                    refundablerTypeFilteArray.append("Non Refundable")
                }
                
                print(refundablerTypeFilteArray)
                break
                
            case "Airlines":
                airlinesFilterArray.append(cell.titlelbl.text ?? "")
                print(airlinesFilterArray.joined(separator: "---"))
                break
                
                
            case "No Overnight Flight":
                noOvernightFlightFilterStr = "12AM - 4AM"
                break
                
                
            case "Connecting Flights":
                connectingFlightsFilterArray.append(cell.titlelbl.text ?? "")
                print(connectingFlightsFilterArray.joined(separator: "---"))
                break
                
                
            case "Connecting Airports":
                ConnectingAirportsFilterArray.append(cell.titlelbl.text ?? "")
                print(ConnectingAirportsFilterArray.joined(separator: "---"))
                break
                
                
                
            default:
                break
            }
            
        }else {
            
            switch cell.filtertitle {
           
                
            case "Booking Type":
                
                if cell.titlelbl.text == "Refundable" {
                    refundablerTypeFilteArray.append("Refundable")
                }else {
                    refundablerTypeFilteArray.append("Non Refundable")
                }
                
                print(refundablerTypeFilteArray)
                break
                
                
            default:
                break
            }
            
        }
        
    }
    
    
    override func didTapOnDeselectCheckBox(cell: checkOptionsTVCell) {
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String, tabselect == "Flights" {
            switch cell.filtertitle {
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
                print(noOfStopsFilterArray.joined(separator: "---"))
                break
                
            case "Refundable Type":
                
                if cell.titlelbl.text == "Refundable" {
                    if let index = refundablerTypeFilteArray.firstIndex(of: "Refundable") {
                        refundablerTypeFilteArray.remove(at: index)
                    }
                }else {
                    if let index = refundablerTypeFilteArray.firstIndex(of: "Non Refundable") {
                        refundablerTypeFilteArray.remove(at: index)
                    }
                }
                print(refundablerTypeFilteArray)
                break
                
                
            case "Airlines":
                if let index = airlinesFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                    airlinesFilterArray.remove(at: index)
                }
                print(airlinesFilterArray.joined(separator: "---"))
                break
                
            case "No Overnight Flight":
                noOvernightFlightFilterStr = ""
                break
                
            case "Connecting Flights":
                if let index = connectingFlightsFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                    connectingFlightsFilterArray.remove(at: index)
                }
                print(connectingFlightsFilterArray.joined(separator: "---"))
                break
                
                
            case "Connecting Airports":
                if let index = ConnectingAirportsFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                    ConnectingAirportsFilterArray.remove(at: index)
                }
                print(ConnectingAirportsFilterArray.joined(separator: "---"))
                break
                
                
                
            default:
                break
            }
        }else {
            switch cell.filtertitle {
            
                
            case "Booking Type":
                
                if cell.titlelbl.text == "Refundable" {
                    if let index = refundablerTypeFilteArray.firstIndex(of: "Refundable") {
                        refundablerTypeFilteArray.remove(at: index)
                    }
                }else {
                    if let index = refundablerTypeFilteArray.firstIndex(of: "Non Refundable") {
                        refundablerTypeFilteArray.remove(at: index)
                    }
                }
                print(refundablerTypeFilteArray)
                break
                
                
           
                
            default:
                break
            }
        }
    }
    
    
    override func didTapOnTimeBtn(cell:FilterDepartureTVCell){
        switch cell.titlelbl.text {
        case "Departure Time":
            departureTimeFilter = cell.timeString
            break
            
        case "Arrival Time":
            arrivalTimeFilter = cell.timeString
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
        
        
        
        
        if let tabselect = defaults.object(forKey: UserDefaultsKeys.dashboardTapSelected) as? String, tabselect == "Flights" {
            
            
            if filterKey == "filter" {
                
                if minpricerangefilter.isZero == true && maxpricerangefilter.isZero == true{
                    let pricesFloat = prices.compactMap { Float($0) }
                    minpricerangefilter = Double(pricesFloat.min() ?? 0.0)
                    maxpricerangefilter = Double(pricesFloat.max() ?? 0.0)
                }
                
                delegate?.filtersByApplied(minpricerange:minpricerangefilter,maxpricerange: maxpricerangefilter,noofStopsArray: noOfStopsFilterArray, refundableTypeArray: refundablerTypeFilteArray, departureTime: departureTimeFilter,arrivalTime: arrivalTimeFilter, noOvernightFlight: noOvernightFlightFilterStr,airlinesFilterArray: airlinesFilterArray,connectingFlightsFilterArray: connectingFlightsFilterArray,ConnectingAirportsFilterArray: ConnectingAirportsFilterArray)
            }else {
                delegate?.filtersSortByApplied(sortBy: sortBy)
            }
            
            
            
            
            
        }else {
            
            if minpricerangefilter.isZero == true && maxpricerangefilter.isZero == true{
                let pricesFloat = prices.compactMap { Float($0) }
                minpricerangefilter = Double(pricesFloat.min() ?? 0.0)
                maxpricerangefilter = Double(pricesFloat.max() ?? 0.0)
            }
            
            delegate?.hotelFilterByApplied(minpricerange: minpricerangefilter,
                                           maxpricerange: maxpricerangefilter,
                                           starRating: starRatingFilter,
                                           refundableTypeArray: refundablerTypeFilteArray)
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
